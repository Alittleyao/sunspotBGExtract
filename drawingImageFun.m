function [ drawing ] = drawingImageFun( I,rgb_label,flag )
%drawingImageFun ��ȡͼƬ����д���ֲ���
% ���������I --- ͼ���RGB����
%          rgb_label --- �Ƿ�����ӡˢ���ֵı�Ǿ���1��ʾ����ӡˢ���֣�
%                        0��ʾ������ӡˢ���֣�ע��rgb_label��n*m*3�ľ���
%                        ������ά��Ϊ��ɫ�ռ䲿��
%          flag --- ��ͼ��ǣ�1��ʾ��ͼ��0��ʾ����ͼ
% ���������drawing����ȡ����д����ͼ��


I(rgb_label == 1) = 255;
level = graythresh(I);
drawing = im2bw(I,level);
% drawing = im2bw(I,level-0.01);
% drawing = im2bw(I,0.5);

if flag == 1
    figure 
    imshow(drawing)
end

end

