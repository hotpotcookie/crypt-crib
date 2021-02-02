% add path
addpath('func');
addpath('materi');
addpath('img');

% ini adalah pembuatan variabel
a = 5+5;
b = 7*6;
c = a-b;
d = int8(20);
f = 12 + d;
get_pi = pi;

% akses matriks
e1 = [1,2,3;4,5,5;7,7,7];
e2 = [12,23,31;34,15,22;5,3,5];
get_e1 = e1(2,:);
get_e2 = e1(1,2) + 3;
get_e3 = e2(:,:);
get_e4 = e2';
get_e5 = [e1 e2];
get_e6 = [e1;e2];
get_e7 = [e1-e2];
get_e8 = [e1*e2];
get_e9 = [e1\e2];

% looping
loop = 1:10;
x = 0:pi/12:2*pi;
y = cos(x);
%a = plot(x,y);

% image handle
gambar = imread ('iz.jpg');
o1 = gambar; o2 = gambar; o3 = gambar;
o1(:,:,1)=0;
o2(:,:,3)=0;
o3(:,:,2)=0;
arr_o = [o1,o2,o3;o3,o1,o2;o2,o3,o1];
imshow(arr_o);

% panggil function
get_func1 = func_cobaKaliTambah(a,b);

% plotting
t = linspace (-5,5,101);
xx = cos(t);
yy = sin(t);
zz = t;
%plot3(xx,yy,zz);
box on;