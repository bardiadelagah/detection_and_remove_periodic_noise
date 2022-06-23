function [output] = makePeriodicNoise(img, k1, k2, alpha)
%MAKEPERIODICNOICE Summary of this function goes here
%   Detailed explanation goes here

if length(size(img))==3
    img = rgb2gray(img);
end
img = im2double(img);

[m, n] = size(img);
[a, b] = meshgrid(1:n, 1:m);
noise = (sin(a/k1 + b/k2) + 1)./alpha;
noisy_img = mat2gray(img + noise);

output = noisy_img;
end

