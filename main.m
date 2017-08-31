tic
% ��ȡԭʼͼƬ
I = imread('ynao_sd_19640609_0015_li.jpg');
figure;imshow(I)
% ��RGBת��ΪLab
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);
% ���������ص�ab������ȡ����
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

% �����ؽ��о���
nColors = 3;
% ����3�α�������ֲ���Сֵ
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);
% ����������                    
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

% Ѱ���ж��Ƿ�����ӡˢ���ֵ��жϱ�׼
% Ŀ����𣬼�ӡˢ�������ڵ������
targetCluster = 3;

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

tempData = ab(cluster_idx==2,:);
tempData = unique(tempData,'rows');
plot(tempData(:,1),tempData(:,2),'*')

% ��Ǿ������ĵ�
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


toc