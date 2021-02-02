%Muhammad Dimas Yudha Adhi Pratama Jr
%1807422025
%CCIT Sec 5 

function s_out = ShiftRows(s_in)

BS = 4;
s_out = zeros(4,4);


%s_out(1) = s_in(1); s_out(5) = s_in(5); s_out(9) = s_in(9); s_out(13) = s_in(13);%baris 1 tidak digeser
%s_out(2) = s_in(6); s_out(6) = s_in(10); s_out(10) = s_in(14); s_out(14) = s_in(2);
%s_out(3) = s_in(11); s_out(7) = s_in(14); s_out(11) = s_in(3); s_out(15) = s_in(7);
%s_out(4) = s_in(16); s_out(8) = s_in(4); s_out(12) = s_in(8); s_out(16) = s_in(12);

s_out(1,1) = s_in(1,1)   ; s_out(1,2) = s_in(1,2) ; s_out(1,3) = s_in(1,3) ; s_out(1,4) = s_in(1,4);
s_out(2,1) = s_in(2,2)   ; s_out(2,2) = s_in(2,3) ; s_out(2,3) = s_in(2,4) ; s_out(2,4) = s_in(2,1);
s_out(3,1) = s_in(3,3)   ; s_out(3,2) = s_in(3,4) ; s_out(3,3) = s_in(3,1) ; s_out(3,4) = s_in(3,2);
s_out(4,1) = s_in(4,4)   ; s_out(4,2) = s_in(4,1) ; s_out(4,3) = s_in(4,2) ; s_out(4,4) = s_in(4,3);
%s_out = reshape(s_out,4,4);

%s_out=dec2hex(s_out);

end