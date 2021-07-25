function [fin_res] = func_sha256(input_file)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC6
	% // ----------------------------
	% // File : File_soal_nomor_1.rtf
	% // ----------------------------	
	% // [O] CONVERT FILE CONTENT TO BINARY
	% // [O] APPEND A SINGLE '1', CREATE NEW ROW
	% // [X] 
	% // ----------------------------	

	get_content = fileread(input_file);
	if length(get_content) < 56 && length(get_content) >= 8
		% // convert the content to binary (char array)
		char_arr = dec2bin(get_content,8);
		x1 = length(char_arr);
		char_arr(x1+1,:) = '10000000';
		x1 = length(char_arr);

		% // pad with 0 to become 448 bits (saving 64 bits)
		for row = (x1+1):56
			char_arr(row,:) = '00000000';
		end

		% // get the content's binary length to be added in the last 64 bits
		% // get the remainder zero to be padded before the binary
		get_content_len = length(get_content) * 8;
		len_bin = dec2bin(get_content_len,8);
		next_bit_zero_len = 64 - length(len_bin);
		next_bit_zero_len = floor(next_bit_zero_len/8);

		% // pad with 0 to fit with the binary to become 64 bits
		for row = 57:(56+next_bit_zero_len-1)
			char_arr(row,:) = '00000000';
		end
		
		% // pad with 0 to fit with the binary as a remainder
		x1 = length(char_arr);
		bin_len = floor(length(len_bin)/8)
		rem_len = 8 - rem(length(len_bin),8)
		if rem_len < 8
			for zero_pad = 1:bin_len
				char_arr(zero_pad+x1,:) = '00000000';
			end
		end

		% // add the binary on the last section
		x1 = length(char_arr)
		counter_rem = 1;
		for rem_zero_pad = 1:8
			if rem_zero_pad <= rem_len
				char_arr(x1+1,rem_zero_pad) = '0';			
			else
				char_arr(x1+1,rem_zero_pad) = len_bin(1,counter_rem:counter_rem);
				counter_rem = counter_rem + 1;
			end
		end
		char_arr(x1+2,:) = len_bin(1,(rem(length(len_bin),8)+1):length(len_bin));

		% // initialize hash value
		h0 = '0x6a09e667';
		h1 = '0xbb67ae85';
		h2 = '0x3c6ef372';
		h3 = '0xa54ff53a';
		h4 = '0x510e527f';
		h5 = '0x9b05688c';
		h6 = '0x1f83d9ab';
		h7 = '0x5be0cd19';

		% // initialize round constants
		h_round = {'0x428a2f98','0x71374491','0xb5c0fbcf','0xe9b5dba5','0x3956c25b','0x59f111f1','0x923f82a4','0xab1c5ed5'};

		fin_res=char_arr
	else
        fprintf('[info]: content length must be in 8 - 64 bytes\n',length(get_content));
	end
end