
function cipher = unAES(plain,key)
 %plain harus dalam matrix 4x4, dam dalam bentuk hexadecimal
 


for i= 1:10
 key = keyScheduller(key,i);
 listkey= [key];
end

cipher=zeros(4,4);

cipher = AddRoundKey(plain,listkey(10));
cipher = ShiftRows(cipher);
cipher = SubBytes(cipher);
 
 for i=1:9

    %key = keyScheduller(key,i);
    cipher = AddRoundKey(cipher,listkey(i));
    cipher = invmixColumn(cipher);           
    cipher = invShiftRows(cipher);
    cipher = invSubBytes(cipher);
 end
 cipher = AddRoundKey(plain,key);
endfunction

