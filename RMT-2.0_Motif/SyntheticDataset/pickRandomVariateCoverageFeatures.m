function [myPick_Variate, variates] = pickRandomVariateCoverageFeatures(featuresOfInterest, depdScale)
% pick a random feature 
depd_size = size(depdScale, 2);
myIndex = randi(depd_size);

myPick_Variate = featuresOfInterest(:, myIndex);
variates = depdScale(:, myIndex);