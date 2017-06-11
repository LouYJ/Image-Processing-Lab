clear;
tmp = imread('test.jpg');
f = imrotate(tmp, -90);

I64_1 = histeq(f(:,:,1),64);
I8_1 = histeq(f(:,:,1),8);
I2_1 = histeq(f(:,:,1),2);
imshow(I64_1);

I64_2 = histeq(f(:,:,2),64);
I8_2 = histeq(f(:,:,2),8);
I2_2 = histeq(f(:,:,2),2);

I64_3 = histeq(f(:,:,3),64);
I8_3 = histeq(f(:,:,3),8);
I2_3 = histeq(f(:,:,3),2);

I64(:,:,1) = I64_1;
I64(:,:,2) = I64_2;
I64(:,:,3) = I64_3;

I8(:,:,1) = I8_1;
I8(:,:,2) = I8_2;
I8(:,:,3) = I8_3;

I2(:,:,1) = I2_1;
I2(:,:,2) = I2_2;
I2(:,:,3) = I2_3;

% subplot(221);
% imshow(f);
% subplot(222);
% imshow(I64);
% subplot(223);
% imshow(I8);
% subplot(224);
% imshow(I2);