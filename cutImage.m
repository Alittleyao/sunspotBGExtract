picPath = strcat('./Test/ԭͼ/',ls('./Test/ԭͼ/*.jpg'));
for i = 1:size(picPath,1)
    I = imread(picPath(i,:));
%     imshow(I);
    new = I(577:1450,19:1030,:);
    imwrite(new,['./Test/��ͼ/ԭͼ/',int2str(i),'.jpg']);
end

picPath = strcat('./Test/cluster/',ls('./Test/cluster/*.jpg'));
for i = 1:size(picPath,1)
    I = imread(picPath(i,:));
%     imshow(I);
    new = I(577:1450,19:1030,:);
    imwrite(new,['./Test/��ͼ/cluster/',int2str(i),'.jpg']);
end

picPath = strcat('./Test/criteria/',ls('./Test/criteria/*.jpg'));
for i = 1:size(picPath,1)
    I = imread(picPath(i,:));
%     imshow(I);
    new = I(577:1450,19:1030,:);
    imwrite(new,['./Test/��ͼ/criteria/',int2str(i),'.jpg']);
end

picPath = strcat('./Test/svmpredict/',ls('./Test/svmpredict/*.jpg'));
for i = 1:size(picPath,1)
    I = imread(picPath(i,:));
%     imshow(I);
    new = I(577:1450,19:1030,:);
    imwrite(new,['./Test/��ͼ/svmpredict/',int2str(i),'.jpg']);
end