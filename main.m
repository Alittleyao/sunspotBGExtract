tic
% 读取原始图片
I = imread('ynao_sd_19640609_0015_li.jpg');
figure;imshow(I)
% 将RGB转化为Lab
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);
% 将所有像素的ab部分提取出来
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

% 对像素进行聚类
nColors = 3;
% 聚类3次避免陷入局部极小值
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);
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
figure
imshow(segmented_images{3}), title('objects in cluster 3');

% 寻找判断是否属于印刷部分的判断标准
% 目标类别，即印刷部分所在的类别编号
targetCluster = 3;

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

tempData = ab(cluster_idx==2,:);
tempData = unique(tempData,'rows');
plot(tempData(:,1),tempData(:,2),'*')

% 标记聚类中心点
hold on
plot(cluster_center(:,1),cluster_center(:,2),'ko')

% 设置画图参数
xlim([80,200])
ylim([70,190])
axis equal

% 寻找判断直线
x = 103:123;
y = 4.7506.* x - 405.1603;
plot(x,y)


toc