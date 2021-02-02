function [mtx_dec] = hex2dec(mtx_hex)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // ----------------------------
	% // [o] HEX ARR SIZE = DEC ARR SIZE

	[x,y] = size(mtx_hex);
	temp_mtx = zeros(x,y);
	for r = 1:x
		for c = 1:y
			temp_mtx(r,c) = hex2dec(mtx_hex(r,c));
		end
	end
	mtx_dec = temp_mtx;

end