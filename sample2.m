% tic
picName = strcat('./Samples/',ls('./Samples/*.jpg'));

% i = 1;
for i = 1:size(picName,1)
    % ��ȡԭʼͼƬ
    I = imread(picName(i,:));
%     figure;imshow(I)

    % ѹ��ͼƬ
    I2 = imresize(I,0.1);

    % ��RGBת��ΪLab,����ȡa��b����
    [ ab,nrows,ncols ] = rgb2labFun( I2 );

    % ƴ������������a��b����
    if i == 1
        ab_total = ab;
    else
        ab_total = vertcat(ab_total,ab);
    end
   
    % �����ؽ��о���
    [ cluster_idx,cluster_center ] = kmeansFun( ab );
    
    % �ֱ���ƾ����ӡˢ���ֻ沿��ͼ��
    pdImageFun( cluster_idx,nrows,ncols )
    
    % ���ƾ���ͼ
    [targetData,tempData] = clustringImageFun( ab,cluster_idx,cluster_center )
    
    % ƴ��ÿ��ͼ������
    if i == 1;
        center = cluster_center;
    else
        center = vertcat(center,cluster_center);
    end
    
end

% ����a��b������Ƶ��
[ a_total,b_total,c ] = countFrequencyFun( ab_total );
% ���Ƶȸ���
[A,B] = meshgrid(a_total,b_total);
C = c;
figure
contour(A,B,C)
% ���û�ͼ����
xlim([4,200])
ylim([70,190])
axis equal

% �����������������ĵ�
figure,plot(center(:,1),center(:,2),'ko')

% ���û�ͼ����
xlim([80,140])
ylim([110,170])
axis equal

% ����a��bɫ�ʿռ�����ĵ�
total_u1 = [];
total_u2 = [];
for j = 1:size(center,1)
    if center(j,2) > 2.0877 * center(j,1) -100.8961
        total_u1 = vertcat(total_u1,center(j,:));
    else
        total_u2 = vertcat(total_u2,center(j,:));
    end 
end

hold on
plot(total_u1(:,1),total_u1(:,2),'c*')
plot(total_u2(:,1),total_u2(:,2),'*')

% ���������������ĵ��ƽ��ֵ
average_a = vertcat(sum(total_u1(:,1))./size(total_u1,1),sum(total_u2(:,1))./size(total_u2,1));
average_b = vertcat(sum(total_u1(:,2))./size(total_u1,1),sum(total_u2(:,2))./size(total_u2,1));
plot(average_a,average_b,'b--o')


%Ѱ���ж�ֱ��
a1 = average_a(1);
a2 = average_a(2);
b1 = average_b(1);
b2 = average_b(2);

x = 103:125;
k = -(a2-a1)./(b2-b1)
b = (b1+b2)./2+(a2-a1).*(a1+a2)./(2*(b2-b1))
y = k .* x + b;
% y = 2.3654.* x - 132.4717;
plot(x,y)

% top