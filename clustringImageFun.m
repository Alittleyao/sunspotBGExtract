function  [targetData,tempData] = clustringImageFun( ab,cluster_idx,cluster_center )
%clustringImageFun 寻找判断是否属于印刷部分的判断标准
%   此处显示详细说明

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

% 标记聚类中心点
plot(cluster_center(:,1),cluster_center(:,2),'ko')

% 设置画图参数
xlim([80,200])
ylim([70,190])
axis equal

% 寻找判断直线
x = 103:123;
y = 4.7506.* x - 405.1603;
plot(x,y)

end

