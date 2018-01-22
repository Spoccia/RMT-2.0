function [myPick_Variate, variates] = pickLargestVariateCoverageFeatures(featuresOfInterest, depdScale)
% pick features with largest variate coverage

myMax = 0;
myIndex = 0;
for i = 1 : size(depdScale, 2)
    currentSize = nnz(depdScale(:, i));
    if(currentSize > myMax)
        myIndex = i;
        myMax = currentSize;
    end
    
end
myPick_Variate = featuresOfInterest(:, myIndex);
variates = depdScale(:, myIndex);