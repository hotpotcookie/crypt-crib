function [cipher_return] = smp_enc_ceasar(plain_str,n_shift)
	% // C = (P + K)mod26
	plain_str = lower(plain_str);
	plain_len = length(plain_str);
	cipher_return = '';
	catch_shift = '';
	for idx = 1:plain_len
		if plain_str(idx) == ' '
			cipher_return = strcat(cipher_return,{' '});
			continue
		end
		catch_shift = mod((double(plain_str(idx)-97)+n_shift),26)+65;	
		cipher_return = strcat(cipher_return,char(catch_shift));	
	end
	cipher_return = upper(char(cipher_return));
end