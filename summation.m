function [rows, columns] = summation(img)
%GETSUMOFROWS Summary of this function goes here
%   Detailed explanation goes here

if length(size(img))==3
    img = rgb2gray(img);
end
img = im2double(img);

[m, n] = size(img);

f = fft2(img);
img_id = abs(f);

columns = zeros(n, 1);
rows = zeros(m, 1);
for i = 1:n
columns(i) = round(sum(img_id(:, i)), 4);
end
for i = 1:m
rows(i) = round(sum(img_id(i, :)), 4);
end

