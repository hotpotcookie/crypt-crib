function [out] = multiplicationGF28(input,pembagi)
% Inverse GF8
% Hilmi Abdurrahman Fakhrudin (1807422008)
% CCIT SEC 5

out = input*mod(pembagi,2);
sisa = floor(pembagi/2);

while sisa > 0
  input=input*2;
  if(input >= 256)
    input = bitxor(input-256,27);
  end
  out = bitxor(input*mod(sisa,2),out);
  sisa = floor(sisa/2);
end
  
end
