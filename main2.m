tic
picName = strcat('./Samples/',ls('./Samples/*.jpg'));

% for i = 1:size(picName)
i = 14;
% ��ȡԭʼͼƬ
I = imread(picName(i,:));
figure;imshow(I)

% ��RGBת��ΪLab
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);

% a��b�����ĵȸ��߶����ֲ�ͼ
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

% ���������ص�ab������ȡ����
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

% �����ؽ��о���
nColors = 2;
% ����2��
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',2,'Display','iter');

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
xlim([70,200])
ylim([100,180])

% Ѱ���ж�ֱ��
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


% ���������ķ�����                    
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