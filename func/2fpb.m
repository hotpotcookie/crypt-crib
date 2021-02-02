function [return_fpb] = func_fpb(a,b)
	a1=a; b1=b; c=0; T=b;
	while a~=0
	   while b-a>=0
	      c=c+1;
	      b=b-a;
	   end
	   disp([num2str(T),'=(',num2str(c),')(',num2str(a),')+',num2str(b)])
	   T=a; a=b; b=T; c=0;
	end
	disp(['jadi FPB(',num2str(b1),',',num2str(a1),')=',num2str(b)])
end