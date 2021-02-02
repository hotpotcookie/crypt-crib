function cipher = AES(plain,key)
 %plain harus dalam matrix 4x4, dam dalam bentuk hexadecimal
 cipher = AddRoundKey(plain,key);
 for i=1:9
    cipher = SubBytes(cipher);
##    disp("SubBytes");
##    disp(dec2hex(cipher));
    cipher = ShiftRows(cipher);
##    disp("ShiftRows");
##    disp(dec2hex(cipher));
    cipher = mixColumn(cipher);
##    disp("mixColumn");
##    disp(dec2hex(cipher));
    key = keyScheduller(key,i);
    cipher = AddRoundKey(cipher,key);    
##    disp("cipher");
##    disp(dec2hex(cipher));
 end
 cipher = SubBytes(cipher);
 cipher = ShiftRows(cipher);
 key = keyScheduller(key,10);
 cipher = AddRoundKey(cipher,key);    
 
endfunction
