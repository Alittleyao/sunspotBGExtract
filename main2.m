tic
picName = strcat('./Samples/',ls('./Samples/*.jpg'));

% for i = 1:size(picName)
i = 4;
% 读取原始图片
I = imread(picName(i,:));
figure;imshow(I)

% 将RGB转化为Lab
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);

% 将所有像素的ab部分提取出来
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);


% %绘制三维彩色曲面图
% %将所有a分量的具体数值存储在color_a
% color_a = ab(:,1);
% %将所有b分量的具体数值存储在color_b
% color_b = ab(:,2);
% %构造X、Y、Z矩阵
% [X,Y] = meshgrid(80:200,80:200);
% Z = zeros(size(X));
% for i = 1:size(color_a,1)
%     if  color_a(i)>255||color_a(i)<0||color_b(i)>255||color_b(i)<0
%         disp('Wrong');
%     else
%         Z(color_a(i)-79,color_b(i)-79) = Z(color_a(i)-79,color_b(i)-79)+1;
%     end
% end
% %画图
% figure
% surf(X,Y,Z);
% colorbar


% 对像素进行聚类
nColors = 2;
% 聚类2次避免陷入局部极小值
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',2);

% 寻找判断是否属于印刷部分的判断标准
% 目标类别，即印刷部分所在的类别编号
targetCluster = 2;

% 提取目标类别的数据，并进行去重
targetData = ab(cluster_idx==targetCluster,:);
targetData = unique(targetData,'rows');

% 对目标类别画图
figure
plot(targetData(:,1),targetData(:,2),'*')
hold on

% 对其他类别画图
tempData = ab(cluster_idx==1,:);
tempData = unique(tempData,'rows');
plot(tempData(:,1),tempData(:,2),'*')

%标记聚类中心点
hold on
plot(cluster_center(:,1),cluster_center(:,2),'ko')

% 设置画图参数
xlim([80,200])
ylim([70,190])
axis equal

% 寻找判断直线
x = 103:123;
% y = 4.7506.* x - 405.1603;
y = 2.3571.* x -137.9985;
plot(x,y)



% 画出分类结果                    
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure
imshow(pixel_labels,[]), title('image labeled by cluster index');

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = I;
    color(rgb_label ~= k) = 255;
    segmented_images{k} = color;
end

figure
imshow(segmented_images{1}), title('objects in cluster 1');
figure
imshow(segmented_images{2}), title('objects in cluster 2');
% imwrite(segmented_images{2},'./psnr test/cluster-19920117.jpg')

top