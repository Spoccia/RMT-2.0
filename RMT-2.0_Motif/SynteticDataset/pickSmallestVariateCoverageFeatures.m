function [myPick_Variate, variates] = pickSmallestVariateCoverageFeatures(featuresOfInterest, depdScale)
% pick features with smallest variate coverage

myMin = size(depdScale, 2);
myIndex = 0;
for i = 1 : size(depdScale, 2)
    currentSize = nnz(depdScale(:, 1));
    if(currentSize < myMin)
        myIndex = i;
        myMin = currentSize;
    end
    
end
myPick_Variate = featuresOfInterest(:, myIndex);
variates = depdScale(:, myIndex);