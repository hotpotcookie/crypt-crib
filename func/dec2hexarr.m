function [mtx_hex] = dec2hexarr(mtx_dec)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // ----------------------------
	% // [o] HEX ARR SIZE = DEC ARR SIZE

	[x,y] = size(mtx_dec);
	temp_mtx = {' '};
	for r = 1:x
		for c = 1:y
			temp_hex = char(dec2hex(uint8((mtx_dec(r,c)))));
			if length(temp_hex) < 2
				temp_hex = strcat('0',temp_hex);
			end
			temp_mtx(r,c) = {temp_hex};
		end
	end
	mtx_hex = temp_mtx;

end