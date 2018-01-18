function [precision, recall] = groupFeatureScores(statEntry, currentInjectedClassID, relevantSize, currentRetrievedSize)
% iterate statEntry, check which one overlap with the same injected features
myStatEntry = statEntry(statEntry(:, 5) == currentInjectedClassID, :);
[uniqueRows, firstIndex, membershipIndex] = unique( myStatEntry(:,[7 8]), 'rows');
uniqueSize = size(uniqueRows, 1);
bestScore = zeros(uniqueSize, 1);

for i = 1 : uniqueSize
    resultIndex = find(membershipIndex(:) == i);
    bestTO = max(myStatEntry(resultIndex, 9));
    bestVO = max(myStatEntry(resultIndex, 10));
    
    bestScore(i) = bestTO * bestVO;
end
precision = sum(bestScore) / currentRetrievedSize;
recall = sum(bestScore) / relevantSize;
