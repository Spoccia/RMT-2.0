function frequency = featureLookUp_Silv(fullDataSet, searchDataVector)
% search searchData in fullDataSet and return the frequency

% timeStart index: 2
% timeEnd Index: 3

searchDataTimeCenter = searchDataVector(3);
% searchDataTimeStart = searchDataVector(end-1);
% searchDataTimeEnd = searchDataVector(end);
fullDataSet(:, 2); % fullDataSet timeStart
fullDataSet(:, 1); % fullDataSet timeEnd

index = fullDataSet(:, 2) < searchDataTimeCenter & fullDataSet(:, 1) > searchDataTimeCenter;
fullDataSet = fullDataSet(index, :);
frequency = find(all(bsxfun(@eq, fullDataSet(:, 4:end), searchDataVector(4:end)), 2));
% frequency = find(all(bsxfun(@eq, fullDataSet(:, 4:end-3), searchDataVector(4:end-3)), 2));
end

