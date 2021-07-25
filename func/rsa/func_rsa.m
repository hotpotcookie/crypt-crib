function [fin_res] = func_rsa_public(msg, p, q, mode)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC6
	% // ----------------------------
	% // Input: SHA-256 Hash String
	% // [o] PUBLIC KEY  = N & E > power(2dec(Input),E) mod N
	% // [X] PRIVATE KEY = N & D >				
	% // ----------------------------	


	% // func_rsa_keypair & func_rsa_textconversion
	keypair = func_rsa_keypair(p,q)
	fprintf("input  : %s\n",msg)

	switch mode
		case 'public'
			% // PUBLIC KEY  = N & E > power(2dec(Input),E) mod N
			for x = 1:length(msg)
				catch_msg(x,1) = double(msg(1,x)-48);
				catch_msg(x,1) = mod(vpi(catch_msg(x,1))^keypair(1,1),keypair(2,1));
			end
			enc_msg = dec2hex(catch_msg);
			[x,y] = size(enc_msg);
			enc_msg = reshape(enc_msg,y,x);
			fprintf("cipher : %s\n\n",lower(enc_msg));
			int_msg = enc_msg;
		case 'private'
			% // PRIVATE KEY = N & D >
			[x,y] = size(msg);
			msg = reshape(msg,y,x);			
			msg = hex2dec(msg);
			for x = 1:length(msg)
				catch_msg(x,1) = double(msg(x,1));
				catch_msg(x,1) = mod(vpi(catch_msg(x,1))^keypair(1,2),keypair(2,1));
			end
			dec_msg = char((catch_msg+48));
			dec_msg = reshape(dec_msg,1,length(dec_msg));
			fprintf("plain  : %s\n\n",lower(dec_msg));			
			int_msg = dec_msg;
		case 'image'	
			get_img = imread(msg);
			catch_img = get_img;
			counter_temp = 1; substract_counter = 2;
			temp_pixel = 0;
			pixel_enc = 0;
			[x,y] = size(get_img);
			for r = 1:x
				for c = 1:y
					if (mod(c,3) == 0)
						temp_pixel(1,counter_temp) = double(get_img(r,c));						
						counter_temp = 1;
						substract_counter = 2;						
						for sub_c = 1:3
							catch_img(r,(c-substract_counter)) = mod(double(vpi(double(temp_pixel(1,sub_c))))^keypair(1,2),keypair(2,1));
							substract_counter = substract_counter - 1;
						end

					else
						temp_pixel(1,counter_temp) = double(get_img(r,c));
						counter_temp = counter_temp + 1;
					end
				end
			end
			final_img = mat2gray(catch_img);
			figure
			imshow(final_img)
			int_msg = uint8(final_img);
	end
	fin_res = lower(int_msg);

end