function [r_fin_state] = func_aes(r_state,k_state,method_str)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC5
	% // ----------------------------
	% // INVERSEABLE = SUBBYTE, SHIFTROW, ADDROUNDKEY
	% // NO INVERSE  = MIXCOLUMNS, KEYSCHEDULLER / KEYEXPANDER
	% // ----------------------------
	% // r_state = (hexadecimal round state matrix 4x4)
	% // k_state = (hexadecimal key state matrix 4x4)	
	% // method_str = (string) ['enc','dec']

	r_fin_state = '';
	r_addr_state = '';
	fwd_sbox = init_aesbox('fwd-sbox');
	inv_sbox = init_aesbox('inv-sbox');
	fwd_rcon = init_aesbox('fwd-rcon');
	inv_rcon = init_aesbox('inv-rcon');	
	fwd_mcon = init_aesbox('fwd-mcon');
	inv_mcon = init_aesbox('inv-mcon');
	do_round = length(r_state)/4;
	x = 0; y = 0;

	switch method_str
		case 'enc'
			for itr = 1:do_round
				round = 1;
				r_addr_state = func_aes_addroundkey(r_state(:,1+x:4+y),k_state);
				r_keys_state = k_state;
				for i = 1:9
					r_keys_state = func_aes_keyscheduller(r_keys_state,fwd_sbox,fwd_rcon,round,'fwd');
					r_subb_state = func_aes_subbyte(r_addr_state,fwd_sbox);
					r_shft_state = func_aes_shiftrows(r_subb_state,'fwd');
					r_mixc_state = func_aes_mixcolumns(r_shft_state,fwd_mcon,'fwd');
					r_addr_state = func_aes_addroundkey(r_mixc_state,r_keys_state);
					round = round + 1;
				end
				r_keys_state = func_aes_keyscheduller(r_keys_state,fwd_sbox,fwd_rcon,round,'fwd');
				r_subb_state = func_aes_subbyte(r_addr_state,fwd_sbox);
				r_shft_state = func_aes_shiftrows(r_subb_state,'fwd');
				r_addr_state = func_aes_addroundkey(r_shft_state,r_keys_state);
				fprintf('block state : %d\n',itr);
				disp(r_addr_state);
				x = x + 4; y = y + 4;
			end
		case 'dec'
			for itr = 1:do_round
				round = 1;
				r_keys_state = func_aes_keyscheduller(k_state,fwd_sbox,fwd_rcon,0,'inv')
				r_addr_state = func_aes_addroundkey(r_state(:,1+x:4+y),r_keys_state)
				r_shft_state = func_aes_shiftrows(r_addr_state,'inv')
				r_subb_state = func_aes_subbyte(r_shft_state,inv_sbox)				
				for i = 1:9
					i
					r_keys_state = func_aes_keyscheduller(k_state,fwd_sbox,fwd_rcon,round,'inv')
					r_addr_state = func_aes_addroundkey(r_subb_state,r_keys_state)
					r_mixc_state = func_aes_mixcolumns(r_addr_state,inv_mcon,'inv')					
					r_shft_state = func_aes_shiftrows(r_mixc_state,'inv')
					r_subb_state = func_aes_subbyte(r_shft_state,inv_sbox)
					round = round + 1;
				end
				r_keys_state = func_aes_keyscheduller(k_state,fwd_sbox,fwd_rcon,round,'inv')
				r_addr_state = func_aes_addroundkey(r_subb_state,r_keys_state)
				fprintf('block state : %d\n',itr);
				disp(r_addr_state);
				x = x + 4; y = y + 4;
			end			
	end
	r_fin_state = r_addr_state;

end