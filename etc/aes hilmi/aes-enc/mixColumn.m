function [cipher] = mixColumn(plain)

% MixColumn
% Hilmi Abdurrahman F (1807422008)
% CCIT SEC 5

m=[ 2,3,1,1;
    1,2,3,1;
    1,1,2,3;
    3,1,1,2];

for i=1:4
  for j=1:4
    cipher(i,j)=0;
    for k =1:4
      hasilgf8 = multiplicationGF28(plain(k,j),m(i,k));
      cipher(i,j) = bitxor(cipher(i,j),hasilgf8);
    end  
  end
end

end
