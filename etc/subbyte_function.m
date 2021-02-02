function hasil = subbyte_function(subbyte,sbox)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
for i = 1:16
    new_key = sbox(subbyte(i) + 1);
    subbyte(i) = new_key;
end
hasil = reshape(subbyte,[4,4]);


