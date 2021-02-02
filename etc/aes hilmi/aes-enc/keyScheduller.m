function [keyNew] = keyScheduller(key, round)

% KeyScheduller
% Hilmi Abdurrahman F (1807422008)
% CCIT SEC 5

load SBox;


rcon=[1,2,4,8,16,32,64,128,27,54;
      0,0,0,0, 0, 0, 0,  0, 0, 0;
      0,0,0,0, 0, 0, 0,  0, 0, 0;
      0,0,0,0, 0, 0, 0,  0, 0, 0];

keyNew = zeros(4,4);
for i=1:4
  keyNew(i,1) = key(mod(i,4)+1,4); 
  keyNew(i,1) = SBox(keyNew(i,1)+1); 
  keyNew(i,1) = bitxor(bitxor(key(i,1),rcon(i,round)),keyNew(i,1)); 
end

for j=2:4
  for i=1:4
    keyNew(i,j) = bitxor(keyNew(i,j-1),key(i,j));
   end
end

end
