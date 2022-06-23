function [output] = fourierTransform(img)
%SHOWFOURIERTRANSFORM Summary of this function goes here
%   Detailed explanation goes here


if length(size(img))==3
    img = rgb2gray(img);
end
img = im2double(img);


f = fft2(img);
% f = fftshift(f);
img_id = abs(f);
img_log = log(1+img_id);
Max = max(max(img_log));
sf_img = img_log./Max;
% sf_img = mat2gray(img_log);
output = sf_img;


end

