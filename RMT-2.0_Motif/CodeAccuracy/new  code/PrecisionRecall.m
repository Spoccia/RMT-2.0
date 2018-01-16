clear;
clc;

% load feature count into motifFeatureCount
% motifFeatureCount


% [num,txt,raw] = xlsread('D:\Motif_Results\Datasets\SynteticDataset\Features_RME\Mocap_test6_AllFeatures\Accuracy\AP_Mocap_test6_AllFeatureFound_DepO_2_DepT_2.csv','AP_all_SubC');
filePath = ['./AP_Mocap_test6_AllFeatureFound_DepO_2_DepT_2.csv'];
[num,txt,raw] = xlsread(filePath,'AP_all_SubC');
classID = num(:, 1);
featureID = num(:, 2);
timeStart = num(:, 3);
timeEnd = num(:, 4);

injectedClassID = num(:, 5);
injectedTimeStart = num(:, 6);
injectedTimeEnd = num(:, 7);

% depd overlap computed from Jaccard similarity
depdOverlap = num(:, 8);
timeOverlap = num(:, 9);

timeOverlapThreshold = 0.5;
depdOverlapThreshold = 0.5;

precisoin = [];
recall = [];
FScore = [];

uniqueInjectedClass = unique(injectedClassID);
% for each of the injected class, we have a precision and recall
for i = 1 : size(uniqueInjectedClass, 1)
    currentInjectedClassIndex = uniqueInjectedClass(i);
    % relevantFeatureCount used to compute recall
    relevantFeatureCount = size(find(motifFeatureCount == i), 1);
    
    % currentFeatureCount used to compute precision
    retrievedIndex = injectedClassID == currentInjectedClassIndex;
    
    currentFeatureCount = size(retrievedIndex~=0, 1);
    % filter with threshold
    preFilteredTimeOverlap = timeOverlap(retrievedIndex);
    preFilteredDepdOverlap = depdOverlap(retrievedIndex);
    
    filteredTimeOverlapIndex = preFilteredTimeOverlap > timeOverlapThreshold;
    preFilteredDepdOverlap = preFilteredDepdOverlap(filteredTimeOverlapIndex);
    filteredDepdOverlap = filteredDepdOverlap(preFilteredDepdOverlap > depdOverlapThreshold);
    
    relevantSize = size(filteredDepdOverlap, 1);
    currentPrecision = relevantSize/currentFeatureCount;
    currentRecall = relevantSize/relevantFeatureCount;
    
    currentFScore = 2 * currentPrecision * currentRecall / (currentRecall + currentPrecision);
    
    precision = [precision, currentPrecision];
    recall = [recall, currentRecall];
    FScore = [FScore, currentFScore];
end

% 
% currentClass = unique(classID);
% for i = 1 : currentClass
%     index = find(classID == i);
%     currentDataEntry = num(index, :);
%     
%     currentInjectedClassID = injectedClassID(index, :);
%     currentDepdOverlap = depdOverlap(index, :);
%     currentIsQualified = isQualified(index, :);
%     currentTimeOverlap = timeOverlap(index, :);
%     
%     % for each currentInjectedClassID, use voting scheme to pick the best one for representation
%     currentUniqueClass = unique(currentInjectedClassID);
%     currentBestFScore = realmin;
%     currentBestPrecision = 0;
%     currentBestRecall = 0;
%     for j = 1 : currentUniqueClass
%         % filter using threshold
%         currentIndex = find(currentInjectedClassID == j);
%         filteredIndex = find(currentDepdOverlap(currentIndex) > depdOverlapThreshold& currentTimeOverlap(currentIndex) > timeOverlapThreshold);
%         % pick the best FScore
%         
%         currentFScore = (2 * currentPrecision * currentRecall) / (currentPrecision + currentRecall);
%         if(currentFScore > currentBestFScore)
%             currentBestPrecision = currentPrecision;
%             currentBestRecall = currentRecall;
%             currentBestFScore = currentFScore;
%         end
%         
%         
%     end
%     
%     precision = [precision, currentBestPrecision];
%     recall = [recall, currentBestRecall];
%     FScore = [FScore, currentBestPrecision];
% end
averageFScore = mean(FScore);

fprintf('All done .\n');