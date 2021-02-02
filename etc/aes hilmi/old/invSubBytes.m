%Muhammad Dimas Yudha Adhi Pratama Jr
%1807422025
%CCIT Sec 5 

function s_out = invSubBytes(s_in)
%s_in = [0x19 0xa0 0x9a 0xe9; 0x3d 0xf4 0xc6 0xf8; 0xe3 0xe2 0x8d 0x48; 0xbe 0x2b 0x2a 0x08]

BS = 4;
load inverseSBox;

s_out = zeros(BS*BS, 1);

for i=1:BS
    for j=1:BS
        idx = uint16(s_in((i-1)*BS + j)) + 1; %+1 karena index sbox dimulai dari 1
        s_out((i-1)*BS + j) = inverseSBox(idx);
    end
end

%s_out=dec2hex(s_out);
s_out= reshape(s_out,4,4);
%for i=1:4
%  for j=1:4
%    s_out(i,j)=dec2hex(s_out(i,j));
%  end
%end
end
