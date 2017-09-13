function frequency = featureLookUp(fullDataSet, searchDataVector)
% search searchData in fullDataSet and return the frequency

% timeStart index: 2
% timeEnd Index: 3

searchDataTimeCenter = searchDataVector(end-2);
% searchDataTimeStart = searchDataVector(end-1);
% searchDataTimeEnd = searchDataVector(end);
fullDataSet(:, end-1); % fullDataSet timeStart
fullDataSet(:, end); % fullDataSet timeEnd

index = fullDataSet(:, end-1) < searchDataTimeCenter & fullDataSet(:, end) > searchDataTimeCenter;
fullDataSet = fullDataSet(index, :);
frequency = find(all(bsxfun(@eq, fullDataSet(:, 1:end-3), searchDataVector(1:end-3)), 2));
% frequency = find(all(bsxfun(@eq, fullDataSet(:, 4:end-3), searchDataVector(4:end-3)), 2));
end

