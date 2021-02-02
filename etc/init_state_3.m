function [hasil] = conv(plain)
	plain = upper(plain);
	plain = char(plain);
	n = length(plain); 
	total = n+(16-mod(n,16));    
	for r = total-n:-1:1
		plain(n+r) = char('Z');
	end 

	o=1;
	for i = 1:total/16
		for j=1:4       
			for k=1:4
				hasil(j,i*4+k-4) = plain(o);
				o = o + 1;          
			end
		end
	end
end