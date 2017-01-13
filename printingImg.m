
year = 1992;
for j = 1:12
    savePath = [int2str(year),'printingData/',int2str(j)];
    mkdir(savePath)
    m = ls(['../Image/',int2str(year),'/',int2str(j),'/*.jpg']);
    picName = strcat(['../Image/',int2str(year),'/',int2str(j),'/'],ls(['../Image/',int2str(year),'/',int2str(j),'/*.jpg']));
    for i = 1:size(picName,1)
        I = imread(picName(i,:));
        [ rgb_label ] = lineJudgeFun( I );
        [ printing ] = printingImageFun( rgb_label,I,0 );
        imwrite(printing,[savePath,'/',deblank(m(i,:))])
    end
end