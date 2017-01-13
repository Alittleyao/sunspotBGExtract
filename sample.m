year = 1992;

% ÿ�������ȡ12��ͼ��ÿ��һ�ţ�
% mkdir(['./Samples/',int2str(year)]);
% for i = 1:12
%     picName = strcat(['../Image/',int2str(year),'/',int2str(i),'/'],ls(['../Image/',int2str(year),'/',int2str(i),'/*.jpg']));
%     num = randperm(size(picName,1));
%     no = num(:,1);
%     copyfile(picName(no,:),['.Samples/',int2str(year),'/']);
% end

% ת����Lab�ռ�,��ƴ�ӵ�ͬһ����
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

% ����
nColors = 2;

[cluster_idx, cluster_center] = kmeans(ab_new,nColors,'distance','sqEuclidean', ...
                                      'Replicates',2);
 
% Ѱ���ж��Ƿ�����ӡˢ���ֵ��жϱ�׼
% Ŀ����𣬼�ӡˢ�������ڵ������
targetCluster = 2;

% ��ȡĿ���������ݣ�������ȥ��
targetData = ab_new(cluster_idx==targetCluster,:);
targetData = unique(targetData,'rows');

% ��Ŀ�����ͼ
figure
plot(targetData(:,1),targetData(:,2),'*')
hold on

% ���������ͼ
tempData = ab_new(cluster_idx==1,:);
tempData = unique(tempData,'rows');
plot(tempData(:,1),tempData(:,2),'*')

%��Ǿ������ĵ�
hold on
plot(cluster_center(:,1),cluster_center(:,2),'ko')

% ���û�ͼ����
xlim([80,200])
ylim([70,190])
axis equal

% Ѱ���ж�ֱ��
x = 103:123;
y = 4.7506.* x - 405.1603;
plot(x,y)