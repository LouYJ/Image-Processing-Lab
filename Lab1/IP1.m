tmp = imread('heida.jpg');
f = imrotate(tmp, -90);
% imshow(f);
% 利用Gamma函数增强图像亮度
% g = imadjust(f, [0 1], [0 1], 0.4);
% 利用对数函数增强图像亮度
g = 0.01*log(1+double(f));
% g = 1./(1 + (100./ (double(f) + eps)) .^2);
gs = im2uint8(mat2gray(g));

imshow(gs);