function [cipher_return] = func_enc_playfair(cipher_str)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // A : 65 -- 90
	% // a : 97 -- 122

	key_arr = ['l','g','d','b','a';'q','m','h','e','c';'u','r','n','i','f';'x','v','s','o','k';'z','y','w','t','p'];
	to_ascii = double(cipher_str);
	[x,y] = size(to_ascii);
	z = x;
	cipher_return = '';
	brd = 2;
	inc = 0;

	for indx = x:y
		if char(to_ascii(indx)) ~= ' '
			if inc == brd
				brd = brd + 2;
				cipher_return = strcat(cipher_return,{' '});            
			end
			inc = inc + 1;
			cipher_return = strcat(cipher_return,char(to_ascii(indx))); 
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
		inc = inc + 1;        
		new_ascii2(indx2) = (to_ascii2(indx2)-65)+97;
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
				row_1 = row_1 - 1;
				row_2 = row_2 - 1;
				if row_1 < 1
					row_1 = 5;
				end
				if row_2 < 1
					row_2 = 5;
				end
				frs_char = key_arr(row_1,col_1);
				sec_char = key_arr(row_2,col_2);                
			elseif row_1 == row_2
			% // kalau 2 huruf ada di baris yang sama                
				col_1 = col_1 - 1;
				col_2 = col_2 - 1;
				if col_1 < 1
					col_1 = 5;
				end
				if col_2 < 1
					col_2 = 5;
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
		if ((cipher_return(indx3) ~= ' ')) && ((cipher_return(indx3) ~= 'x'))
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

	% // huruf selanjutnya dabel, tambah 'x' | hilangkan x
	% // huruf terakir, tambah 'x'           | hilangkan x
	% // huruf spasi, jadiin 'z'             | ubah z jadi spasi kembali

	cipher_return = char(catch_cipher2);
	catch_cipher3 = '';
	x = 0; y = 0;
	[x,y] = size(cipher_return);

	for indx4 = x:y
		if cipher_return(indx4) ~= 'x'
			if cipher_return(indx4) == 'z'
				catch_cipher3 = strcat(catch_cipher3,{' '});
			else
				catch_cipher3 = strcat(catch_cipher3,cipher_return(indx4));				
			end
		end
	end
	cipher_return = char(catch_cipher3);

end