function myRandom = pickRandomFeatures(featuresOfInterest, depdScale, numOfFeatures)
% pick features with different lengths and variate
myRandom = [];

% find pivot of different time sigma
timeSigma = featuresOfInterest(4, :);
uniqueTimeSigmaValues = unique(timeSigma);
numOfFeatures = min(numOfFeatures, size(uniqueTimeSigmaValues, 2));

pivotIndex = [];
for i = 1 : numOfFeatures
    sameValueIndex = find(timeSigma == uniqueTimeSigmaValues(i));
    pivotIndex = [pivotIndex, sameValueIndex(1)];
end

% pick features that share different time sigma and variate scope
myDepdScale = [];
for i = 1 : size(pivotIndex, 2)
    iteration = 1;
    currentIndex = pivotIndex(i);
    currentDepdScale = depdScale(currentIndex);
    
    while(ismember(currentDepdScale, myDepdScale) & iteration < 10)
       currentIndex = currentIndex + 1;
       currentDepdScale = depdScale(currentIndex);
       iteration = iteration + 1;
    end
    myDepdScale = [myDepdScale, currentDepdScale];
    myRandom = [myRandom, currentIndex]; 
end