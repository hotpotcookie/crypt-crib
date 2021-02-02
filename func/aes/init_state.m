function [in_state] = init_state(plain_str)
	
	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // ----------------------------
	% // [O] REMOVE WHITEPACES
	% // [O] CONVERT PLAIN TO ARRAY
	% // [O] EACH CHAR == HEX2DEC
 	% // in_state = {'32','88','31','E0';'43','5A','31','37';'F6','30','98','07';'A8','8D','A2','34'}
 	% // rk_state = {'2B','28','AB','09';'7E','AE','F7','CF';'15','D2','15','4F';'16','A6','88','3C'}
 	% // mixcolmn = {'d4','e0','b8','1e';'bf','b4','41','27';'5d','52','11','98';'30','ae','f1','e5'}
	% // ----------------------------
	% // plain_str = (string)

	plain_str = upper(plain_str);
	sub_state = '';
	nospc_plain = '';
	char_ctr = 0;
	len_plain = length(plain_str);
	for idx = 1:len_plain
		if (plain_str(idx) == ' ') || (char_ctr >= 16)
			continue
		end
		char_ctr = char_ctr + 1;
		nospc_plain = strcat(nospc_plain,plain_str(idx));
	end

	char_ctr = 1;
	len_plain = length(nospc_plain);	
	mtx_plain = {''};
	for r = 1:4
		for c = 1:4
			if char_ctr > len_plain
				mtx_plain(r,c) = {dec2hex(uint8('Z'))};
				continue	
			end
			mtx_plain(r,c) = {dec2hex(uint8(nospc_plain(char_ctr)))};
			char_ctr = char_ctr + 1;
		end
	end	

	in_state = mtx_plain;

end
