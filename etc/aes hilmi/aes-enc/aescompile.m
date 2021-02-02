function [output] = aescompile(plain,key)
% AES-128
% Hilmi Abdurrahman Fakhrudin (1807422008)
% CCIT SEC 5

% XOR dengan KEY
output = AddRoundKey(plain,key);
% disp("Start");
% disp(dec2hex(output));

for i=1:9
    output = SubBytes(output);
    output = ShiftRows(output);
    output = mixColumn(output);
    key = keyScheduller(key, i);
    output = AddRoundKey(output, key);
%     disp("Round "+i);
%     disp(dec2hex(output));
end

output = SubBytes(output);
output = ShiftRows(output);
key = keyScheduller(key, 10);
output = AddRoundKey(output, key); 

end

