function [sub_state] = func_aes_subbyte(r_state,sbox)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // ----------------------------
	% // [O] SUBTITUTE EACH CELL WITH SBOX
	% // ----------------------------
	% // r_state = (hexadecimal round state matrix 4x4)
	% // sbox = (sbox hexadecimal matrix 16x16)	

	cur_state = r_state;
	[x,y] = size(cur_state);
	for r = 1:x
		for c = 1:y
			char_sub = char(r_state(r,c));
			lft_most = hex2dec(char_sub(1:1))+1;
			rgt_most = hex2dec(char_sub(2:2))+1;
			sbox_sub = sbox(lft_most,rgt_most);
			cur_state(r,c) = sbox_sub;
		end
	end	

	cur_state = upper(cur_state);
	sub_state = cur_state;

end