function [fin_res] = func_rsa_textconversion(string_msg)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC6
	% // ----------------------------
	% // Input: SHA-256 Hash String
	% // [o] UPPERCASE > TAKE INPUT TO 0-25 BASIS, MAKE INTO ONE LARGE INT
	% // ----------------------------	

	% // UPPERCASE > TAKE INPUT TO 0-25 BASIS, MAKE INTO ONE LARGE INT
	upper_msg = upper(string_msg);
	catch_int_msg(1,1) = 0;
	counter_msg = 1;
	int_msg = hex2dec(upper_msg);
	int_msg_len = length(int_msg);
	for get_int = 1:int_msg_len
		if int_msg(1,get_int) >= 0
			catch_int_msg(1,counter_msg) = int_msg(1,get_int);
			counter_msg = counter_msg + 1;
		end
	end

	fin_res = catch_int_msg;

end

% // enkripsi per huruf / semuanya