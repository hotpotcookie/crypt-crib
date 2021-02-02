function [cipher_return] = smp_enc_affine(plain_str,n_multi,n_shift)
	% // C = ((P + KS) X KM)mod26 
	plain_str = lower(plain_str);
	plain_len = length(plain_str);
	cipher_return = '';
	catch_mulshft = '';
    get_det = round(mod(det(n_multi),26));
    if get_det ~= 0
        [get_gcd,s,t] = gcd(get_det,26);
        get_inv = mod(round(inv(n_multi)*det(n_multi)*s),26);        
        for idx = 1:plain_len
        	if plain_str(idx) == ' '
        		cipher_return = strcat(cipher_return,{' '});
        		continue
       		end
       		catch_mulshft = mod(((double(plain_str(idx))-97)*n_multi)+n_shift,26)+65;
       		cipher_return = strcat(cipher_return,char(catch_mulshft));
       	end
       	cipher_return = char(cipher_return);
    else
    	cipher_return = NaN;
    end
end