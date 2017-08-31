function [ cluster_idx,cluster_center ] = kmeansFun( ab )
%kmeansFun 对像素进行聚类
%   此处显示详细说明

 % 聚类2次避免陷入局部极小值
 nColors = 2;
 [cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
     'Replicates',1);

end

