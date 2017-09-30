function frequency = featureLookUp_SVM_UnPaired(fullDataSet, searchDataVector, isPaired)
% features are organized as: 
% 1: timeStart
% 2: timeEnd
% 3: timeCenter
% 4: depdIndex
% 5: depdOct
% 6: timeOct
% 7-end:10-D descriptor
if(isPaired == 1)
    pivotIndex = 4; % including depd index
else
    pivotIndex = 5; % excluding depd index
end

searchDataTimeCenter = searchDataVector(3);
fullDataSetTimeStart = fullDataSet(:, 1); % fullDataSet timeStart
fullDataSetTimeEnd = fullDataSet(:, 2); % fullDataSet timeEnd

% index = fullDataSetTimeStart <= searchDataTimeCenter & fullDataSetTimeEnd >= searchDataTimeCenter;
% fullDataSet = fullDataSet(index, :);
frequency = find(all(bsxfun(@eq, fullDataSet(:, pivotIndex:end), searchDataVector(pivotIndex:end)), 2));
end

