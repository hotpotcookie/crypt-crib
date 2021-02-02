function cipher = unAES(plain,key)
 %plain harus dalam matrix 4x4, dam dalam bentuk hexadecimal
 
##listkey = zeros(10,1);

##for i= 1:10
## key = keyScheduller(key,i);
## listkey(i)= key;
##end
tmp = key;
for i = 1:10
  tmp = keyScheduller(tmp,i);
  key = [key tmp];
end


cipher=zeros(4,4);
keye= key(:,41:44);
cipher = AddRoundKey(plain,keye);
cipher = ShiftRows(cipher);
cipher = SubBytes(cipher);
 
 for i=1:9

    %key = keyScheduller(key,i);
    keye = key(:,4*(10-i)+1:4*(10-i)+4);
    cipher = AddRoundKey(cipher,keye);
    cipher = invmixColumn(cipher);           
    cipher = invShiftRows(cipher);
    cipher = invSubBytes(cipher);
 end
 cipher = AddRoundKey(cipher,key(:,1:4));
endfunction