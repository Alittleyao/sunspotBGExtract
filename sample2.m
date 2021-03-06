% tic
% picName = strcat('./Samples/',ls('./Samples/*.jpg'));
% picName = strcat('./Test/原图/',ls('./Test/原图/*.jpg'));
picName = strcat('./1992/',ls('./1992/*.jpg'));

% i = 1;
for i = 1:size(picName,1)
    % 读取原始图片
    I = imread(picName(i,:));
%     figure;imshow(I)

    % 压缩图片
%     I2 = imresize(I,0.1);

    % 将RGB转化为Lab,并提取a、b分量
    [ ab,nrows,ncols ] = rgb2labFun( I );
    
%     % 拼接所有样本的a、b部分
%     if i == 1
%         ab_total = ab;
%     else
%         ab_total = vertcat(ab_total,ab);
%     end
    
    % 对像素进行聚类
    [ ~,cluster_center ] = kmeansFun( ab );
    
    % 分别绘制聚类后印刷与手绘部分图像
    % pdImageFun( cluster_idx,nrows,ncols )
    
    % 拼接每幅图的质心
    if i == 1;
        center = cluster_center;
    else
        center = vertcat(center,cluster_center);
    end
    
end

% 对像素进行聚类
% [ cluster_idx_total,cluster_center_total ] = kmeansFun( ab_total );

 % 绘制聚类图
%  [targetData,tempData] = clustringImageFun( ab_total,cluster_idx_total);

% 绘制所有样本的中心点
% figure,plot(center(:,1),center(:,2),'ko')

% 区分a、b色彩空间的中心点
total_u1 = [];
total_u2 = [];
for j = 1:size(center,1)
    if center(j,2) > 2.0877 * center(j,1) -100.8961
        total_u1 = vertcat(total_u1,center(j,:));
    else
        total_u2 = vertcat(total_u2,center(j,:));
    end 
end

figure
plot(total_u1(:,1),total_u1(:,2),'.','MarkerSize',10)
hold on
plot(total_u2(:,1),total_u2(:,2),'.','MarkerSize',10)
% 设置画图参数
xlabel('$a$','Interpreter','latex','fontsize',18)
ylabel('$b$','Interpreter','latex','fontsize',18)
xlim([90,140])
ylim([120,155])

% 绘制所有样本中心点的平均值
average_a = vertcat(sum(total_u1(:,1))./size(total_u1,1),sum(total_u2(:,1))./size(total_u2,1));
average_b = vertcat(sum(total_u1(:,2))./size(total_u1,1),sum(total_u2(:,2))./size(total_u2,1));
plot(average_a,average_b,'b--o')


%寻找判断直线
a1 = average_a(1);
a2 = average_a(2);
b1 = average_b(1);
b2 = average_b(2);

hold on
x = 103:125;
k = -(a2-a1)./(b2-b1)
b = (b1+b2)./2+(a2-a1).*(a1+a2)./(2*(b2-b1))
y = k .* x + b;
% y = 2.3654.* x - 132.4717;
plot(x,y)
xlabel('b')
ylabel('a')

% top