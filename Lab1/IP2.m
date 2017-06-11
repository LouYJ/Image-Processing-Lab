tmp = imread('heida.jpg');
f = imrotate(tmp, -90);
f1 = imadjust(f(:, :, 1), [0 1], [0 1], 0.5);
f(:,:,1) = f1;
imshow(f);