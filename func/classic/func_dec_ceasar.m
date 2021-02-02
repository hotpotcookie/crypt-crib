function [plain_return] = func_dec_ceasar(cipher_str,n_shift)
    % A : 65 -- 90
    % a : 97 -- 122
    % C = (P - K)mod26    
    to_ascii = double(cipher_str);
    [x,y] = size(to_ascii);
    plain_return = '';
    for indx = x:y
        to_shift = mod(((to_ascii(indx)-65)-n_shift),26)+97;        
        to_chars = char(to_shift);               
        if cipher_str(indx) ~= ' '
            plain_return = strcat(plain_return,to_chars);
        else
            plain_return = strcat(plain_return,{' '});            
        end
    end
    plain_return = char(plain_return);
end