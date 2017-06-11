close all;
clear all;
clc;
%% ----------init-----------------------------
f = imread('3 均衡化后.jpg');
f = f(:,:,1);
f = mat2gray(f,[0 255]);

f_original = f;

[M,N] = size(f);

P = 2*M;
Q = 2*N;
fc = zeros(M,N);

for x = 1:1:M
    for y = 1:1:N
        fc(x,y) = f(x,y) * (-1)^(x+y);
    end
end

F_I = fft2(fc,P,Q);

figure();
subplot(1,2,1);
imshow(f,[0 1]);
xlabel('a).Original Image');

subplot(1,2,2);
imshow(log(1 + abs(F_I)),[ ]);
xlabel('b).Fourier spectrum.');
%% ------motion blur------------------
H = zeros(P,Q);
a = 0;
b = 0.015;
T = 1;
for x = (-P/2):1:(P/2)-1
     for y = (-Q/2):1:(Q/2)-1
        R = (x*a + y*b)*pi;
        if(R == 0)
            H(x+(P/2)+1,y+(Q/2)+1) = T;
        else H(x+(P/2)+1,y+(Q/2)+1) = (T/R)*(sin(R))*exp(-1i*R);
        end
     end
end


%% ----------Wiener filters-----------
K = 0.2;
H_Wiener = ((abs(H).^2)./((abs(H).^2)+K)).*(1./H);
G=F_I;
F_Wiener = H_Wiener .*  G;
f_Wiener = real(ifft2(F_Wiener));
f_Wiener = f_Wiener(1:1:M,1:1:N);

for x = 1:1:(M)
    for y = 1:1:(N)
        f_Wiener(x,y) = f_Wiener(x,y) * (-1)^(x+y);
    end
end
%% ------show Result------------------
figure();
subplot(1,2,1);
% imshow(f_Wiener(1:128,1:128),[0 1]);
% imwrite(f_Wiener, 'Wiener_Out.jpg');
imshow(f_Wiener,[0 1]);
xlabel('c).Result image by Wiener filter');

subplot(1,2,2);
imshow(log(1+abs(F_Wiener)),[ ]);
xlabel('d).Fourier spectrum');

%% ------------Constrained_least_squares_filtering---------
p_laplacian = zeros(M,N);
Laplacian = [ 0 -1  0;
             -1  4 -1;
              0 -1  0];
p_laplacian(1:3,1:3) = Laplacian;        

P = 2*M;
Q = 2*N;
for x = 1:1:M
    for y = 1:1:N
        p_laplacian(x,y) = p_laplacian(x,y) * (-1)^(x+y);
    end
end
P_laplacian = fft2(p_laplacian,P,Q);

F_C = zeros(P,Q);
r = 0.9;
H_clsf = ((H')./((abs(H).^2)+r.*P_laplacian));

G = F_I;
%% 

F_C = H_clsf .* G;

f_c = real(ifft2(F_C));
f_c = f_c(1:1:M,1:1:N);

for x = 1:1:(M)
   for y = 1:1:(N)
       f_c(x,y) = f_c(x,y) * (-1)^(x+y);
    end
end

%%  
figure();
subplot(1,2,1);
imshow(f_c,[0 1]);

% imwrite(f_c,'output.jpg')
xlabel('e).Result image by constrained least squares filter');

subplot(1,2,2);
imshow(log(1 + abs(F_C)),[ ]);
xlabel('f).Fourier spectrum');
