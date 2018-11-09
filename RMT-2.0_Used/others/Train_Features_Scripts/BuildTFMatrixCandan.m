function [TFMatrix, TFLabelVector] = BuildTFMatrixCandan(TimeSeriesRangeSamples, uniqueFeatures,setForClass,StartReductedFeatures,goodCluster)
% count the membership and frequency of features from TimeSeriesRangeSamples in uniqueFeatures
% uniqueFeatures: feature instances are organized by rows
% TimeSeriesRangeSamples cell structure: {TimeSeriesCluster, TimeSeriesIndex}

CLUSTER_SIZE = size(TimeSeriesRangeSamples, 1);
UNIQUE_FEATURE_SIZE = size(uniqueFeatures, 1);

TFMatrix = [];
TFLabelVector = [];
% OCTAVE_START = 5; % starting index of depd octave

for clusterID = 1 : CLUSTER_SIZE
    TIME_SERIES_SIZE_FOR_CLUSTERID = size(setForClass{clusterID}, 2);% TIME_SERIES_SIZE = size(TimeSeriesRangeSamples{clusterID});
    Labels = ones(TIME_SERIES_SIZE_FOR_CLUSTERID,1);
    if(clusterID ~=  goodCluster)
        Labels=Labels*2;
    end
    for TSIndex  = 1 :  TIME_SERIES_SIZE_FOR_CLUSTERID
        currentFeatureSet = TimeSeriesRangeSamples{clusterID, TSIndex};
        
        % count the frequency of each unique features in each of the time series
        current_TF_vector = zeros(1, size(uniqueFeatures, 1));
        for k = 1 : UNIQUE_FEATURE_SIZE
            
            % prepare to populate TFMatrix(j, :)
            current_unique_feature = uniqueFeatures(k, :);
            frequency = find(all(bsxfun(@eq, currentFeatureSet(:, StartReductedFeatures : end), current_unique_feature(StartReductedFeatures : end)), 2));
            current_TF_vector(k) = size(frequency, 1);
        end
        TFMatrix = [TFMatrix; current_TF_vector];
%         TFLabelVector = [TFLabelVector; clusterID];
    end
    TFLabelVector= [TFLabelVector;Labels];
end
end

