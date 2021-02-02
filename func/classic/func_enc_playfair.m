function [cipher_return] = func_enc_playfair(plain_str)
	
	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // A : 65 -- 90
	% // a : 97 -- 122
	% // huruf selanjutnya dabel, tambah 'x'
	% // huruf terakir, tambah 'x'    
	% // huruf spasi, jadiin 'z'

	key_arr = ['L','G','D','B','A';'Q','M','H','E','C';'U','R','N','I','F';'X','V','S','O','K';'Z','Y','W','T','P'];
	to_ascii = double(plain_str);
	[x,y] = size(to_ascii);
	z = x;
	cipher_return = '';
	brd = 2;
	inc = 0;

	for indx = x:y
		if inc == brd
			brd = brd + 2;
			cipher_return = strcat(cipher_return,{' '});            
		end
		inc = inc + 1;
		cipher_return = strcat(cipher_return,char(to_ascii(indx))); 
		if char(to_ascii(indx)) == ' '
			cipher_return = strcat(cipher_return,'z');
		end
		if indx < y
			if mod(inc,2) ~= 0            
				if char(to_ascii(indx)) == char(to_ascii(indx+1))
					inc = inc + 1;
					cipher_return = strcat(cipher_return,'x');
				end
			end
		end
		if indx == y
			if mod(inc,2) ~= 0
				cipher_return = strcat(cipher_return,'x');
			end
		end
	end

	% // array(baris,kolom)
	% // kalau 2 huruf ada di kolom sama, semua huruf ke bawah 1 baris. mentok ke atas
	% // kalau 2 huruf ada di baris sama, semua huruf ke kanan 1 kolom. mentok ke kiri
	% // kalau beda semua, masing masing huruf geser ke kolom pasangannya

	cipher_return = char(cipher_return);
	catch_cipher1 = cipher_return;
	to_ascii2 = double(cipher_return);
	new_ascii2 = to_ascii2;
	cipher_return = '';
	x = 0; y = 0;
	[x,y] = size(to_ascii2);
	[a,b] = size(key_arr);
	frs_char = '';
	sec_char = '';
	row_1 = 0; col_1 = 0;
	row_2 = 0; col_2 = 0;
	col_x = 0;
	check_in = '';
	brd = 2;
	inc = 0;

	for indx2 = x:y
		if char(to_ascii2(indx2)) == ' '
			cipher_return = strcat(cipher_return,{' '});            
			brd = brd + 2;            
			continue
		end        
		if char(to_ascii2(indx2)) == 'j'       
			to_ascii2(indx2) = double('i'); 
		end
		inc = inc + 1;        
		new_ascii2(indx2) = (to_ascii2(indx2)-97)+65;
		for row = 1:a
			for col = 1:b
				if char(new_ascii2(indx2)) == key_arr(row,col); 
					if mod(inc,2) ~= 0
						row_1 = row;
						col_1 = col;
					else
						row_2 = row;
						col_2 = col;
					end
				end
			end
		end
		if inc == brd
			if col_1 == col_2
			% // kalau 2 huruf ada di kolom yang sama                
				row_1 = row_1 + 1;
				row_2 = row_2 + 1;
				if row_1 > 5
					row_1 = 1;
				end
				if row_2 > 5
					row_2 = 1;
				end
				frs_char = key_arr(row_1,col_1);
				sec_char = key_arr(row_2,col_2);                
			elseif row_1 == row_2
			% // kalau 2 huruf ada di baris yang sama                
				col_1 = col_1 + 1;
				col_2 = col_2 + 1;
				if col_1 > 5
					col_1 = 1;
				end
				if col_2 > 5
					col_2 = 1;
				end
				frs_char = key_arr(row_1,col_1);
				sec_char = key_arr(row_2,col_2);                                
			else
			% // kalau 2 huruf bersebrangan semua 
				col_x = col_1;
				col_1 = col_2;
				col_2 = col_x;
				frs_char = key_arr(row_1,col_1);
				sec_char = key_arr(row_2,col_2);                                                
			end            
			cipher_return = strcat(cipher_return,frs_char);
			cipher_return = strcat(cipher_return,sec_char);                        
		end
	end

	% // kembaliin ke string awal tanpa spasi
	
	cipher_return = char(cipher_return);
	catch_cipher2 = '';
	x = 0; y = 0; inc = 1;
	[x,y] = size(cipher_return);    

	for indx3 = x:y
		if cipher_return(indx3) ~= ' '
			if indx3 < y
				if ((catch_cipher1(indx3) == 'z')) && ((catch_cipher1(indx3+1)) ~= ' ')
					catch_cipher2 = strcat(catch_cipher2,{' '});
					catch_cipher2 = strcat(catch_cipher2,cipher_return(indx3));
					continue
				elseif ((catch_cipher1(indx3) == 'z')) && ((catch_cipher1(indx3+1)) == ' ')	
					catch_cipher2 = strcat(catch_cipher2,cipher_return(indx3));
					catch_cipher2 = strcat(catch_cipher2,{' '});
					continue
				else
				end
			end
			catch_cipher2 = strcat(catch_cipher2,cipher_return(indx3));								
		end
	end
	cipher_return = char(catch_cipher2);
end