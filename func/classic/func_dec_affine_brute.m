function [plain_return] = func_dec_affine_brute(cipher_str,n_multi,n_shift)
    inv_multi = 1;
    for i = 1:100
        inv_multi = inv_multi + 26;
        r = rem(inv_multi,n_multi);
        if r == 0            
            n_multi = (inv_multi/n_multi)
            for idx = n_shift:25
                n_shift = n_shift + 1
                to_ascii = double(cipher_str);
                [x,y] = size(to_ascii);
                plain_return = '';
                for indx = x:y
                    to_multi = mod((n_multi*(to_ascii(indx)-65-n_shift)),26)+97;
                    to_chars = char(to_multi);
                    if cipher_str(indx) ~= ' '
                        plain_return = strcat(plain_return,to_chars);
                    else
                        plain_return = strcat(plain_return,{' '});            
                    end
                end
                plain_return = char(plain_return)
                n_shift = n_shift + 1                
            end
        end
    end  
end

% // CIPHER JXIX RVKJXIT WYXTKUVSU RVKHHNKXFXK XKXYTBTB BUXUTBUTF
% // KEY MULTI : 11
% // KEY ADDIT : 23
