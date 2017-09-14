function frequency = featureLookUp(fullDataSet, searchDataVector)
% features are organized as: 
% 1: timeStart
% 2: timeEnd
% 3: timeCenter
% 4: depdIndex
% 5: depdOct
% 6: timeOct
% 7-end:10-D descriptor

searchDataTimeCenter = searchDataVector(3);
fullDataSetTimeStart = fullDataSet(:, 1); % fullDataSet timeStart
fullDataSetTimeEnd = fullDataSet(:, 2); % fullDataSet timeEnd

index = fullDataSetTimeStart < searchDataTimeCenter & fullDataSetTimeEnd > searchDataTimeCenter;
fullDataSet = fullDataSet(index, :);
frequency = find(all(bsxfun(@eq, fullDataSet(:, 4:end), searchDataVector(4:end)), 2));
end

