function [ cluster_idx,cluster_center ] = kmeansFun( ab )
%kmeansFun �����ؽ��о���
%   �˴���ʾ��ϸ˵��

 % ����2�α�������ֲ���Сֵ
 nColors = 2;
 [cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
     'Replicates',1);

end

