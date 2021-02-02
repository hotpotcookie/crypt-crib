function [plainout] = unAES(cipherin,key)
% Inverse AES
% Hilmi Abdurrahman Fakhrudin (1807422008)
% CCIT SEC 5
 
cipherin = double(cipherin);
key = double(key);

keytmp = key;
for i = 1:10
  keytmp = keyScheduller(keytmp,i);
  key = [key keytmp];
end

plainout=zeros(4,4);
key_split= key(:,41:44);
plainout = AddRoundKey(double(cipherin),double(key_split));
plainout = invShiftRows(plainout);
plainout = invSubBytes(plainout);
    
 for i=1:9
    key_split = key(:,4*(10-i)+1:4*(10-i)+4);
    plainout = reshape(plainout,4,4);
    plainout = AddRoundKey(double(plainout),double(key_split));
    plainout = invmixColumn(plainout);           
    plainout = invShiftRows(plainout);
    plainout = invSubBytes(plainout);
 end
 plainout = reshape(plainout,4,4);
 plainout = AddRoundKey(double(plainout),double(key(:,1:4)));
end