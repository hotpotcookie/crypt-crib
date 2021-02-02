function [mtx_dec] = char2decarr(mtx_char)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // ----------------------------
	% // [o] CHAR ARR SIZE = DEC ARR SIZE

	[x,y] = size(mtx_char);
	temp_mtx = [0];
	for r = 1:x
		for c = 1:y
			temp_hex = double(((mtx_char(r,c))));
			temp_mtx(r,c) = temp_hex;
		end
	end
	mtx_dec = temp_mtx;

end