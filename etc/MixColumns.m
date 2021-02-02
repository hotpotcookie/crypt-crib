function s_out = MixColumns(s_in)

BS = 4;
s_out = uint8(zeros(BS*BS, 1));
e = uint8(zeros(BS, 1));

a = s_in;
b = bitshift (s_in, 1);
c = bitget(s_in, BS*2);
d = bitxor(b, c*hex2dec('1b')); % s_in * 2

for i = 1:BS
    e(i) = bitxor(bitxor(a((1-1)*BS + i), a((2-1)*BS + i)), bitxor(a((3-1)*BS + i), a((4-1)*BS + i)));
    s_out((1-1)*BS + i) = bitxor(bitxor(e(i), a((1-1)*BS + i)), bitxor(d((1-1)*BS + i), d((2-1)*BS + i)));
    s_out((2-1)*BS + i) = bitxor(bitxor(e(i), a((2-1)*BS + i)), bitxor(d((2-1)*BS + i), d((3-1)*BS + i)));
    s_out((3-1)*BS + i) = bitxor(bitxor(e(i), a((3-1)*BS + i)), bitxor(d((3-1)*BS + i), d((4-1)*BS + i)));
    s_out((4-1)*BS + i) = bitxor(bitxor(e(i), a((4-1)*BS + i)), bitxor(d((4-1)*BS + i), d((1-1)*BS + i)));
end

end