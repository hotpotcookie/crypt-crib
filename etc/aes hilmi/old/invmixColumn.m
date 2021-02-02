function [cipher] = invmixColumn(plain)
## invm = ["0e","0b","0d","09";
##  "09","0e","0b","0d";
##  "0d","09","0e","0b";
##  "0b","0d","09","0e";
##];
invm = [0x0e,0x0b,0x0d,0x09;
  0x09,0x0e,0x0b,0x0d;
  0x0d,0x09,0x0e,0x0b;
  0x0b,0x0d,0x09,0x0e;
];
cipher=zeros(4,4);
for i=1:4
  for j=1:4
    for k =1:4
      tmp = multiplicationGF28(plain(k,j),invm(i,k));
      %212,2
      cipher(i,j) = bitxor(cipher(i,j),tmp);
    end  
  end
end

end
