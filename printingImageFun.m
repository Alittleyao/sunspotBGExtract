function [ printing ] = printingImageFun( rgb_label,I,flag )
%pringtingImageFun ��ͼ���ӡˢ������ȡ����
%   ���������I --- ͼ���RGB����
%            rgb_label --- �Ƿ�����ӡˢ���ֵı�Ǿ���1��ʾ����ӡˢ���֣�
%                           0��ʾ������ӡˢ���֣�ע��rgb_label��n*m*3�ľ���
%                           ������ά��Ϊ��ɫ�ռ䲿��
%            flag --- ��ͼ��ǣ�1��ʾ��ͼ��0��ʾ����ͼ
%   ���������printing --- ��ȡ��ӡˢ����ͼ��


printing = I;
printing(rgb_label == 0) = 255;

if flag == 1
    figure 
    imshow(printing)
end

end

