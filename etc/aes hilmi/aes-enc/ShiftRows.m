function output = ShiftRows(mat_in)

% Hilmi Abdurrahman F (1807422008)
% CCIT SEC 5

panjang = 4;
output = zeros(panjang,panjang);

output(1,1) = mat_in(1,1)   ; output(1,2) = mat_in(1,2) ; output(1,3) = mat_in(1,3) ; output(1,4) = mat_in(1,4);
output(2,1) = mat_in(2,2)   ; output(2,2) = mat_in(2,3) ; output(2,3) = mat_in(2,4) ; output(2,4) = mat_in(2,1);
output(3,1) = mat_in(3,3)   ; output(3,2) = mat_in(3,4) ; output(3,3) = mat_in(3,1) ; output(3,4) = mat_in(3,2);
output(4,1) = mat_in(4,4)   ; output(4,2) = mat_in(4,1) ; output(4,3) = mat_in(4,2) ; output(4,4) = mat_in(4,3);

end