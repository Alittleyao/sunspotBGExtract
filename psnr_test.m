% �ֶ�pͼ·��
pPath = strcat('./Test/p��ͼ/',ls('./Test/p��ͼ/*.jpg'));
% ����ָ��ӡˢ����·��
clusterPath = strcat('./Test/cluster/',ls('./Test/cluster/*.jpg'));
% �ж�׼��ָ��ӡˢ����·��
criteriaPath = strcat('./Test/criteria/',ls('./Test/criteria/*.jpg'));
% ����svm��ӡˢ����·��
svmPath = strcat('./Test/svmpredict/',ls('./Test/svmpredict/*.jpg'));

for i = 1:size(pPath,1)
% ��ȡӡˢ����ԭͼƬ����ps�ֶ������ͼƬ
Ppic = imread(pPath(i,:));
[m,n,h] = size(Ppic);

% ��ȡ����õ���ӡˢ����ͼƬ
cluster_pic = imread(clusterPath(i,:));

% ��ȡ�����ж�׼��õ���ӡˢ����ͼƬ
criteria_pic = imread(criteriaPath(i,:));

% ��ȡ����svm�õ���ӡˢ����ͼƬ
svm_pic = imread(svmPath(i,:));

B = 8;
MAX = 2^B-1;

%����ͼ����mse��psnr
cluster_MSE(i) = sum(sum(sum((Ppic-cluster_pic).^2)))/(m*n*h);
cluster_PSNR(i) = 20*log10(MAX/sqrt(cluster_MSE(i)));

%�����ж�׼������mse��psnr
criteria_MSE(i) = sum(sum(sum((Ppic-criteria_pic).^2)))/(m*n*h);
criteria_PSNR(i) = 20*log10(MAX/sqrt(criteria_MSE(i)));

%����svm����mse��psnr
svm_MSE(i) = sum(sum(sum((Ppic-svm_pic).^2)))/(m*n*h);
svm_PSNR(i) = 20*log10(MAX/sqrt(svm_MSE(i)));
end