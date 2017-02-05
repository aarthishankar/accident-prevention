file_list = dir('E:\MATLAB\R2014a\bin\hogsvm\glcm\car\*.jpg');
nfiles = length(file_list); %Add a semicolumn to prevent the function from printing out the output
for k = 1 : nfiles

I = imread(strcat('E:\MATLAB\R2014a\bin\hogsvm\glcm\car\',file_list(k).name));

if length(size(I))==3 %check if the image I is color
I=rgb2gray(I);
end
glcm1 = graycomatrix(I,'Offset',[1 0]);
% stats{ii} = graycoprops(glcm1,{'all'});
% Should be
stats{k} = graycoprops(glcm1,{'all'});
end
