function [myFeature, variates] = pickLargestTimeSimgaFeaturesCutOff(featuresOfInterest, depdScale, cutOffRate)
% pick features with largest time sigma then cut off time-scope to cutOffRate
featuresOfInterest = featuresOfInterest';
[featuresOfInterest, sortedIndex] = sortrows(featuresOfInterest, 4, 'descend');
featuresOfInterest = featuresOfInterest';
depdScale = depdScale(:, sortedIndex);

myFeature = zeros(size(featuresOfInterest, 1), 2);
variates = zeros(size(depdScale, 1), 2);
myFeature(:, 1) = featuresOfInterest(:, 1);
myFeature(:, 2) = featuresOfInterest(:, 1);
myFeature(4, 1) = myFeature(4) * (1 - cutOffRate);
variates(:, 1) = depdScale(:, 1);
variates(:, 2) = depdScale(:, 1);



