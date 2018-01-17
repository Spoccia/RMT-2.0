clear;
clc;

% load feature count into motifFeatureCount
featureCountFilePath = './FeaturePosition_MoCap_test6.csv';
motifFeatureCount = csvread(featureCountFilePath);

% matlab unique function provides default sorting
motifClass = unique(motifFeatureCount(:, 1));
motifClassCount = [];

% update motif class count
for i = 1 : size(motifClass, 1)
    currentMotifClassCount = size(nonzeros(motifFeatureCount(:, 1) == i), 1);
    motifClassCount = [motifClassCount, currentMotifClassCount];
end



% [num,txt,raw] = xlsread('D:\Motif_Results\Datasets\SynteticDataset\Features_RME\Mocap_test6_AllFeatures\Accuracy\AP_Mocap_test6_AllFeatureFound_DepO_2_DepT_2.csv','AP_all_SubC');
% filePath = ['./AP_Mocap_test6_AllFeatureFound_DepO_2_DepT_2.csv'];
filePath = ['./Mocap_test6_MStamp.csv'];
% [num,txt,raw] = xlsread(filePath,'AP_all_SubC');

[num,txt,raw] = xlsread(filePath,'Lenght_59');
classID = num(:, 1);
featureID = num(:, 2);
timeStart = num(:, 3);
timeEnd = num(:, 4);

injectedClassID = num(:, 5);
injectedID_Deprecated = num(:, 6);


injectedTimeStart = num(:, 7);
injectedTimeEnd = num(:, 8);

% depd overlap computed from Jaccard similarity
timeOverlap = num(:, 9);
depdOverlap = num(:, 10);


timeOverlapThreshold = 0.5;
depdOverlapThreshold = 1;

precision = [];
recall = [];
FScore = [];

% zero-value indicates that the identified feature motifs do not belong to any injected classes
uniqueInjectedClass = nonzeros(unique(injectedClassID));

% for each of the injected class, we have a precision and recall
for i = 1 : size(uniqueInjectedClass, 1)
    currentInjectedClassIndex = uniqueInjectedClass(i);
    
    % relevantFeatureCount used to compute recall
    relevantFeatureCount = motifClassCount(currentInjectedClassIndex);
    
    % currentFeatureCount used to compute precision
    retrievedIndex = injectedClassID == currentInjectedClassIndex;
    
    currentFeatureCount = size(nonzeros(retrievedIndex), 1);
    % filter with threshold
    preFilteredTimeOverlap = timeOverlap(retrievedIndex);
    preFilteredDepdOverlap = depdOverlap(retrievedIndex);
    
    filteredTimeOverlapIndex = preFilteredTimeOverlap >= timeOverlapThreshold;
    preFilteredDepdOverlap = preFilteredDepdOverlap(filteredTimeOverlapIndex);
    filteredDepdOverlap = preFilteredDepdOverlap(preFilteredDepdOverlap >= depdOverlapThreshold);
    
    relevantSize = size(filteredDepdOverlap, 1);
    currentPrecision = relevantSize/currentFeatureCount;
    currentRecall = relevantSize/relevantFeatureCount;
    
    currentFScore = 2 * currentPrecision * currentRecall / (currentRecall + currentPrecision);
    
    precision = [precision, currentPrecision];
    recall = [recall, currentRecall];
    FScore = [FScore, currentFScore];
end
averageFScore = mean(FScore);

fprintf('All done .\n');