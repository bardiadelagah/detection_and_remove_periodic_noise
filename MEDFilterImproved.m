function [img_filtered, fourier_filtered] = MEDFilterImproved(img, w, T, rows, columns)
%MEDFILTER Summary of this function goes here
%   Detailed explanation goes here

len_row = size(rows,1);
len_columns = size(columns,1);
main_len = len_row;
if len_row ~= len_columns
    if len_row > len_columns
        main_len = len_columns;
    end
end


if length(size(img))==3
    img = rgb2gray(img);
end
img = im2double(img);
imgn = img;
[m, n] = size(img);
save_w = w;
% w = 15;
% T = 0.01;
var = 10;


fftnoisyimage = (fft2(imgn));
theta = angle(fftnoisyimage);
IMgFD = abs(fftnoisyimage);
IMGLog = log(1+IMgFD);
Max = max(max(IMGLog));
img_fourier = IMGLog./Max;

Fimage = IMgFD;
for itr = 1:main_len
    for kk = floor(w/2+1):(m-floor(w/2))
        % check distance of column form right column and left column of img 
        col_to_right = n-columns(itr);
        col_to_left = columns(itr)-0;
        main_col = col_to_right;
        % use smaller distance 
        if main_col<col_to_left
            main_col = col_to_left;
        end
        % check main_col not bigger than half of window
        if main_col < floor(w/2+1)
            w = main_col*2-1;
        end
        for j = columns(itr)-var:columns(itr)+var
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

    for kk = rows(itr)-var:rows(itr)+var
        % check distance of column form right column and left column of img 
        row_to_down = m-rows(itr);
        row_to_top = rows(itr)-0;
        main_row = row_to_top;
        % use smaller distance 
        if main_row<row_to_down
            main_row = row_to_down;
        end
        % check main_col not bigger than half of window
        if main_row < floor(w/2+1)
            w = main_row*2-1;
        end
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
    
end


z = Fimage.*exp(i*theta);
imginv = abs(ifft2(z));
img_filtered = imginv./max(max(imginv));


IMgFd = abs(Fimage);
IMGLog = log(1+IMgFd);
fourier_filtered = IMGLog./max(max(IMGLog));

end

