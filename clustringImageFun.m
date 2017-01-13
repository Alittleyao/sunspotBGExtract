function  [targetData,tempData] = clustringImageFun( ab,cluster_idx,cluster_center )
%clustringImageFun Ѱ���ж��Ƿ�����ӡˢ���ֵ��жϱ�׼
%   �˴���ʾ��ϸ˵��

% Ŀ����𣬼�ӡˢ�������ڵ������
targetCluster = 2;

% ��ȡĿ���������ݣ�������ȥ��
targetData = ab(cluster_idx==targetCluster,:);
targetData = unique(targetData,'rows');

% ��Ŀ�����ͼ
figure
plot(targetData(:,1),targetData(:,2),'*')
hold on

% ���������ͼ
tempData = ab(cluster_idx==1,:);
tempData = unique(tempData,'rows');
plot(tempData(:,1),tempData(:,2),'*')

% ��Ǿ������ĵ�
plot(cluster_center(:,1),cluster_center(:,2),'ko')

% ���û�ͼ����
xlim([80,200])
ylim([70,190])
axis equal

% Ѱ���ж�ֱ��
x = 103:123;
y = 4.7506.* x - 405.1603;
plot(x,y)

end

