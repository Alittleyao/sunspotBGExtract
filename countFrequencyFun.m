function [ a,b,c ] = countFrequencyFun( ab )
%UNTITLED ����a��b�����Ķ�ά�ֲ�
%   ���� ab_total:n�����е�ab��ɫ����
%   ��� c:�洢��Ӧa��b������Ƶ��

% a��b�����ķ�Χ��-128��127
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

