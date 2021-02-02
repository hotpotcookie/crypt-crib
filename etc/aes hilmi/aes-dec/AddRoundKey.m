function output = AddRoundKey(mat_in,key)

% Hilmi Abdurrahman F (1807422008)
% CCIT SEC 5

output = bitxor(mat_in, key);

end