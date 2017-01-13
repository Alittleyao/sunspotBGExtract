tic
picName = strcat('./Samples/',ls('./Samples/*.jpg'));

% for i = 1:size(picName)
i = 4;
% ��ȡԭʼͼƬ
I = imread(picName(i,:));
figure;imshow(I)

% ��RGBת��ΪLab
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);

% ���������ص�ab������ȡ����
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);


% %������ά��ɫ����ͼ
% %������a�����ľ�����ֵ�洢��color_a
% color_a = ab(:,1);
% %������b�����ľ�����ֵ�洢��color_b
% color_b = ab(:,2);
% %����X��Y��Z����
% [X,Y] = meshgrid(80:200,80:200);
% Z = zeros(size(X));
% for i = 1:size(color_a,1)
%     if  color_a(i)>255||color_a(i)<0||color_b(i)>255||color_b(i)<0
%         disp('Wrong');
%     else
%         Z(color_a(i)-79,color_b(i)-79) = Z(color_a(i)-79,color_b(i)-79)+1;
%     end
% end
% %��ͼ
% figure
% surf(X,Y,Z);
% colorbar


% �����ؽ��о���
nColors = 2;
% ����2�α�������ֲ���Сֵ
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',2);

% Ѱ���ж��Ƿ�����ӡˢ���ֵ��жϱ�׼
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

%��Ǿ������ĵ�
hold on
plot(cluster_center(:,1),cluster_center(:,2),'ko')

% ���û�ͼ����
xlim([80,200])
ylim([70,190])
axis equal

% Ѱ���ж�ֱ��
x = 103:123;
% y = 4.7506.* x - 405.1603;
y = 2.3571.* x -137.9985;
plot(x,y)



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
% imwrite(segmented_images{2},'./psnr test/cluster-19920117.jpg')

top