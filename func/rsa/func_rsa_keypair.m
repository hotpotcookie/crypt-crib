function [fin_res] = func_rsa_keypair(in_p, in_q)

	% // Muhammad Nur Irsyad - 1807422020 - CCITSEC6
	% // ----------------------------
	% // Input: SHA-256 Hash String
	% // [o] CHOOSE 2 RANDOM LARGE PRIME, ( P & Q), RANGE 100-500
	% // [o] N = P . Q
	% // [o] T = (P - 1) . (Q - 1)	
	% // [o] CHOOSE E & D, WHERE (E . D) MOD T = 1	
	% // ----------------------------	

	% // CHOOSE 2 RANDOM LARGE PRIME, ( P & Q), RANGE 100-500
	p = in_p; % //nthprime(randi([1 5],1,1))
	q = in_q; % //nthprime(randi([1 5],1,1))

	% // N = P . Q
	n = p * q;

	% // T = (P - 1) . (Q - 1)	
	t = (p-1) * (q-1);

	% // CHOOSE E & D, WHERE (E . D) MOD T = 1	
	for get_e = 2:(t)
		if (gcd(t,get_e) == 1) && (mod(get_e,2) ~= 0)
			e = get_e;
			break;
		end
	end
	for get_d = 1:(t+20)
		temp_d = get_d * e;
		if (mod(temp_d,t) == 1) && (get_d > e)
			d = get_d;
			break
		end
	end

	format_res(1,1) = e; format_res(2,1) = n;
	format_res(1,2) = d; format_res(2,2) = n;	
	fin_res = format_res;	

end