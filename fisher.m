%将所有a分量的具体数值存储在color_a
color_a = vertcat(targetData(:,1),tempData(:,1));
%将所有b分量的具体数值存储在color_b
color_b = vertcat(targetData(:,2),tempData(:,2));
%每行颜色分量属于类别存储在group
group = vertcat(ones(size(targetData,1),1),ones(size(tempData,1),1)*2);

%创建一个分类器
X = [color_a,color_b];
costMat = [0 20;20 0;];
MdlLinear = fitcdiscr(X,group,'Cost',costMat);

% 检索线性边界的系数
MdlLinear.ClassNames([1 2])
K = MdlLinear.Coeffs(1,2).Const;
L = MdlLinear.Coeffs(1,2).Linear;

%绘制判别边界
f = @(x1,x2) K + L(1)*x1 + L(2)*x2;
h2 = ezplot(f ,[75 200 90 180]);
h2.Color = 'k';
% axis([75 200 90 180])
xlabel('color a');
ylabel('color b');
title('{\bf Linear Classification with Fisher Training Data}')