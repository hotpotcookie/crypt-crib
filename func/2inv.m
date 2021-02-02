function [inverse_return] = func_inverse(in_mtx,in_mod)

    get_det = round(mod(det(in_mtx),in_mod))
    if get_det ~= 0
        [get_gcd,s,t] = gcd(get_det,in_mod);
        get_inv = mod(round(inv(in_mtx)*det(in_mtx)*s),in_mod);        
    end
    inverse_return = get_inv;
end