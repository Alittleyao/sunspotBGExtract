

% ��ȡӡˢ����ԭͼƬ����ps�ֶ������ͼƬ
pic = imread('./psnr test/ps-19920117.jpg');
[m,n,h] = size(pic);

% ��ȡ����õ���ӡˢ����ͼƬ
cluster_pic = imread('./psnr test/cluster-19920117.jpg');

% ��ȡ�����ж�׼��õ���ӡˢ����ͼƬ
criteria_pic = imread('./psnr test/backgroundImg-19920117.jpg');

B = 8;
MAX = 2^B-1;

%����ͼ����psnr
MSE1 = sum(sum(sum((pic-cluster_pic).^2)))/(m*n*h);
PSNR1 = 20*log10(MAX/sqrt(MSE1));

%�����ж�׼������psnr
MSE2 = sum(sum(sum((pic-criteria_pic).^2)))/(m*n*h);
PSNR2 = 20*log10(MAX/sqrt(MSE2));
