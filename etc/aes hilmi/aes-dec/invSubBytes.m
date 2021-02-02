function mat_out = invSubBytes(mat_in)
% Inverse SubBytes
% Hilmi Abdurrahman Fakhrudin (1807422008)
% CCIT SEC 5

panjang = 4;
load inverseSBox;

mat_out = zeros(panjang*panjang, 1);

for i=1:panjang
    for j=1:panjang
        idx = uint16(mat_in((i-1)*panjang + j)) + 1;
        mat_out((i-1)*panjang + j) = inverseSBox(idx);
    end
end

end
