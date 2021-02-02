function [cipher_return] = func_enc_ceasar(plain_str,n_shift)
    % A : 65 -- 90
    % a : 97 -- 122
    % C = (P + K)mod26
    plain_str = lower(plain_str);
    to_ascii = double(plain_str);
    [x,y] = size(to_ascii);
    cipher_return = '';
    for indx = x:y
        to_shift = mod((n_shift+(to_ascii(indx)-97)),26)+65;        
        to_chars = char(to_shift);               
        if plain_str(indx) ~= ' '
            cipher_return = strcat(cipher_return,to_chars);
        else
            cipher_return = strcat(cipher_return,{' '});            
        end
    end
    cipher_return = char(cipher_return);
end