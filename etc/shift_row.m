function hasil = shift_row(input)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
for i = 1:4
    switch i
        case 2
            temp_1 = input(i,1);
            for x = 1:3
                input(i,x) = input(i,x+1);
            end
            input(i,4) = temp_1;
        case 3
            temp_1 = input(i,1);
            temp_2 = input(i,2);
            for x = 1:2
                input(i,x) = input(i,x+2);
            end
            input(i,3) = temp_1;
            input(i,4) = temp_2;
        case 4
            b = input;
            temp_1 = input(i,4);
            for x = 1:3
                input(i,x+1) = b(i,x);
            end
            input(i,1) = temp_1;
    end
end
hasil = input;
end

