function [key_out] = keyScheduller(key_in, round)
% Inverse KeyScheduller
% Hilmi Abdurrahman Fakhrudin (1807422008)
% CCIT SEC 5

load SBox;


rcon=[1,2,4,8,16,32,64,128,27,54;
      0,0,0,0,0,0,0,0,0,0;
      0,0,0,0,0,0,0,0,0,0;
      0,0,0,0,0,0,0,0,0,0;
];

key_out = zeros(4,4);

for i=1:4
  key_out(i,1)=key_in(mod(i,4)+1,4); 
  key_out(i,1)=SBox(key_out(i,1)+1); 
  key_out(i,1)=bitxor(bitxor(key_in(i,1),rcon(i,round)),key_out(i,1)); 
end

for j=2:4
  for i=1:4
    key_out(i,j) = bitxor(key_out(i,j-1),key_in(i,j));
   end
end

end
