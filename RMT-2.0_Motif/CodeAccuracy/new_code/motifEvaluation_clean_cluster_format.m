function [MotifEntropy, precisionMatrix, recallMatrix, FScoreMatrix] = motifEvaluation_clean_cluster_format(groundTruthFile, motifFile, clean_cluster_file, algorithmType, windowSize, threshold)
% MotifEntropy: precisionEntropy, recallEntropy, FScoreEntropy

motifFeatureCount = csvread(groundTruthFile);
if(strcmp(algorithmType,'RMT') || strcmp(algorithmType,'RME') == 1)
    [num,txt,raw] = xlsread(motifFile, 'AP_all_SubC');
else
    window = ['Lenght_', num2str(windowSize)];
    [num,txt,raw] = xlsread(motifFile, window);
end
clean_cluster = csvread(clean_cluster_file);
num(:, 1) = clean_cluster;
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

% ignore single cluster elements
[myClassID, classID, num] = filter_single_cluster(myClassID, classID, num);

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
    
    % injectedClassID = statEntry(:, 5);
    injectedID_Deprecated = statEntry(:, 6);
    
    injectedTimeStart = statEntry(:, 7);
    injectedTimeEnd = statEntry(:, 8);
    
    % depd overlap computed from Jaccard similarity
    timeOverlap = statEntry(:, 9);
    depdOverlap = statEntry(:, 10);
    
    % for each of these predicated class, precision and recall for each injected class
    % currentInjectedClassID = unique(injectedClassID);
    currentRetrievedSize = size(statEntry, 1); % used for precision
    
    for j = 1 : size(motifClassCount, 2)
        % update statMatrix
        % group feature scores
        relevantSize = motifClassCount(j); % for this precision of current class
        [precision, recall] = groupFeatureScores(statEntry, j, relevantSize, currentRetrievedSize, threshold);
        
        precisionMatrix(i, j) = precision;
        recallMatrix(i, j) = recall;
        FScoreMatrix(i, j) = 2 * precision * recall / (precision + recall);
        
    end
    
end

[precisionMatrix, recallMatrix, FScoreMatrix] = delete_zeros(precisionMatrix, recallMatrix, FScoreMatrix);

[precisionEntropy, recallEntropy, FScoreEntropy] = computeEntropy(precisionMatrix, recallMatrix, FScoreMatrix);
MotifEntropy = [precisionEntropy, recallEntropy, FScoreEntropy];
end