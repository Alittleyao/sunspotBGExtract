function [ ab,nrows,ncols ] = rgb2labFun( I )
%rgb2labFun  rgbת��Ϊlab������ȡa��bɫ�ʷ���
%   �˴���ʾ��ϸ˵��

% ��RGBת��ΪLab
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);

% ���������ص�ab������ȡ����
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);
    
end

