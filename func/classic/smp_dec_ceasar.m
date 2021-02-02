function [plain_return] = smp_dec_ceasar(cipher_str,n_shift)
	% // P = (C - K)mod26
	cipher_len = length(cipher_str);
	plain_return = '';
	catch_shift = '';
	for idx = 1:cipher_len
		if cipher_str(idx) == ' '
			plain_return = strcat(plain_return,{' '});
			continue
		end
		catch_shift = mod((double(cipher_str(idx)-65)-n_shift),26)+97;	
		plain_return = strcat(plain_return,char(catch_shift));	
	end
	plain_return = lower(char(plain_return));
end