% �ֶ�pͼ·��
pPath = strcat('./Test/p��ͼ/',ls('./Test/p��ͼ/*.jpg'));
% ����ָ��ӡˢ����·��
clusterPath = strcat('./Test/cluster/',ls('./Test/cluster/*.jpg'));
% �ж�׼��ָ��ӡˢ����·��
criteriaPath = strcat('./Test/criteria/',ls('./Test/criteria/*.jpg'));
% ����svm��ӡˢ����·��
svmPath = strcat('./Test/svmpredict/',ls('./Test/svmpredict/*.jpg'));

for i = 1:size(pPath,1)
    
    % ��ȡӡˢ����ԭͼƬ����ps�ֶ������ͼƬ
    p_pic = imread(pPath(i,:));
    %����ά����ת������ά
    p_pic = p_pic(:);
    m = length(p_pic);
    
    % ��ȡ����õ���ӡˢ����ͼƬ
    cluster_pic = imread(clusterPath(i,:));
    cluster_pic = cluster_pic(:);
    
    % ��ȡ�����ж�׼��õ���ӡˢ����ͼƬ
    criteria_pic = imread(criteriaPath(i,:));
    criteria_pic = criteria_pic(:);
    
    % ��ȡ����svm�õ���ӡˢ����ͼƬ
    svm_pic = imread(svmPath(i,:));
    svm_pic = svm_pic(:);
    
    p_mean = sum(p_pic)/m;
    p_sigma2 = sum((p_pic-p_mean).^2)/(m-1);
    
    %��������
    cluster_mean = sum(cluster_pic)/m;
    
    cluster_sigma2 = sum((cluster_pic-cluster_mean).^2)/(m-1);
    
    p_cluster_sigma = sum((p_pic-p_mean).*(cluster_pic-cluster_mean))/(m-1);
    
    cluster_Q(i) = 4*p_cluster_sigma*p_mean*cluster_mean/((p_sigma2+cluster_sigma2)*(p_mean^2+cluster_mean^2));
    
    %׼������
    criteria_mean = sum(criteria_pic)/m;
    
    criteria_sigma2 = sum((criteria_pic-criteria_mean).^2)/(m-1);
    
    p_criteria_sigma = sum((p_pic-p_mean).*(criteria_pic-criteria_mean))/(m-1);
    
    criteria_Q(i) = 4*p_criteria_sigma*p_mean*criteria_mean/((p_sigma2+criteria_sigma2)*(p_mean^2+criteria_mean^2));
    
    %svm����
    svm_mean = sum(svm_pic)/m;
    
    svm_sigma2 = sum((svm_pic-svm_mean).^2)/(m-1);
    
    p_svm_sigma = sum((p_pic-p_mean).*(svm_pic-svm_mean))/(m-1);
    
    svm_Q(i) = 4*p_svm_sigma*p_mean*svm_mean/((p_sigma2+svm_sigma2)*(p_mean^2+svm_mean^2));
    
end