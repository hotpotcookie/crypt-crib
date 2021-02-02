function [mtx_char] = dec2chararr(mtx_dec)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // ----------------------------
	% // [o] CHAR ARR SIZE = DEC ARR SIZE

	[x,y] = size(mtx_dec);
	temp_mtx = [''];
	for r = 1:x
		for c = 1:y
			temp_hex = char(((mtx_dec(r,c))));
			temp_mtx(r,c) = temp_hex;
		end
	end
	mtx_char = temp_mtx;

end