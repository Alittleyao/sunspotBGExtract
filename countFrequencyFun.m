function [ a,b,c ] = countFrequencyFun( ab )
%UNTITLED 计算a、b分量的二维分布
%   输入 ab_total:n行两列的ab颜色矩阵
%   输出 c:存储对应a、b分量的频数

% a、b分量的范围是-128到127
for i = 1:(127+128+1)
    a(i) = i-129;
end

b = a;
c = zeros(127+128+1,127+128+1);

for j = 1:size(ab,1)
    m = ab(j,1)+1;
    n = ab(j,2)+1;
    c(n,m) = c(n,m)+1;
end

end

