addpath('func');
addpath('materi');
addpath('img');

% a origin, q poison, n modulus, r residu
% a  = q x n + r   ||  -a = (q-1) x n + r
% 23 = 1 x 12 + 11 || -23 = -2 x 12 + 1
% kalau a != 0 tapi r == 0
% a  = q x n
% gcd(x,y) sama dengan mencari FPB
% gcd(a,0) = 0 || gcd(a,b) = gcd(b,r), dimana r dari a%b
% extended eucladian, s1 - s2 x q  || t1 - t2 x q
% inisial s1=1, s2=0, t1=0 t2=1

fpb_1 = gcd(140,12);

fpb_2 = gcd(27820,240);
fpb_3 = gcd(240,mod(27820,240));

fpb_4 = gcd(2740,1760);
fpb_5 = gcd(1760,mod(2740,1760));

[gcd1, s, t] = gcd(7649,357);

% r paling kecil adalah Zn / mod n
% pada jam Z12, pada huruf Z26, pada hari Z7
% Zn  = {0, 1, 2, .., (n-1)}
% Z12 = {0, 1, 2, 4, 5, 6, 7, 8, 9, 10, 11}
% Z12* = {1, 2, 3, .., 11} 
% 6371 = 6x10`3 + 3x10`2 + 7x10`1 1x10`0

% C[] = A[] + B[]
% D[] = A[] - B[]
% determinan, perkalian, perkalian skalar
% buat fungsi utk mencari bilangan invers menjadi positif
% untuk modulus tertentu

A = [5,2,1,1;3,0,-4,1;2,1,6,1;1,2,4,5];
B = round(inv(A));

matriks = [2,1;3,0];
%disp(matriks);
modulus = 5;
determinant = round(mod(det(matriks),modulus));
[get_gcd, s, t] = gcd(determinant,modulus);
reslt = mod(round(inv(matriks)*det(matriks)*s),modulus);
%disp(reslt);

func_inverse



