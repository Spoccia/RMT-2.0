% load index and data
indexData = csvread('classindex.csv');
pprData = csvread('PairedDist.csv');
numClass = 8;
topk = 5;
totalSize = size(indexData, 1);
firstPivot = zeros(1, numClass);
for i = 1 : numClass
    tempIndex = find(indexData == i);
    firstPivot(i) = tempIndex(1);
    clear tempIndex;
end

pivot = 0;
for i = 1 : totalSize
    %     if((pivot+1)<=numClass&&i == firstPivot(pivot+1))
    %         disp(pivot);
    %         pivot = pivot + 1;
    %     end
    if(pprData(i, i) ==0)
        pprData(i, :) = pprData(i, :);
        % pprData(i, i)  = -Inf;
    else
        pprData(i, :) = pprData(i, :)/pprData(i, i);
        % pprData(i, i)  = -Inf;
    end
    
end
resultpath = ['./MoCapAnlysis_pprData.csv'];
csvwrite(resultpath, pprData);

% compute post-analysis
analysisRank = zeros(totalSize, totalSize); % compute rank for each cell
for i = 1:totalSize
    % sort and find rank
    temp = sort(pprData(i, :), 'descend');
    for j = 1 : totalSize
        tempIndex = find(temp == pprData(i, j));
        analysisRank(i, j) = min(tempIndex);
    end
    clear temp;
end
resultpath = ['./MoCapAnlysis_pprData_rank.csv'];
csvwrite(resultpath, analysisRank);

analysisA = zeros(totalSize, 1);
for i = 1:totalSize
    tempSize = size(find(pprData(i, :)>=1), 2) - 1;
    analysisA(i) = tempSize;
end
resultpath = ['./MoCapAnlysis_pprData_A.csv'];
csvwrite(resultpath, analysisA);

left = 0;
right = 0;
analysisB = zeros(totalSize, 1); % count the rank within each class
tempIndex = 1;

analysisClassRank = zeros(totalSize, 1);
perClassAccuracy = zeros(numClass, 3);
perClassAccuracyNoZero = zeros(numClass, 3);
% compute the rank  -- column b
for i  = 1 : size(firstPivot, 2)
    if( i == size(firstPivot, 2))
        left = firstPivot(i);
        right = totalSize; % the end pivot
    else
        left = firstPivot(i);
        disp(i);
        right = firstPivot(i+1)-1;
    end
    subMatrix = analysisRank(left:right, left:right);
    for j = 1 : size(subMatrix, 1);
        % temp = find(subMatrix(j, :)<=topk);
        if(size(subMatrix, 1) < topk)
           topk =  size(subMatrix, 1);
        end
        temp = find(subMatrix(j, :)<=topk);
        tempClassSize = find(subMatrix(j, :)<=size(subMatrix, 1));
        % analysisB(tempIndex) = size(temp, 2);
        % analysisB(tempIndex) = size(temp, 2)/size(subMatrix, 1);
        analysisClassRank(tempIndex) = size(tempClassSize, 2);
        analysisBClassSize(tempIndex) = size(tempClassSize, 2)/size(subMatrix, 1);
        analysisB(tempIndex) = (size(temp, 2)/topk);
        if(analysisB(tempIndex) > 1)
             analysisB(tempIndex) = 1;
        end
        tempIndex = tempIndex + 1;
    end
    perClassAccuracy(i,1) = mean(analysisB(left:right));
    perClassAccuracy(i,2) = median(analysisB(left:right));
    perClassAccuracy(i,3) = right - left + 1;
    
    tAnalysisB = analysisB(left:right);
    tAnalysisB = tAnalysisB(tAnalysisB~=0);
    perClassAccuracyNoZero(i,1) = mean(tAnalysisB);
    perClassAccuracyNoZero(i,2) = median(tAnalysisB);
    perClassAccuracyNoZero(i,3) = right - left + 1;
end
clear tempIndex left right temp
resultpath = ['./MoCapAnlysis_pprData_B.csv'];
csvwrite(resultpath, analysisB);
resultpath = ['./MoCapAnlysis_pprData_BClassSize.csv'];
csvwrite(resultpath, analysisBClassSize);

analysisBClassSizewtZero = analysisBClassSize(analysisBClassSize~=0);
resultpath = ['./MoCapAnlysis_pprData_BClassSizewtZero.csv'];
csvwrite(resultpath, analysisBClassSizewtZero);


