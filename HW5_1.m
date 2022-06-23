clc; clear all; close all;

img = imread('cameraman.tif');

if length(size(img))==3
    img = rgb2gray(img);
end

img = im2double(img);
IO = img;

img1 = makePeriodicNoise(img, 2, 2, 2);
img2 = makePeriodicNoise(img1, 4, 4, 2);

% img_fourier = showFourierTransform(img);
% img1_fourier = showFourierTransform(img1);
% img2_fourier = showFourierTransform(img2);
% 
% figure(1),
% subplot(2,3,1),imshow(img),title('orginal img')
% subplot(2,3,2),imshow(img1),title('img + 1 periodicNoice')
% subplot(2,3,3),imshow(img2),title('img + 2 periodicNoice')
% subplot(2,3,4),imshow(img_fourier),title('')
% subplot(2,3,5),imshow(img1_fourier),title('')
% subplot(2,3,6),imshow(img2_fourier),title('')


[img_r, img_c] = getSumOfRowsAndColumnsInFourier(img);
[img1_r, img1_c] = getSumOfRowsAndColumnsInFourier(img1);
[img2_r, img2_c] = getSumOfRowsAndColumnsInFourier(img2);

figure(2),
subplot(2,3,1),plot(img_r),title('orginal img')
subplot(2,3,2),plot(img1_r),title('img + 1 periodicNoice')
subplot(2,3,3),plot(img2_r),title('img + 2 periodicNoice')
subplot(2,3,4),plot(img_c),title('')
subplot(2,3,5),plot(img1_c),title('')
subplot(2,3,6),plot(img2_c),title('')


