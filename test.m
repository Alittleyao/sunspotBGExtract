picName = ls('./Test/原图/*.jpg');
picPath = strcat('./Test/原图/',ls('./Test/原图/*.jpg'));

% 聚类分割印刷部分
% savePath2 = './Test/cluster/';
% mkdir(savePath2)
kmeansTime = zeros(size(picPath,1),1);
for i = 1:size(picPath,1)
    I = imread(picPath(i,:));
    
    % 将RGB转化为Lab,并提取a、b分量
    [ ab,nrows,ncols ] = rgb2labFun( I );
    
    s = tic;
    % 对像素进行聚类
    [ cluster_idx,cluster_center ] = kmeansFun( ab );
    kmeansTime(i) = toc(s);
    
    % 分别绘制聚类后印刷与手绘部分图像
%     [ segmented_images ] = pdImageFun( cluster_idx,nrows,ncols,I );
%     imwrite(segmented_images{2},[savePath2,'/',deblank(picName(i,:))])
end


% 判断直线分割印刷部分
% savePath1 = './Test/criteria/';
% mkdir(savePath1)
lineTime = zeros(size(picPath,1),1); 
for i = 1:size(picPath,1)
    I = imread(picPath(i,:));
    
    s = tic;
    [ rgb_label ] = lineJudgeFun( I );
    lineTime(i) = toc(s);
    
%     [ printing ] = printingImageFun( rgb_label,I,0 );
%     imwrite(printing,[savePath1,'/',deblank(picName(i,:))])
end
