function [img_filtered, fourier_filtered, img_fourier] = MEDFilter(img, w, T)
%MEDFILTER Summary of this function goes here
%   Detailed explanation goes here


if length(size(img))==3
    img = rgb2gray(img);
end
img = im2double(img);
imgn = img;
[m, n] = size(img);
% w = 15;
% T = 0.01;

fftnoisyimage = (fft2(imgn));
theta = angle(fftnoisyimage);
IMgFD = abs(fftnoisyimage);
IMGLog = log(1+IMgFD);
Max = max(max(IMGLog));
img_fourier = IMGLog./Max;
Fimage = IMgFD;
for kk = floor(w/2+1):(m-floor(w/2))
    for j = floor(w/2+1):(n-floor(w/2))
        win = IMgFD(kk-floor(w/2):(kk+ceil(w/2-1)), j-floor(w/2):(j+ceil(w/2-1)));
        m = median((win(:)));
        o(kk,j)=IMgFD(kk,j)/(m);
        if((IMgFD(kk,j)/(m)) >= T)
            Fimage(kk,j) = m;
        else
            Fimage(kk,j) = IMgFD(kk,j);
        end
    end
end
z = Fimage.*exp(i*theta);
imginv = abs(ifft2(z));
img_filtered = imginv./max(max(imginv));

IMgFd = abs(Fimage);
IMGLog = log(1+IMgFd);
fourier_filtered = IMGLog./max(max(IMGLog));

end

