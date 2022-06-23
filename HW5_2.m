clc; clear all; close all;

img = imread('cameraman.tif');

if length(size(img))==3
    img = rgb2gray(img);
end

img = im2double(img);
IO = img;
[m, n] = size(img);

%% add periodic Noice 
img1 = makePeriodicNoise(img, 2, 2, 2);
img2 = makePeriodicNoise(img1, 4, 4, 2);
% img2 = makePeriodicNoice(img2, 3, 10, 5);

%% fourier transform
img_fourier = fourierTransform(img);
img1_fourier = fourierTransform(img1);
img2_fourier = fourierTransform(img2);

figure(1),
subplot(2,3,1),imshow(img),title('orginal img')
subplot(2,3,2),imshow(img1),title('img + 1 periodicNoice')
subplot(2,3,3),imshow(img2),title('img + 2 periodicNoice')
subplot(2,3,4),imshow(img_fourier),title('')
subplot(2,3,5),imshow(img1_fourier),title('')
subplot(2,3,6),imshow(img2_fourier),title('')

%% summation of rows and columns
[rows, columns] = summation(img);
[rows1, columns1] = summation(img1);
[rows2, columns2] = summation(img2);

figure(2),
subplot(2,3,1),plot(rows),title('img summation rows')
subplot(2,3,2),plot(rows1),title('img summation rows1')
subplot(2,3,3),plot(rows2),title('img summation rows2')
subplot(2,3,4),plot(columns),title('img summation columns')
subplot(2,3,5),plot(columns1),title('img summation columns1')
subplot(2,3,6),plot(columns2),title('img summation columns2')

%% find coordinates of noises
[noise_row1, noise_column1] = findNoisesInFourierSummation(rows1, columns1);
[noise_row2, noise_column2] = findNoisesInFourierSummation(rows2, columns2);

%% denoise
T = 0.00001;
w = 15;
% temp_img = img2;
% for h = 1:2
[img2_filtered, img2_fourier_filtered] = MEDFilterImproved(img2, w, T, noise_row1, noise_column1);
% temp_img = img1_filtered;
% end

figure(3),
subplot(2,3,1),imshow(img),title('orginal img')
subplot(2,3,2),imshow(img2),title('noised img befor filter')
subplot(2,3,3),imshow(img2_filtered),title('noised img after filter')
subplot(2,3,4),imshow(img_fourier),title('fourier orginal img')
subplot(2,3,5),imshow(img2_fourier),title('noised img fourier befor filter')
subplot(2,3,6),imshow(img2_fourier_filtered),title('noised img fourier after filter')

% [temp_rows1, temp_columns1] = summation(temp_img);
% 
% 
% figure(4),plot(temp_rows1)
% figure(5),plot(temp_columns1)
% figure(4),
% subplot(2,3,1),imshow(img1_filtered),title('img_filtered1')
% subplot(2,3,2),imshow(fourier_filtered1),title('fourier_filtered1')
% subplot(2,3,3),imshow(img_fourier1),title('img_fourier1')
% subplot(2,3,1),imshow(img1),title('img1')
% subplot(2,3,2),plot(temp_rows1),title('temp_rows1')
% subplot(2,3,3),plot(temp_columns1),title('temp_columns1')



