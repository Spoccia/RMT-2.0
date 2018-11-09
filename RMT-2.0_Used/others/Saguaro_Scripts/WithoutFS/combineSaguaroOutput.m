% Combine the output csv files from Saguaro cluster by Rows
close all;
clc;
clear;

nodeNum = 8;
dataSize = 184;
step = dataSize / nodeNum;

pivotArray = [];
for i = 1 : nodeNum
    pivotArray = [pivotArray, (i-1) * step + 1];
end

% pathPattern = ['./DA_DAAA/'];
% filePath = ['save_SigmaT28SigmaD05_DA_AA_a2p2_Paired_Folder_'];

pathPattern = ['./DA_DAAA/'];
filePath = ['save_DA_DAAA_a2p2_Folder_'];

saveFile = ['PairedDist.csv'];

saveData = zeros(dataSize, dataSize);
for i = 1 : nodeNum
    fileName = [pathPattern, filePath, num2str(i), '/PairedDist.csv'];
    currentData = csvread(fileName);
    startIndex = (i-1) * step + 1;
    endIndex = i * step;
    saveData(startIndex: endIndex, :) = currentData(startIndex: endIndex, :);
    
    fprintf('%d, %d. \n', startIndex, endIndex);
end
saveFilePath = [pathPattern, saveFile];
csvwrite(saveFilePath, saveData);
fprintf('Fin .\n');
