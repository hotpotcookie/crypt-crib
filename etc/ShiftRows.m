function s_out = ShiftRows(s_in)

BS = 4;
s_out = uint8(zeros(BS*BS, 1));

s_out(1) = s_in(1); s_out(2) = s_in(2); s_out(3) = s_in(3); s_out(4) = s_in(4);
s_out(5) = s_in(6); s_out(6) = s_in(7); s_out(7) = s_in(8); s_out(8) = s_in(5);
s_out(9) = s_in(11); s_out(10) = s_in(12); s_out(11) = s_in(9); s_out(12) = s_in(10);
s_out(13) = s_in(16); s_out(14) = s_in(13); s_out(15) = s_in(14); s_out(16) = s_in(15);

end