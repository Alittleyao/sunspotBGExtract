function [ rgb_label ] = lineJudgeFun( I )
%lineJudgeFun 判断是否属于印刷部分，并进行标记
% 输入参数：I --- 图像的RGB矩阵
% 输出参数：rgb_label --- 是否属于印刷部分的标记矩阵，1表示属于印刷部分，
%                        0表示不属于印刷部分，注意rgb_label是n*m*3的矩阵
%                        第三个维度为颜色空间部分

% 将RGB转化为Lab
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);
% 将所有像素的ab部分提取出来
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);


% 直接根据直线判断直线
% cluster_idx = ab(:,2) >= ab(:,1) .*4.7506 - 405.1603;
cluster_idx = ab(:,2) >= ab(:,1) .*2.3654 - 132.4717;

pixel_labels = reshape(cluster_idx,nrows,ncols);
rgb_label = repmat(pixel_labels,[1 1 3]);


end

