picName = ls('./Test/ԭͼ/*.jpg');
picPath = strcat('./Test/ԭͼ/',ls('./Test/ԭͼ/*.jpg'));

% ����ָ�ӡˢ����
% savePath2 = './Test/cluster/';
% mkdir(savePath2)
kmeansTime = zeros(size(picPath,1),1);
for i = 1:size(picPath,1)
    I = imread(picPath(i,:));
    
    % ��RGBת��ΪLab,����ȡa��b����
    [ ab,nrows,ncols ] = rgb2labFun( I );
    
    s = tic;
    % �����ؽ��о���
    [ cluster_idx,cluster_center ] = kmeansFun( ab );
    kmeansTime(i) = toc(s);
    
    % �ֱ���ƾ����ӡˢ���ֻ沿��ͼ��
%     [ segmented_images ] = pdImageFun( cluster_idx,nrows,ncols,I );
%     imwrite(segmented_images{2},[savePath2,'/',deblank(picName(i,:))])
end


% �ж�ֱ�߷ָ�ӡˢ����
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
