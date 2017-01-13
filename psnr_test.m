

% 读取印刷部分原图片，即ps手动处理的图片
pic = imread('./psnr test/ps-19920117.jpg');
[m,n,h] = size(pic);

% 读取聚类得到的印刷部分图片
cluster_pic = imread('./psnr test/cluster-19920117.jpg');

% 读取利用判断准则得到的印刷部分图片
criteria_pic = imread('./psnr test/backgroundImg-19920117.jpg');

B = 8;
MAX = 2^B-1;

%聚类图所得psnr
MSE1 = sum(sum(sum((pic-cluster_pic).^2)))/(m*n*h);
PSNR1 = 20*log10(MAX/sqrt(MSE1));

%利用判断准则所得psnr
MSE2 = sum(sum(sum((pic-criteria_pic).^2)))/(m*n*h);
PSNR2 = 20*log10(MAX/sqrt(MSE2));