analysisBwtZero = analysisB(analysisB~=0);
resultpath = ['./MoCapAnlysis_pprData_BwtZero.csv'];
csvwrite(resultpath, analysisBwtZero);

tempValue = zeros(8, 1);
accuracy = [mean(analysisB) median(analysisB) mean(analysisBwtZero) median(analysisBwtZero) mean(analysisBClassSize) median(analysisBClassSize) mean(analysisBClassSizewtZero) median(analysisBClassSizewtZero)];


resultpath = ['./AccuracyResult.csv'];
csvwrite(resultpath, accuracy);



resultpath = ['./PerClassAccuracyResult.csv'];
csvwrite(resultpath, perClassAccuracy);



resultpath = ['./PerClassAccuracyResultNoZeroImp.csv'];
csvwrite(resultpath, perClassAccuracyNoZero);


analysisC = zeros(totalSize, 1); % intra-class confusion
tempIndex = 1;
left =0;
right = 0;
for i = 1 : size(firstPivot, 2)
    if(i == size(firstPivot, 2))
        left = firstPivot(i);
        right = totalSize; % the end pivot
    else
        left = firstPivot(i);
        right = firstPivot(i+1) -1;
    end
    subMatrix = pprData(left:right, left:right);
    for j = 1 : size(subMatrix, 1);
        temp = subMatrix(j, :);
        analysisC(tempIndex) = (sum(temp) - 1)/(size(temp, 2)-1);
        tempIndex = tempIndex + 1;
    end
end
clear tempIndex left right subMarix
resultpath = ['./MoCapAnlysis_pprData_C.csv'];
csvwrite(resultpath, analysisC);


analysisD = zeros(totalSize, 1); % outer-class average
for i = 1 : size(firstPivot, 2)
    % pick outer-class index
    if(i == size(firstPivot, 2))
        rowStartIndex = firstPivot(i);
        rowEndIndex = totalSize;
        right = totalSize; % the end pivot
    else
        rowStartIndex = firstPivot(i);
        rowEndIndex = firstPivot(i + 1)-1;
        right = firstPivot(i+1);
    end
    subMatrix = pprData(rowStartIndex:rowEndIndex, right:end);
    analysisD(rowStartIndex: rowEndIndex) = mean(subMatrix, 2);
end
clear subMatrix rowStartIndex rowEndIndex right
resultpath = ['./MoCapAnlysis_pprData_D.csv'];
csvwrite(resultpath, analysisD);

% analysisE = zeros(totalSize, 1); % ratio of d/c
% careful with the 0-value case
analysisE = analysisD./analysisC;
resultpath = ['./MoCapAnlysis_pprData_E.csv'];
csvwrite(resultpath, analysisE);


analysisF = zeros(totalSize, 1); % max-outer/min-inner
tempIndex = 1;
for i = 1 : size(firstPivot, 2)
    if(i == size(firstPivot, 2))
        rowStartIndex = firstPivot(i);
        rowEndIndex = totalSize;
        right = totalSize; % the end pivot
    else
        rowStartIndex = firstPivot(i);
        rowEndIndex = firstPivot(i + 1)-1;
        right = firstPivot(i+1);
    end
    innerClass = pprData(rowStartIndex:rowEndIndex, rowStartIndex:rowEndIndex);
    outerClass = pprData(rowStartIndex:rowEndIndex, right:end);
    for j = 1 : size(innerClass, 1);
        tempInner = innerClass(j, :);
        tempOuter = outerClass(j, :);
        % analysisF(tempIndex) = max(tempOuter)/min(tempInner);
        analysisF(tempIndex) = mean(tempOuter)/mean(tempInner);
        tempIndex = tempIndex + 1;
    end
end
clear tempIndex rowStartIndex rowEndIndex right innerClass outerClass minInner maxOuter
resultpath = ['./MoCapAnlysis_pprData_F.csv'];
csvwrite(resultpath, analysisF);


analysisG = zeros(numClass, 1); % median of analysisA for each class
for i = 1 : size(firstPivot, 2)
    if(i == size(firstPivot, 2))
        rowStartIndex = firstPivot(i);
        rowEndIndex = totalSize;
    else
        rowStartIndex = firstPivot(i);
        rowEndIndex = firstPivot(i + 1)-1;
    end
    analysisG(i) = median(analysisA(rowStartIndex:rowEndIndex, :));
