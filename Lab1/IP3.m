clear;

tmp = imread('lenna.jpg');
f = imrotate(tmp, 0);
subplot(121);
imshow(f);

imager = equalization(f(:,:,1));
imageg = equalization(f(:,:,2));
imageb = equalization(f(:,:,3));
new_image = f;
new_image(:,:,1) = imager;
new_image(:,:,2) = imageg;
new_image(:,:,3) = imageb;

subplot(122);
imshow(new_image);

% cnt = 3;
% 
% subplot(221);
% imshow(f(:,:,cnt));
% subplot(222);
% imhist(f(:,:,cnt));
% subplot(223);
% new = equalization(f(:,:,cnt));
% imshow(new);
% subplot(224);
% imhist(new);
