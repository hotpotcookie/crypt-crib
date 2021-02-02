function [shift_state] = func_aes_shiftrows(r_state,method_str)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // ----------------------------
	% // [O] ROW 2 : ALL COL -1
	% // [O] ROW 3 : ALL COL -2
	% // [O] ROW 4 : ALL COL -3
	% // [O] IF COL < 0 ~ COL = 4
	% // ----------------------------	
	% // r_state = (hexadecimal round state matrix 4x4)
	% // method_str = (string) ['fwd','inv']

	cur_state = r_state;
	[x,y] = size(cur_state);
	get_row = cell(1,4);
	inc_ctr = 0;
	for r = 1:x
		inc_ctr = inc_ctr + 1;
		for c = 1:y
			if inc_ctr > 1;
				switch method_str
					case 'fwd'
						shift = inc_ctr - 1;
						new_c = c - shift;
						if new_c < 1
							new_c = 4 + new_c;
						end
						get_row(:,new_c) = r_state(r,c);
					case 'inv'
						shift = inc_ctr;
						new_c = c + shift - 1;
						if new_c > 4
							new_c = new_c - 4;
						end
						get_row(:,new_c) = r_state(r,c);					
					otherwise
						fprintf('---\navailable options :\n1. fwd\n2. inv\n---');
						shift_state = NaN;
						return
				end
			end
		end
		if r > 1
			cur_state(r,:) = get_row;
		end
	end

	shift_state = cur_state;

end