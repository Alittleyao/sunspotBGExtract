function  pdImageFun( cluster_idx,nrows,ncols )
%pdImageFun �ֱ���ƾ����ӡˢ���ֻ沿��ͼ��
%   �˴���ʾ��ϸ˵��

% ����������                    
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure
imshow(pixel_labels,[]), title('image labeled by cluster index');

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = I;
    color(rgb_label ~= k) = 255;
    segmented_images{k} = color;
end

figure
imshow(segmented_images{1}), title('objects in cluster 1');
figure
imshow(segmented_images{2}), title('objects in cluster 2');

end

