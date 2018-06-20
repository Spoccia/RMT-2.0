% Combine the output csv files from Saguaro cluster by Rows
close all;
clc;
clear;

nodeNum = 8;
dataSize = 184;
step = dataSize / nodeNum;

remainFeatures = zeros(184, 4);

saveFileFolder = ['./save_SigmaT28SigmaD05_DATO_DATO_a2p2_Paired_Folder_'];
saveFileName = ['remainFeatures.csv'];
totalRemainFeatures = zeros(184, 9);
count = 0;
for i = 1 : nodeNum
   saveFilePath = [saveFileFolder, num2str(i), '/', saveFileName];
   currentFeatures = csvread(saveFilePath);
   totalRemainFeatures = totalRemainFeatures + currentFeatures;
end

leftFeatures = sum(totalRemainFeatures) / (dataSize)
% leftFeatures = sum(sum(totalRemainFeatures)) / (dataSize)


fprintf('Fin .\n');
