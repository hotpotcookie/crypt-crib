function [cipher] = mixColumn(plain)
m=[ 2,3,1,1;
  1,2,3,1;
  1,1,2,3;
  3,1,1,2;
];
cipher=zeros(4,4);
for i=1:4
  for j=1:4
    for k =1:4
      tmp = multiplicationGF28(plain(k,j),m(i,k));
      cipher(i,j) = bitxor(cipher(i,j),tmp);
    end  
  end
end

endfunction
