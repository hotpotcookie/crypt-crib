function [cipher_return] = func_dec_hill_brute(plain_mtx,cipher_mtx,n_mod)
	
	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // A : 65 -- 90
	% // a : 97 -- 122
	% // C = mod((P * K),26)
	% // P = mod((C * inverse(K)),26)
	% // perbedaan jumlah row maksimal 1, col harus sama
	% // array(baris,kolom)	
	% // K = mod((P^-1 * C),31))

	% // ubdah key matrix mnenjadi bentuk invers
    get_det = round(mod(det(plain_mtx),n_mod));
    if get_det ~= 0
        [get_gcd,s,t] = gcd(get_det,n_mod);
        get_inv = mod(round(inv(plain_mtx)*det(plain_mtx)*s),n_mod);        
	    mtx_plain_inv = get_inv
	    cipher_mtx
    end

    if get_det ~= 0
		% // K = mod((P^-1 * C),31))
		mtx_key = mod((mtx_plain_inv * cipher_mtx),n_mod)
		[c,d] = size(mtx_key);
		len_mtx = c;

		% // ubah mtx_cipher jadi bentuk string
		catch_mtx = '';
		cipher_return = '';
		for idx_r = 1:len_mtx
			for idx_c = 1:len_mtx
				catch_mtx = char((mtx_key(idx_r,idx_c))+65);
				cipher_return = strcat(cipher_return,catch_mtx);
			end
		end
		cipher_return = mtx_key;
	else
        fprintf('\nmatrix key tidak memiliki bentuk invers\nberikut contoh yang bisa dipakai :');
        fprintf('\n- plain : "enkripsi ccit tmj"\n- key   : "cipher pascal"\n- mod   : 26\n');		
		cipher_return = NaN;
	end	

end