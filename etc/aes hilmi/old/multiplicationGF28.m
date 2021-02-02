function [out] = multiplicationGF28(data,m)
tmp = data;
out = tmp*mod(m,2);
cek = floor(m/2);
while cek>0
  tmp=tmp*2;
  if(tmp >= 256)
    tmp = bitxor(tmp-256,27);
  end
  out = bitxor(tmp*mod(cek,2),out);
  cek = floor(cek/2);
end
  
endfunction
