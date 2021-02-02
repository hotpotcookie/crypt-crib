function hasil = add_roundkey(state,roundkey)
% rk1 = [160,136,35,42;250,84,163,108;254,44,57,118;23,177,57,5]
% ans = hasil dari mix_column
% add_roundkey(ans,rk1)

for i = 1:4
    for x = 1:4
        new_key = bitxor(bit_matrix(state(i,x)),bit_matrix(roundkey(i,x)));
        state(i,x) = bin2dec(num2str(new_key));
    end
end
hasil = state;
end

