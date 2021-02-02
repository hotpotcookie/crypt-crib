function mat_out = invShiftRows(mat_in)
% Inverse Shift Rows
% Hilmi Abdurrahman Fakhrudin (1807422008)
% CCIT SEC 5

mat_out = zeros(4,4);

mat_out(1,1) = mat_in(1,1)   ; mat_out(1,2) = mat_in(1,2) ; mat_out(1,3) = mat_in(1,3) ; mat_out(1,4) = mat_in(1,4);
mat_out(2,1) = mat_in(2,4)   ; mat_out(2,2) = mat_in(2,1) ; mat_out(2,3) = mat_in(2,2) ; mat_out(2,4) = mat_in(2,3);
mat_out(3,1) = mat_in(3,3)   ; mat_out(3,2) = mat_in(3,4) ; mat_out(3,3) = mat_in(3,1) ; mat_out(3,4) = mat_in(3,2);
mat_out(4,1) = mat_in(4,2)   ; mat_out(4,2) = mat_in(4,3) ; mat_out(4,3) = mat_in(4,4) ; mat_out(4,4) = mat_in(4,1);

end