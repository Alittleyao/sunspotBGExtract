function [ printing ] = printingImageFun( rgb_label,I,flag )
%pringtingImageFun 将图像的印刷部分提取出来
%   输入参数：I --- 图像的RGB矩阵
%            rgb_label --- 是否属于印刷部分的标记矩阵，1表示属于印刷部分，
%                           0表示不属于印刷部分，注意rgb_label是n*m*3的矩阵
%                           第三个维度为颜色空间部分
%            flag --- 绘图标记，1表示绘图，0表示不绘图
%   输出参数：printing --- 提取的印刷部分图像


printing = I;
printing(rgb_label == 0) = 255;

if flag == 1
    figure 
    imshow(printing)
end

end

