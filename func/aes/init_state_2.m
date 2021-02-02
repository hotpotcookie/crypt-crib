function [in_state] = init_state_2(plain_str)
	
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
	fix_len = 16;
	len_plain = length(plain_str);
	for idx = 1:len_plain
		if (plain_str(idx) == ' ')
			continue
		end
		char_ctr = char_ctr + 1;
		nospc_plain = strcat(nospc_plain,plain_str(idx));
	end

	if mod(length(nospc_plain),16) ~= 0
		fix_len = char_ctr + (16-(mod(char_ctr,16)));
	else
		fix_len = length(nospc_plain)
	end

	for i = 1:fix_len
		if i > length(nospc_plain)
			nospc_plain = strcat(nospc_plain,'Z');
			continue	
		end		
	end

	nospc_plain
	char_ctr = 1;
	mtx_plain = {''};
	itr = fix_len/16;
	y = 0;
	for x = 1:itr 
		for r = 1:4
			for c = 1:4
				mtx_plain(r,c+y) = {dec2hex(uint8(nospc_plain(char_ctr)))};
				char_ctr = char_ctr + 1;
			end
		end
		y = y + 4;
	end

	in_state = mtx_plain;

end
