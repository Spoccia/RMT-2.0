function [myRandom, sortedRangePivotIndex] = pickRandomFeatures(featuresOfInterest, depdScale, numOfFeatures)
% pick features with different lengths and variate
myRandom = [];

% find pivot of different time sigma
timeSigma = featuresOfInterest(4, :);
uniqueTimeSigmaValues = unique(timeSigma);

unsortedRangePivotIndex = zeros(size(uniqueTimeSigmaValues, 2), 2);
sortedRangePivotIndex = zeros(size(uniqueTimeSigmaValues, 2), 2);
elementCount = [];
pivotIndex = [];
for i = 1 : size(uniqueTimeSigmaValues, 2)
    sameValueIndex = find(timeSigma == uniqueTimeSigmaValues(i));
    elementCount = [elementCount, size(sameValueIndex, 2)];
    pivotIndex = [pivotIndex, sameValueIndex(1)];
    unsortedRangePivotIndex(i, 1) = sameValueIndex(1);
    unsortedRangePivotIndex(i, 2) = sameValueIndex(1) + size(sameValueIndex, 2) - 1;
end

% sort on the number of elements within each pivot-range 
[sortedCount, sortedIndex] = sort(elementCount, 'descend');

for i = 1 : size(sortedRangePivotIndex, 1)
    sortedRangePivotIndex(i, :) = unsortedRangePivotIndex(sortedIndex(i), :);
end

% pick features that share different time sigma and variate scope -- use round robin manner
for i = 1 : numOfFeatures
    intervalIndex = mod(i, size(sortedCount, 2));

    startIndex = sortedRangePivotIndex(intervalIndex, 1);
    endIndex = sortedRangePivotIndex(intervalIndex, 2);
    currentRandomIndex = randi([startIndex, endIndex], 1, 1);
    myRandom = [myRandom, currentRandomIndex];
end