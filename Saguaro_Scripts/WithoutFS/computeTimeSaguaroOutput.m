% Combine the output csv files from Saguaro cluster by Rows
close all;
clc;
clear;

nodeNum = 8;
dataSize = 184;
step = dataSize / nodeNum;

pruneTime = 0;
preprocessTime = 0;
matchingTime = 0;

folderPath = ['/Users/sicongliu/Desktop/SaguaroOutput/MoCapDefaultUnPaired/saveFolder_'];
filePrefixName = ['UnPairedmatchingTime'];
saveFileFolder = ['/Users/sicongliu/Desktop/SaguaroOutput/MoCapDefaultUnPaired'];
saveFileName = [saveFileFolder, '/averageTime.csv'];

for i = 1 : nodeNum
    folderName = [folderPath, num2str(i), '/'];
    for j = 1 : step
       fileIndex = (i-1) * step + j;
       fileName = [folderName, filePrefixName, num2str(fileIndex), '.csv'];
       time = csvread(fileName);
       matchingTime = matchingTime + sum(time(1, :));
       preprocessTime = preprocessTime + sum(time(2, :));
       pruneTime = pruneTime + sum(time(3, :));
    end
end
matchingTime = matchingTime / (dataSize);
preprocessTime = preprocessTime / (dataSize);
pruneTime = pruneTime / (dataSize);

% saveTime = [matchingTime, preprocessTime, pruneTime];
saveTime = matchingTime + preprocessTime + pruneTime;
csvwrite(saveFileName, saveTime);
fprintf('Fin .\n');
