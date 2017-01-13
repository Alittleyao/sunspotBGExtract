function [ xyz ] = myrgb2xyz( rgb )
%myrgb2xyz ��RGBɫ�ʿռ�ת��ΪXYZɫ�ʿռ�
%   �˴���ʾ��ϸ˵��

M = [0.4124 0.3576 0.1805
     0.2126 0.7152 0.0722
     0.0193 0.1192 0.9505];

floatRGB = double(rgb) / 255;
gRGB = arrayfun(@g,floatRGB);
gRGB = gRGB(:);
xyz = M * gRGB;
end


function r = g(K)
gamma = 2.4;
a = 0.055;
if K > 0.04045
    r = ((K+a)/(1+a))^gamma;
else
    r = K / 12.92;
end
end