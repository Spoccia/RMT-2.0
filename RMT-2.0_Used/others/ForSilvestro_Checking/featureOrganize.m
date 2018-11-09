function [feature1] = featureOrganize(feature1, descr1, projectMatrix, descrRange, resolution, timeSeriesLength)
% process feature matrix as the same format for matching
descr1 = descr1'*projectMatrix; % base

descr1 = clusterDescrs(descr1, descrRange, resolution);
timeCenter = feature1(2,:)';
timeSigma = feature1(4,:)';
timeStart = max(timeCenter - timeSigma, 1);
% timeSeriesLength = repmat(size(timeStart), timeSeriesLength);
timeEnd = min(timeCenter + timeSigma, timeSeriesLength);

depdIndex = feature1(1,:)';
depdOctave = feature1(5,:)';
timeOctave = feature1(6,:)';

feature1 = [timeStart, timeEnd, timeCenter, depdIndex, depdOctave, timeOctave, descr1];
end

