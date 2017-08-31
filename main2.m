tic
picName = strcat('./Samples/',ls('./Samples/*.jpg'));

% for i = 1:size(picName)
i = 14;
% 读取原始图片
I = imread(picName(i,:));
figure;imshow(I)

% 将RGB转化为Lab
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);

% a、b分量的等高线对数分布图
lab = applycform(I,cform);
aMat = lab(:,:,2);
bMat = lab(:,:,3);
ab = [aMat(:) bMat(:)];
[ count ] = abDistri( ab );
a = 1:255;
b = 1:255;
[A,B] = meshgrid(a,b);
logCount = log(count);
figure
contourf(A,B,logCount)
xlabel('$a$','Interpreter','latex','fontsize',18)
ylabel('$b$','Interpreter','latex','fontsize',18)
xlim([70 200])
ylim([100 180])

% 将所有像素的ab部分提取出来
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

% 对像素进行聚类
nColors = 2;
% 聚类2次
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',2,'Display','iter');

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
xlim([70,200])
ylim([100,180])

% 寻找判断直线
x = 103:132;
% y = 4.7506.* x - 405.1603;
a1 = cluster_center(1,1);
a2 = cluster_center(2,1);
b1 = cluster_center(1,2);
b2 = cluster_center(2,2);
k = -(a2-a1)./(b2-b1)
b = (b1+b2)./2+(a2-a1).*(a1+a2)./(2*(b2-b1))
y = k .* x + b;
% y = 2.3571.* x -137.9985;
plot(x,y)
% xlabel('a')
% ylabel('b')
xlabel('$a$','Interpreter','latex','fontsize',18)
ylabel('$b$','Interpreter','latex','fontsize',18)


% 画出聚类后的分类结果                    
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