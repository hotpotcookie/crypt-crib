function [keyschd_state] = func_aes_keyscheduller(k_state,sbox,rcon,round,method_str)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // ----------------------------
	% // [O] LAST COLUMN, SWAP ROW -1
	% // [O] OPERASI SUBBYTE
	% // [O] COL1 XOR CURR_COL XOR RCON_COL1 = NEW_COL1
	% // [O] COL2 XOR NEW_COL1 = NEW_COL2
	% // ----------------------------
	% // round = (double)
	% // k_state = (hexadecimal key state matrix 4x4)
	% // sbox = (sbox hexadecimal matrix 16x16)
	% // rcon = (rcon hexadecimal matrix 4x10)

	cur_state = k_state;
	new_state = cur_state;
	[x,y] = size(cur_state);
	new_row = {'0';'0';'0';'0'};

	switch method_str
		case 'fwd'
			shift_row = 1;
			for r = 1:x
				cur_row = r - shift_row;
				if cur_row < 1
					cur_row = 4;
				end
				new_row(cur_row,:) = k_state(r,4);
			end
			%new_row
			new_row = func_aes_subbyte(new_row,sbox);

			for i = 1:x
				a = k_state(:,i);
				if i == 1
					b = new_row;
					c = rcon(:,round);
					z = bitxor(bitxor(hex2dec(a),hex2dec(b)),hex2dec(c));
					z = dec2hex(z);
					for j = 1:x
						cur_state(j,i) = {z(j,:)};				
					end
					continue
				end
				b = cur_state(:,i-1);
				z = bitxor(hex2dec(a),hex2dec(b));
				z = dec2hex(z);
				for j = 1:x
					cur_state(j,i) = {z(j,:)};				
				end
			end
		case 'inv'
			catch_key = k_state;
			inv_round = 10 - round;
			for i = 1:inv_round
				catch_key = func_aes_keyscheduller(catch_key,sbox,rcon,i,'fwd');
			end
			cur_state = catch_key;
	end


	keyschd_state = cur_state;

end