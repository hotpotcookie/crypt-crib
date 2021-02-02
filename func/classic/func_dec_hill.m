function [cipher_return] = func_enc_hill(plain_str,key_str,n_mod)
	
	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // A : 65 -- 90
	% // a : 97 -- 122
	% // C = mod((P * K),26)
	% // P = mod((C * inverse(K)),26)
	% // perbedaan jumlah row maksimal 1, col harus sama
	% // array(baris,kolom)	

	% // pastikan kunci dan plaintext jadi lowercase
	key_str = lower(key_str);
	plain_str = lower(plain_str);	

	% // hapus spasi dari plain text dan key
	plain_space = '';
	[x,y] = size(plain_str);
	for idx = x:y
		if plain_str(idx) ~= ' '
			plain_space = strcat(plain_space,plain_str(idx));
		end
	end
	key_space = '';
	[x,y] = size(key_str);
	for idx = x:y
		if key_str(idx) ~= ' '
			key_space = strcat(key_space,key_str(idx));
		end
	end
	[a1,b1] = size(plain_space);
	[a2,b2] = size(key_space);

	% // tentukan luas matrix untuk plain text
	sqr_mtx = 0;
	sqr_inc = 2;
	for idx = 1:10
		sqr_mtx = sqr_inc^2;
		sqr_inc = sqr_inc + 1;
		if sqr_mtx >= b1
			break
		end
	end
	len_mtx = sqrt(sqr_mtx);

	% // ubah plain text dan key jadi bentuk matrix double
	mtx_plain = 0;
	inc = 1;
	for idx_r = 1:len_mtx
		for idx_c = 1:len_mtx
			if inc > b1
				mtx_plain(idx_r,idx_c) = double('z')-97;
				continue			
			end
			mtx_plain(idx_r,idx_c) = double(plain_space(inc))-97;
			inc = inc + 1;
		end
	end

	mtx_key = 0;
	inc = 1;
	for idx_r = 1:len_mtx
		for idx_c = 1:len_mtx
			if inc > b2
				mtx_key(idx_r,idx_c) = double('z')-97;
				continue			
			end
			mtx_key(idx_r,idx_c) = double(key_space(inc))-97;
			inc = inc + 1;
		end
	end

	% // ubdah key matrix mnenjadi bentuk invers
    get_det = round(mod(det(mtx_key),n_mod));
    if get_det ~= 0
        [get_gcd,s,t] = gcd(get_det,n_mod);
        get_inv = mod(round(inv(mtx_key)*det(mtx_key)*s),n_mod);        
	    mtx_key_inv = get_inv
    end

    if (get_det ~= 0) && (isequal(plain_str,'NaN') ~= 1)
		% // P = mod((C * inverse(K)),26)
		mtx_cipher = mod((mtx_plain * mtx_key_inv),n_mod);
		mtx_key_inv;
		mtx_decipher = mtx_cipher

		% // ubah mtx_cipher jadi bentuk string
		catch_mtx = '';
		cipher_return = '';
		for idx_r = 1:len_mtx
			for idx_c = 1:len_mtx
				catch_mtx = char((mtx_cipher(idx_r,idx_c))+97);
				cipher_return = strcat(cipher_return,catch_mtx);
			end
		end

		% // pakai spasi untuk cipher akhir
		cipher_return = char(cipher_return);
		cipher_space = cipher_return;
		catch_cipher = '';
		inc = 0;
		space_inc = 0;
		[x,y] = size(cipher_return);
		[a,b] = size(plain_str);
		for idx = x:y
			if idx <= b
				if plain_str(idx) == ' '
					space_inc = space_inc + 1;				
					catch_cipher = strcat(catch_cipher,{' '});
					continue
				end
				inc = inc + 1;			
				catch_cipher = strcat(catch_cipher,cipher_return(inc));
				continue
			end
			inc = inc + 1;		
			catch_cipher = strcat(catch_cipher,cipher_return(inc));
		end
		cipher_return = char(catch_cipher);
		[x,y] = size(cipher_space);
		[a,b] = size(cipher_return);
		real_len = y + space_inc;
		inc = y - space_inc;
		if real_len > b
			for idx = 1:real_len
				if inc < b;
					inc = inc + 1;
					cipher_return = strcat(cipher_return,cipher_space(inc));
				end
			end
		end
		cipher_return = char(cipher_return);

		% // hilangkan sisa z (tambahan pada matriks)		
		cipher_return = regexprep(cipher_return,'[z]','');
		cipher_return = char(cipher_return);
	else
        fprintf('\nmatrix key tidak memiliki bentuk invers\nberikut contoh yang bisa dipakai :');
        fprintf('\n- plain : "enkripsi ccit tmj"\n- key   : "cipher pascal"\n- mod   : 26\n');		
		cipher_return = NaN;
	end	

end