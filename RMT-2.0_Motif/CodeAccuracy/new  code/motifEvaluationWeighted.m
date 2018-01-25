function [MotifEntropy, precisionMatrix, recallMatrix, FScoreMatrix] = motifEvaluationWeighted(groundTruthFile, motifFile, algorithmType, windowSize)
% MotifEntropy: precisionEntropy, recallEntropy, FScoreEntropy

% load feature count into motifFeatureCount
motifFeatureCount = csvread(groundTruthFile);

if(strcmp(algorithmType,'RMT') || strcmp(algorithmType,'RME') == 1)
    [num,txt,raw] = xlsread(motifFile, 'AP_all_SubC');
else
    window = ['Lenght_', num2str(windowSize)];
    [num,txt,raw] = xlsread(motifFile, window);
end


% matlab unique function provides default sorting
motifClass = unique(motifFeatureCount(:, 1));
motifClassCount = [];

% update motif class count
for i = 1 : size(motifClass, 1)
    currentMotifClassCount = size(nonzeros(motifFeatureCount(:, 1) == i), 1);
    motifClassCount = [motifClassCount, currentMotifClassCount];
end

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
    
    if(i == 5)
        disp(i)
    end
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
        else
            relevantSize = motifClassCount(currentInjectedClassID(j));
            % [precision, recall] = groupFeatureScores(statEntry, currentInjectedClassID(j), relevantSize, currentRetrievedSize, threshold);
            [precision, recall] = groupFeatureScoresWeighted(statEntry, currentInjectedClassID(j), relevantSize, currentRetrievedSize);
            
            precisionMatrix(i, currentInjectedClassID(j)) = precision;
            recallMatrix(i, currentInjectedClassID(j)) = recall;
            FScoreMatrix(i, currentInjectedClassID(j)) = 2 * precision * recall / (precision + recall);
        end
        
    end
    
end

[precisionMatrix, recallMatrix, FScoreMatrix] = delete_zeros(precisionMatrix, recallMatrix, FScoreMatrix);

% normMatrix = norm(FScoreMatrix);
% [precisionEntropy, recallEntropy, FScoreEntropy] = computeEntropy(precisionMatrix, recallMatrix, FScoreMatrix);
[precisionEntropy, recallEntropy, FScoreEntropy] = computeEntropyWeighted(precisionMatrix, recallMatrix, FScoreMatrix);
MotifEntropy = [precisionEntropy, recallEntropy, FScoreEntropy];
end