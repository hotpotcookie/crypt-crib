function [mc_state] = func_aes_mixcolumns(r_state,mcon,method_str)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // ----------------------------
	% // [O] EACH COL MULTIPLY BY MATRIX CONSTANT
	% // [O] EACH RESULT INTO NEW MATRIX
	% // s_num(:,1) = hex2dec(s_in(:,1))
	% // s_num(:,2) = hex2dec(s_in(:,2))
	% // s_num(:,3) = hex2dec(s_in(:,3))
	% // s_num(:,4) = hex2dec(s_in(:,4))
	% // ----------------------------
	% // r_state = (hexadecimal round state matrix 4x4)
	% // mcon = (mcon / contant matrix hexadecimal matrix 4x4)
	% // method_str = (string) ['fwd','inv']

	cur_state = r_state;
	[x,y] = size(cur_state);
	for c = 1:x
		id_state = hex2dec(r_state(:,c));
		for d = 1:y
			id_mcon = hex2dec(mcon(d,:));
			get_xor = 0;				
			for e = 1:x
				sub_mcon = id_mcon(e,:);
				sub_state = id_state(e,:);
				switch method_str
					case 'fwd'
						switch sub_mcon
							case 1
								new_sub = sub_state;
							case 2
								a_sub = sub_state;
								b_sub = bitshift(a_sub,1,'uint8');
								new_sub = b_sub;
								if a_sub >= 128
									new_sub = bitxor(b_sub,27);
								end
							case 3
								a_sub = sub_state;
								b_sub = bitshift(a_sub,1,'uint8');
								new_sub = bitxor(b_sub,a_sub);
								if a_sub >= 128
									new_sub = bitxor(bitxor(b_sub,27),a_sub);
								end	
						end
						get_xor = bitxor(new_sub,get_xor);
					case 'inv'
						plainout = zeros(4,4);
						for i=1:4
							for j=1:4
								for k =1:4
									gf8res = multiplicationGF28(hex2dec(r_state(k,j)),hex2dec(mcon(i,k)));
									plainout(i,j) = bitxor(plainout(i,j),gf8res);
								end  
							end
						end
						cur_state = dec2hexarr(plainout);
						mc_state = cur_state;				
						return		
				end
			end
			fin_sub = dec2hex(get_xor);
			if length(fin_sub) == 1
				fin_sub =  strcat('0',fin_sub);
			end
			cur_state(d,c) = {fin_sub};
		end
	end
	
	mc_state = cur_state;
end