% Combine the output csv files from Saguaro cluster by Rows
close all;
clc;
clear;

nodeNum = 8;
dataSize = 184;
step = dataSize / nodeNum;

remainFeatures = zeros(184, 4);

folderPath = ['./save_AA_AA_Folder_'];
fileName = ['remainFeatures.csv'];
saveFileName = ['./averageRemainFeatures.csv'];

count = 0;
for i = 1 : nodeNum
    folderName = [folderPath, num2str(i), '/'];
    filePath = [folderName, fileName];
    currentRemainFeatures = csvread(filePath);
    remainFeatures = remainFeatures + currentRemainFeatures;
    
end

remainFeatures = remainFeatures / (dataSize-1);

remainFeatures = sum(remainFeatures);
remainFeatures
csvwrite(saveFileName, remainFeatures);
fprintf('Fin .\n');



