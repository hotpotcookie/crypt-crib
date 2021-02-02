function output = SubBytes(mat_in)

% Hilmi Abdurrahman F (1807422008)
% CCIT SEC 5

panjang = 4;
sBox = hex2decarr(init_aesbox('fwd-sbox'));

output = zeros(panjang, panjang);

for i=1:panjang  %1
    for k=1:panjang  %1
        idx = mat_in((i-1)*panjang + k) + 1;
        output((i-1)*panjang + k) = sbox(idx);
    end
end

end
