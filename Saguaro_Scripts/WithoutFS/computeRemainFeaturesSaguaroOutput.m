% Combine the output csv files from Saguaro cluster by Rows
close all;
clc;
clear;

nodeNum = 8;
dataSize = 184;
step = dataSize / nodeNum;

remainFeatures = zeros(184, 4);

folderPath = ['/Users/sicongliu/Desktop/SaguaroOutput/MoCapDefaultUnPaired/saveFolder_'];
filePrefixName = ['UnPairedf3remainDetail'];
saveFileFolder = ['/Users/sicongliu/Desktop/SaguaroOutput/MoCapDefaultUnPaired'];
saveFileName = [saveFileFolder, '/averageRemainFeatures.csv'];

count = 0;
for i = 1 : nodeNum
    folderName = [folderPath, num2str(i), '/'];
    for j = 1 : step
        count = count + 1;
        fileIndex = (i-1) * step + j;
        fileName = [folderName, filePrefixName, num2str(fileIndex), '.csv'];
        currentRemainFeatures = csvread(fileName);
        remainFeatures = remainFeatures + currentRemainFeatures;
    end
end

count
remainFeatures = remainFeatures / (dataSize);

remainFeatures = sum(remainFeatures);
remainFeatures = remainFeatures / (dataSize);
csvwrite(saveFileName, remainFeatures);
fprintf('Fin .\n');
