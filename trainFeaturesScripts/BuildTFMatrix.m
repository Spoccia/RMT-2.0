function [TFMatrix, TFLabelVector] = BuildTFMatrix(TimeSeriesRangeSamples, uniqueFeatures)
% count the membership and frequency of features from TimeSeriesRangeSamples in uniqueFeatures
% uniqueFeatures: feature instances are organized by rows
% TimeSeriesRangeSamples cell structure: {TimeSeriesCluster, TimeSeriesIndex}

CLUSTER_SIZE = size(TimeSeriesRangeSamples, 1);
UNIQUE_FEATURE_SIZE = size(uniqueFeatures, 1);

TFMatrix = [];
TFLabelVector = [];
OCTAVE_START = 5; % starting index of depd octave

for clusterID = 1 : CLUSTER_SIZE
    for TSID  = 1 :  TIME_SERIES_SIZE
        currentFeatureSet = TimeSeriesRangeSamples{clusterID, TSID};
        
        % count the frequency of each unique features in each of the time series
        current_TF_vector = zeros(1, size(uniqueFeatures, 1));
        for k = 1 : UNIQUE_FEATURE_SIZE
            
            % prepare to populate TFMatrix(j, :)
            current_unique_feature = uniqueFeatures(k, :);
            frequency = find(all(bsxfun(@eq, currentFeatureSet(:, OCTAVE_START : end), current_unique_feature(OCTAVE_START : end)), 2));
            current_TF_vector(k) = size(frequency, 1);
        end
        TFMatrix = [TFMatrix; current_TF_vector];
        TFLabelVector = [TFLabelVector; clusterID];
    end
end
end

