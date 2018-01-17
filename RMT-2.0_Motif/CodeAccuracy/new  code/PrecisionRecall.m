clear;
clc;

% load feature count into motifFeatureCount
featureCountFilePath = './FeaturePosition_MoCap_test6.csv';
% featureCountFilePath = './1motif/Groundtruth/IndexEmbeddedFeatures/Mocap_test16/FeaturePosition_Mocap_test16.csv';
motifFeatureCount = csvread(featureCountFilePath);

% filePath = ['./AP_Mocap_test6_AllFeatureFound_DepO_2_DepT_2.csv'];
filePath = ['./Mocap_test6_MStamp.csv'];
% filePath = ['./1motif/RMT/Accuracytest16/AP_Mocap_test16_AllFeatureFound_DepO_2_DepT_2.csv'];

% [num,txt,raw] = xlsread(filePath,'AP_all_SubC');
[num,txt,raw] = xlsread(filePath,'Lenght_59');

% matlab unique function provides default sorting
motifClass = unique(motifFeatureCount(:, 1));
motifClassCount = [];

% update motif class count
for i = 1 : size(motifClass, 1)
    currentMotifClassCount = size(nonzeros(motifFeatureCount(:, 1) == i), 1);
    motifClassCount = [motifClassCount, currentMotifClassCount];
end

% Deprecated thresholds
% timeOverlapThreshold = 0.5;
% depdOverlapThreshold = 1;

% loop through classID
classID = num(:, 1);
myClassID = unique(classID);

% stateMatrix: predicated_class_size x injected_class_size
precisionMatrix = zeros(size(myClassID, 1), size(motifClassCount, 2));
recallMatrix = zeros(size(myClassID, 1), size(motifClassCount, 2));
FScoreMatrix = zeros(size(myClassID, 1), size(motifClassCount, 2));

for i = 1 : size(myClassID, 1)
    currentClassIndex = classID == myClassID(i);
    statEntry = num(currentClassIndex, :);
    
    % compute recall and precision for each entry
    featureID = statEntry(:, 2);
    timeStart = statEntry(:, 3);
    timeEnd = statEntry(:, 4);
    
    injectedClassID = statEntry(:, 5);
    injectedID_Deprecated = statEntry(:, 6);
    
    injectedTimeStart = statEntry(:, 7);
    injectedTimeEnd = statEntry(:, 8);
    
    % depd overlap computed from Jaccard similarity
    timeOverlap = statEntry(:, 9);
    depdOverlap = statEntry(:, 10);
    
    % for each of these predicated class, precision and recall for each injected class
    currentInjectedClassID = unique(injectedClassID);
    currentRetrievedSize = size(statEntry, 1); % used for precision
    
    for j = 1 : size(currentInjectedClassID, 1)
        % update statMatrix
        % group feature scores
        if(currentInjectedClassID(j) == 0)
            % precisionMatrix(i, j) = precision;
            % recallMatrix(i, j) = recall;
            % FScoreMatrix(i, j) = 2 * precision * recall / (precision + recall);
        else
            relevantSize = motifClassCount(currentInjectedClassID(j));
            [precision, recall] = groupFeatureScores(statEntry, currentInjectedClassID(j), relevantSize, currentRetrievedSize);
            
            % relevantSize = size(injectedClassID == currentInjectedClassID(j), 1);
            % injectedRelevantSize = motifClassCount(currentInjectedClassID(j));
            % precision = currentRetrievedSize / currentRetrievedSize;
            % recall = relevantSize / injectedRelevantSize;
            
            precisionMatrix(i, currentInjectedClassID(j)) = precision;
            recallMatrix(i, currentInjectedClassID(j)) = recall;
            FScoreMatrix(i, currentInjectedClassID(j)) = 2 * precision * recall / (precision + recall);
        end
        
    end
    
end

normMatrix = norm(FScoreMatrix);
[precisionEntropy, recallEntropy, FScoreEntropy] = computeEntropy(precisionMatrix, recallMatrix, FScoreMatrix);

% potentially save entropy values to files
fprintf('All done .\n');