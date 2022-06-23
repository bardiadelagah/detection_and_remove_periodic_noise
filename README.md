# detection_and_remove_periodic_noise

In this code, with the help of converting the image from spatial domain to frequency domain, we detect the periodic noise and reduce its effectiveness in the image.

# How it works

Here, make 2 nosiy image from original image. We apply 1 periodic nosise to image for make "img1" and 2 periodic nosise to image for make "img2".

```matlab
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

```

Then we change all 3 images from spatical domain to frequency domain.

```matlab
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
```
Here show these 3 images in spatical domain (first row) and frequency domain (second row).

![](https://github.com/bardiadelagah/detection_and_remove_periodic_noise/blob/main/img1.jpg)

Now we can find pixels that include periodic noise with sum pixel valuse in rows and columns in frequency domain sepreatly. 

```matlab
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
```

Here show the sumation of rows and columns. These plots show all pikes in chart (except DC pixel) include periodic noise.

![](https://github.com/bardiadelagah/detection_and_remove_periodic_noise/blob/main/img2.jpg)

Now we apply median filtter to pixels that include periodic noise in frequncy domain.

```matlab
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
```
You can see the final resualt

![](https://github.com/bardiadelagah/detection_and_remove_periodic_noise/blob/main/img3.jpg)

## Donate us
If you like our project and it's useful, feel free to donate us.

Bitcoin(BTC): bc1qs2fatdfdvc5jyq4a0f5t7plmy8sxmyk08tq5e5

Ethereum(ETH): 0x5847D46Bfed82a475ef4187cfBD55EF412C05093

Tether(USDT-TRC20): TAmbZwJXDZ8bo2hjGXtNkTSEYi8dt2Xww8

XRP(XRP): rqTpCtGtBEhcPjZLXfNTv3JbCdkRKGLCF

Dogecoin(DOGE): DGZYMS6nnT3cBYwDtSD7VVubr1dSfykURC

TRON(TRX): TAmbZwJXDZ8bo2hjGXtNkTSEYi8dt2Xww8

BitTorrent-New(BTT-BEP20): 0x5847D46Bfed82a475ef4187cfBD55EF412C05093

Decentraland(MANA-ERC20): 0x5847D46Bfed82a475ef4187cfBD55EF412C05093
