function [ rgb_label ] = lineJudgeFun( I )
%lineJudgeFun �ж��Ƿ�����ӡˢ���֣������б��
% ���������I --- ͼ���RGB����
% ���������rgb_label --- �Ƿ�����ӡˢ���ֵı�Ǿ���1��ʾ����ӡˢ���֣�
%                        0��ʾ������ӡˢ���֣�ע��rgb_label��n*m*3�ľ���
%                        ������ά��Ϊ��ɫ�ռ䲿��

% ��RGBת��ΪLab
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);
% ���������ص�ab������ȡ����
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);


% ֱ�Ӹ���ֱ���ж�ֱ��
% cluster_idx = ab(:,2) >= ab(:,1) .*4.7506 - 405.1603;
cluster_idx = ab(:,2) >= ab(:,1) .*2.3654 - 132.4717;

pixel_labels = reshape(cluster_idx,nrows,ncols);
rgb_label = repmat(pixel_labels,[1 1 3]);


end

