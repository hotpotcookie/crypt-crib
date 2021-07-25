function y = modExp( b, e, n )
	% Fast modular exponentiation e.g.: y = b^e mod n
	% Applied Cryptography: Protocols, Algorithms, and Source Code in C,
	% page 245
	if (n == 1)
		y = 0;
		return
	end
	y = uint64(1);
	b = mod(b,n);
	while ( e > 0 )
		if ( mod(e,2) == 1)
			y = mod((y * b),n);
		end
		e = bitshift(e,-1);
		b = mod( (b * b),n ) ;
	end
end
