% 手动p图路径
pPath = strcat('./Test/p后图/',ls('./Test/p后图/*.jpg'));
% 聚类分割的印刷部分路径
clusterPath = strcat('./Test/cluster/',ls('./Test/cluster/*.jpg'));
% 判断准则分割的印刷部分路径
criteriaPath = strcat('./Test/criteria/',ls('./Test/criteria/*.jpg'));
% 基于svm的印刷部分路径
svmPath = strcat('./Test/svmpredict/',ls('./Test/svmpredict/*.jpg'));

for i = 1:size(pPath,1)
% 读取印刷部分原图片，即ps手动处理的图片
Ppic = imread(pPath(i,:));
[m,n,h] = size(Ppic);

% 读取聚类得到的印刷部分图片
cluster_pic = imread(clusterPath(i,:));

% 读取利用判断准则得到的印刷部分图片
criteria_pic = imread(criteriaPath(i,:));

% 读取基于svm得到的印刷部分图片
svm_pic = imread(svmPath(i,:));

B = 8;
MAX = 2^B-1;

%聚类图所得mse、psnr
cluster_MSE(i) = sum(sum(sum((Ppic-cluster_pic).^2)))/(m*n*h);
cluster_PSNR(i) = 20*log10(MAX/sqrt(cluster_MSE(i)));

%利用判断准则所得mse、psnr
criteria_MSE(i) = sum(sum(sum((Ppic-criteria_pic).^2)))/(m*n*h);
criteria_PSNR(i) = 20*log10(MAX/sqrt(criteria_MSE(i)));

%基于svm所得mse、psnr
svm_MSE(i) = sum(sum(sum((Ppic-svm_pic).^2)))/(m*n*h);
svm_PSNR(i) = 20*log10(MAX/sqrt(svm_MSE(i)));
end