function [plain_return] = smp_dec_affine(cipher_str,n_multi,n_shift)
	% // P = ((C - KS) X KM')mod26 
	cipher_len = length(cipher_str);
	plain_return = '';
	catch_mulshft = '';
	get_det = round(mod(det(n_multi),26));
	if get_det ~= 0
		[get_gcd,s,t] = gcd(get_det,26);
		get_inv = mod(round(inv(n_multi)*det(n_multi)*s),26);        
		for idx = 1:cipher_len
			if cipher_str(idx) == ' '
				plain_return = strcat(plain_return,{' '});
				continue
			end
			catch_mulshft = mod(((double(cipher_str(idx))-65-n_shift)*get_inv),26)+97;
			plain_return = strcat(plain_return,char(catch_mulshft));
		end
		plain_return = char(plain_return);
	else
		plain_return = NaN;
	end
end