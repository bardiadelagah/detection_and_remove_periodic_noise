function [noise_rows, noise_columns] = findNoisesInFourierSummation(rows, columns)
%NOISESXY Summary of this function goes here
%   Detailed explanation goes here

rows(1) = 0;% value of dc in furier in first row
columns(1) = 0;% value of dc in furier in first columns

row_dc = rows(1);
columns_dc = columns(1);

row_start = rows(2);
columns_start = columns(2);

row_end = rows(size(rows,1));
columns_end = columns(size(columns,1));

rows(1) = 0;% value of dc in furier in first row
columns(1) = 0;% value of dc in furier in first columns

rows(2) = 0;
columns(2) = 0;

rows(size(rows,1)) = 0;
columns(size(columns,1)) = 0;


max_rows = (rows(rows >= row_start & rows >= row_end));
max_columns = (columns(columns >= columns_start & columns >= columns_end));

max_rows = max_rows(:);
max_columns = max_columns(:);

max_rows = max_rows(1:ceil(size(max_rows,1)/2));
max_columns = max_columns(1:ceil(size(max_columns,1)/2));

num = 0;
for i = 1:size(max_rows,1)
    for j = 1:size(find(rows == max_rows(i)),1)
        num = num+1; 
    end
end

noise_rows = zeros(num,1);
noise_columns = zeros(num,1);

num = 1;
for i = 1:size(max_rows,1)
    for j = 1:size(find(rows == max_rows(i)),1)
        temp1 = find(rows == max_rows(i));
        noise_rows(num) = temp1(j);
        temp2 = find(columns == max_columns(i));
        noise_columns(num) =  temp2(j);
        num = num + 1;
    end
end
% disp('noise_rows')
% disp(noise_rows)
% disp('noise_columns')
% disp(noise_columns)
% disp('end')

end

