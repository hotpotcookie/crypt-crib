function hasil = mix_column(transformed)
%UNTITLED7 Summary of this function goes here
%   mix_column(hasil_shiftrow)
static_box=[02,03,01,01;01,02,03,01;01,01,02,03;03,01,01,02];
bit_1b = [0,0,0,1,1,0,1,1];
A=[];
temp=[];
for last = 1:4
	for i = 1:1
		for j = 1:4
			for k = 1:4
				switch static_box(j,k)
					case 1
						temp = [temp,transformed(k,i) * static_box(j,k)];
					case 2
						if transformed(k,i) * static_box(j,k) > 255
							bit_1 = bit_matrix(mod(transformed(k,i) * static_box(j,k),256));
							temp = [temp, bin2dec(num2str(bitxor(bit_1,bit_1b)))];
						else
							temp = [temp, transformed(k,i) * static_box(j,k)];
						end
					otherwise
						original_bit = bit_matrix(transformed(k,i));
						if transformed(k,i) * 2 > 255
							bit_1 = bit_matrix(mod(transformed(k,i) * 2,256));
							temp = [temp,bin2dec(num2str(bitxor(bitxor(bit_1,bit_1b),original_bit)))];
						else
							temp = [temp,bin2dec(num2str(bitxor(bit_matrix(transformed(k,i)*2),original_bit)))];
						end
				end
			end 
			bit1=bit_matrix(temp(1,1));
			bit2=bit_matrix(temp(1,2));
			bit3=bit_matrix(temp(1,3));
			bit4=bit_matrix(temp(1,4));
			A = [A,bin2dec(num2str(bitxor4(bit1,bit2,bit3,bit4)))];
			temp = [];
		end
	end
	transformed(:,1) = [];
end
hasil = reshape(A,[4,4]);
end

