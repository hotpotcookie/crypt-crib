function [keyNew] = keyScheduller(keyOld, n)
  
load SBox;
rcon=[1,2,4,8,16,32,64,128,27,54;
      0,0,0,0,0,0,0,0,0,0;
      0,0,0,0,0,0,0,0,0,0;
      0,0,0,0,0,0,0,0,0,0;
];
%key = [0x2b 0x28 0xab 0x09; 
##      0x7e 0xae 0xf7 0xcf; 
##      0x15 0xd2 0x15 0x4f; 
##      0x16 0xa6 0x88 0x3c
##];
%key = [0x2b 0x28 0xab 0x09; 0x7e 0xae 0xf7 0xcf; 0x15 0xd2 0x15 0x4f; 0x16 0xa6 0x88 0x3c ];
keyNew = zeros(4,4);
for i=1:4
  keyNew(i,1)=keyOld(mod(i,4)+1,4); %ambil dan langsung putar yang column terakhir
  
  keyNew(i,1)=SBox(keyNew(i,1)+1); %subbytes
  
  keyNew(i,1)=bitxor(bitxor(keyOld(i,1),rcon(i,n)),keyNew(i,1)); 

end

for j=2:4
  for i=1:4
    keyNew(i,j) = bitxor(keyNew(i,j-1),keyOld(i,j));
   end
end
  
endfunction