end
clear rowStartIndex rowEndIndex
resultpath = ['./MoCapAnlysis_pprData_G.csv'];
csvwrite(resultpath, analysisG);


analysisH = zeros(numClass, 1); % median of analysisB for each class
for i = 1 : size(firstPivot, 2)
    if(i == size(firstPivot, 2))
        rowStartIndex = firstPivot(i);
        rowEndIndex = totalSize;
    else
        rowStartIndex = firstPivot(i);
        rowEndIndex = firstPivot(i + 1)-1;
    end
    analysisH(i) = median(analysisB(rowStartIndex:rowEndIndex, :));
end
clear rowStartIndex rowEndIndex
resultpath = ['./MoCapAnlysis_pprData_H.csv'];
csvwrite(resultpath, analysisH);




analysisHClassRank = zeros(numClass, 1); % median of analysisB for each class
for i = 1 : size(firstPivot, 2)
    if(i == size(firstPivot, 2))
        rowStartIndex = firstPivot(i);
        rowEndIndex = totalSize;
    else
        rowStartIndex = firstPivot(i);
        rowEndIndex = firstPivot(i + 1)-1;
    end
    temptt = analysisClassRank(rowStartIndex:rowEndIndex, :);
    temptt = temptt(temptt~=0);
    analysisHClassRank(i) = median(temptt);
end
clear rowStartIndex rowEndIndex
resultpath = ['./MoCapAnlysis_pprData_HClassRank.csv'];
HClassRank = [mean(analysisHClassRank) median(analysisHClassRank)];
csvwrite(resultpath, HClassRank);



analysisI = zeros(numClass, 1); % median of analysisC for each class
for i = 1 : size(firstPivot, 2)
    if(i == size(firstPivot, 2))
        rowStartIndex = firstPivot(i);
        rowEndIndex = totalSize;
    else
        rowStartIndex = firstPivot(i);
        rowEndIndex = firstPivot(i + 1)-1;
    end
    analysisI(i) = median(analysisC(rowStartIndex:rowEndIndex, :));
end
clear rowStartIndex rowEndIndex
resultpath = ['./MoCapAnlysis_pprData_I.csv'];
csvwrite(resultpath, analysisI);

analysisJ = zeros(numClass, 1); % median of analysisD for each class
for i = 1 : size(firstPivot, 2)
    if(i == size(firstPivot, 2))
        rowStartIndex = firstPivot(i);
        rowEndIndex = totalSize;
    else
        rowStartIndex = firstPivot(i);
        rowEndIndex = firstPivot(i + 1)-1;
    end
    analysisJ(i) = median(analysisD(rowStartIndex:rowEndIndex, :));
end
clear rowStartIndex rowEndIndex
resultpath = ['./MoCapAnlysis_pprData_J.csv'];
csvwrite(resultpath, analysisJ);


analysisK = zeros(numClass, 1); % median of analysisE for each class
for i = 1 : size(firstPivot, 2)
    if(i == size(firstPivot, 2))
        rowStartIndex = firstPivot(i);
        rowEndIndex = totalSize;
    else
        rowStartIndex = firstPivot(i);
        rowEndIndex = firstPivot(i + 1)-1;
    end
    disp(i);
    analysisK(i) = median(analysisE(rowStartIndex:rowEndIndex, :));
end
clear rowStartIndex rowEndIndex
resultpath = ['./MoCapAnlysis_pprData_K.csv'];
csvwrite(resultpath, analysisK);

analysisL = zeros(numClass, 1); % median of analysisF for each class
for i = 1 : size(firstPivot, 2)
    if(i == size(firstPivot, 2))
        rowStartIndex = firstPivot(i);
        rowEndIndex = totalSize;
    else
        rowStartIndex = firstPivot(i);
        rowEndIndex = firstPivot(i + 1)-1;
    end
    analysisL(i) = median(analysisF(rowStartIndex:rowEndIndex, :));
end
clear rowStartIndex rowEndIndex
resultpath = ['./MoCapAnlysis_pprData_L.csv'];
csvwrite(resultpath, analysisL);

fprintf('PPRprocessing finished');