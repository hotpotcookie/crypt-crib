function [EnkripMulti]=EnkripMulti(a,k)
	EnkripMulti = double(a-97);
	EnkripMulti = mod((EnkripMulti*k),26);
	EnkripMulti = char(EnkripMulti+65);
	CatchEnkrip = '';

	[x,y] = size(a);
	for idx = x:y
		if a(idx) == ' '
			CatchEnkrip = strcat(CatchEnkrip,{' '});
			continue
		end
		CatchEnkrip = strcat(CatchEnkrip,EnkripMulti(idx));		
	end
	EnkripMulti = char(CatchEnkrip);
end