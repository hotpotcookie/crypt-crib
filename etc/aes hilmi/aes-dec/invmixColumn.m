function [plainout] = invmixColumn(cipher)
% Inverse Mix Column
% Hilmi Abdurrahman Fakhrudin (1807422008)
% CCIT SEC 5

invm = init_aesbox('inv-mcon');
invm = hex2decarr(invm);
    
plainout=zeros(4,4);

for i=1:4
  for j=1:4
    for k =1:4
%       disp("i="+i+" | j="+j+" | K="+k);
%       disp("plain("+k+","+j+") = "+plain(k,j));
%       disp("invm("+i+","+k+") = "+invm(i,k));
      gf8res = multiplicationGF28(double(cipher(k,j)),double(invm(i,k)));
      plainout(i,j) = bitxor(plainout(i,j),gf8res);
    end  
  end
end

end
