function [ ab,nrows,ncols ] = rgb2labFun( I )
%rgb2labFun  rgb转化为lab，并提取a、b色彩分量
%   此处显示详细说明

% 将RGB转化为Lab
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);

% 将所有像素的ab部分提取出来
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);
    
end

