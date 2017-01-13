year = 1992;

% 每年随机抽取12张图（每月一张）
% mkdir(['./Samples/',int2str(year)]);
% for i = 1:12
%     picName = strcat(['../Image/',int2str(year),'/',int2str(i),'/'],ls(['../Image/',int2str(year),'/',int2str(i),'/*.jpg']));
%     num = randperm(size(picName,1));
%     no = num(:,1);
%     copyfile(picName(no,:),['.Samples/',int2str(year),'/']);
% end

% 转换到Lab空间,并拼接到同一矩阵
pic = strcat(['./Samples/',int2str(year),'/'],ls(['./Samples/',int2str(year),'/*.jpg']));
% pic = strcat('./Samples/',ls('./Samples/*.jpg'));
for k = 1:size(pic,1)
    I = imread(pic(k,:));
    
    I2 = imresize(I,0.3);
    
    cform = makecform('srgb2lab');
    lab_he = applycform(I2,cform);
    
    ab = double(lab_he(:,:,2:3));
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,2);
    
    if k == 1
        ab_new = ab;
    else
        ab_new = vertcat(ab_new,ab);
    end
end

% 聚类
nColors = 2;

[cluster_idx, cluster_center] = kmeans(ab_new,nColors,'distance','sqEuclidean', ...
                                      'Replicates',2);
 
% 寻找判断是否属于印刷部分的判断标准
% 目标类别，即印刷部分所在的类别编号
targetCluster = 2;

% 提取目标类别的数据，并进行去重
targetData = ab_new(cluster_idx==targetCluster,:);
targetData = unique(targetData,'rows');

% 对目标类别画图
figure
plot(targetData(:,1),targetData(:,2),'*')
hold on

% 对其他类别画图
tempData = ab_new(cluster_idx==1,:);
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
y = 4.7506.* x - 405.1603;
plot(x,y)