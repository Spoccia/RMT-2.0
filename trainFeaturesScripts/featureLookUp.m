function frequency = featureLookUp(fullDataSet, searchDataVector, overLapRatio)
% search searchData in fullDataSet and return the frequency

% timeStart index: 2
% timeEnd Index: 3

searchDataTimeCenter = searchDataVector(end-2);
% searchDataTimeStart = searchDataVector(end-1);
% searchDataTimeEnd = searchDataVector(end);
fullDataSet(:, end-1); % fullDataSet timeStart
fullDataSet(:, end); % fullDataSet timeEnd




index = fullDataSet(:, end-1) < searchDataTimeCenter & fullDataSet(:, end) > searchDataTimeCenter);
fullDataSet = fullDataSet(index, :);
tt = find(all(bsxfun(@eq, rawFeatures, Xtrain), 2));


end

