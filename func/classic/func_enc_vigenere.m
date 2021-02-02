function [cipher_return] = func_enc_vigenere(plain_str,key_str)
	
	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // A : 65 -- 90
	% // a : 97 -- 122
	% // char(mod(((double('e')-97)+(double('s')-97)),26)+65)

	% // pastikan kunci menjadi lowercase
	key_lower = lower(key_str);
	plain_lower = lower(plain_str);

	% // hilangin spasi dari plain text
	catch_plain = plain_lower;
	plain_space = '';
	[x,y] = size(catch_plain);
	for idx = x:y
		if catch_plain(idx) ~= ' '
			plain_space = strcat(plain_space,catch_plain(idx));
		end
	end

	% // panjang kunci == panjang plain text
	[x,y] = size(plain_space);
	[a,b] = size(key_lower);
	key_combine = '';
	key_resize = '';
	for idx = a:b
		if key_lower(idx) ~= ' '		
			key_combine = strcat(key_combine,key_lower(idx));
		end
	end
	key_combine = char(key_combine);	
	for idx = x:y
		key_resize = strcat(key_resize,key_combine(idx));
	end

	% // Cipher = Plain.i + Key.i
	[x,y] = size(plain_space);
	cipher_return = '';
	for idx = x:y
		shift = char(mod(((double(plain_space(idx))-97)+(double(key_resize(idx))-97)),26)+65);
		cipher_return = strcat(cipher_return,shift);
	end

	% // tambah spasi sebagai cipher utuh
	cipher_return = char(cipher_return);	
	catch_cipher = cipher_return;
	catch_plain2 = plain_lower;
	cipher_return = '';
	inc = 1;
	[x,y] = size(catch_plain2);
	for idx = x:y
		if catch_plain2(idx) == ' '
			cipher_return = strcat(cipher_return,{' '});
			continue
		end
		cipher_return = strcat(cipher_return,catch_cipher(inc));
		inc = inc + 1;
	end
	cipher_return = char(cipher_return);
end