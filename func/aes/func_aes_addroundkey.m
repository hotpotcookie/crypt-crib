function [addround_state] = func_aes_addroundkey(r_state,k_state)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // ----------------------------
	% // [O] BIT XOR EACH BOTH CELL
	% // ----------------------------	
	% // r_state = (hexadecimal round state matrix 4x4)
	% // k_state = (hexadecimal key state matrix 4x4)

	cur_state = r_state;
	[x,y] = size(cur_state);
	for r = 1:x
		for c = 1:y
			r_byte = (hex2dec(r_state(r,c)));
			k_byte = (hex2dec(k_state(r,c)));
			x_cell = dec2hex(bitxor(r_byte,k_byte));
			if length(x_cell) == 1
				x_cell =  strcat('0',x_cell);
			end
			cur_state(r,c) = {x_cell};			
		end
	end

	cur_state = upper(cur_state);
	addround_state = cur_state;

end