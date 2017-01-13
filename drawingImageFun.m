function [ drawing ] = drawingImageFun( I,rgb_label,flag )
%drawingImageFun 提取图片的手写文字部分
% 输入参数：I --- 图像的RGB矩阵
%          rgb_label --- 是否属于印刷部分的标记矩阵，1表示属于印刷部分，
%                        0表示不属于印刷部分，注意rgb_label是n*m*3的矩阵
%                        第三个维度为颜色空间部分
%          flag --- 绘图标记，1表示绘图，0表示不绘图
% 输出参数：drawing：提取的手写部分图像


I(rgb_label == 1) = 255;
level = graythresh(I);
drawing = im2bw(I,level);
% drawing = im2bw(I,level-0.01);
% drawing = im2bw(I,0.5);

if flag == 1
    figure 
    imshow(drawing)
end

end

