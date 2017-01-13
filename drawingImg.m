year = 1992;
for j = 1
    savePath = [int2str(year),'new2drawingData/',int2str(j)];
    mkdir(savePath)
    n = ls(['../Image/',int2str(year),'/',int2str(j),'/*.jpg']);
    picName = strcat(['../Image/',int2str(year),'/',int2str(j),'/'],ls(['../Image/',int2str(year),'/',int2str(j),'/*.jpg']));
    for i = 1:size(picName,1)
        I = imread(picName(i,:));
        [ rgb_label ] = lineJudgeFun( I );
        [ drawing ] = drawingImageFun( I,rgb_label,0 );
        imwrite(drawing,[savePath,'/',deblank(n(i,:))])
    end
end