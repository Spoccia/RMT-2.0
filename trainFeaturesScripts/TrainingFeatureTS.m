clear;
clc;

featureFolder = ['D:\Test Traning\dataFeatures'];
dataFolder = ['D:\Test Traning\data'];
% saveFolder = '/Users/sicongliu/Desktop/features/MoCapUnionScale';
saveFolder = '.';
dataSize = 184;
trainingPercentage = 0.6;
% MoCap data
Array = [1, 15, 51, 81, 99, 118, 149, 179, 185];
% testing data PCA
    options = [];
    options.ReducedDim = 5;
    
    AllFeatures = cell(dataSize, 1);
% depdIndex, timeStart, timeEnd, timeOctave, depdOctave, 10-D descriptor
ProcessedAllFeatures = cell(dataSize, 1);
timeSeriesLength =zeros(1,dataSize);
for i = 1 : dataSize
    featurePath = [featureFolder,'/feature',num2str(i),'.mat'];
    AllFeatures{i} = load(featurePath); % feature is frame1 from cell structure
    dataPath = [dataFolder, '/', num2str(i), '.csv'];
    data = csvread(dataPath);
    timeSeriesLength(1,i) = size(data, 1);
    rangeFeatures = zeros(size(AllFeatures{i}.frame1, 2), 11);
    for j = 1 : size(AllFeatures{i}.frame1, 2)
        % time ranges from timeCenter - 1*sigmaTime to timeCenter + 1*sigmaTime
        timeStart = max(AllFeatures{i}.frame1(2, j) - AllFeatures{i}.frame1(4, j), 1);
        timeEnd = min(AllFeatures{i}.frame1(2, j) + AllFeatures{i}.frame1(4, j), timeSeriesLength(1,i));
        rangeFeatures(j, 4) = AllFeatures{i}.frame1(1, j); % Dependency center
        rangeFeatures(j, 3) = AllFeatures{i}.frame1(2, j); % Time center
        rangeFeatures(j, 5) = AllFeatures{i}.frame1(5, j); % Dep octave
        rangeFeatures(j, 6) = AllFeatures{i}.frame1(6, j); % Time octave
        rangeFeatures(j, 1) = timeStart;
        rangeFeatures(j, 2) = timeEnd;
    end
    ProcessedAllFeatures{i} = rangeFeatures;
end


for queryID = Array(clusterID):Array(clusterID + 1) - 1
        %select Training removing  the  feature for each Class
        AllFeatureClass =[];
        AllFeatureRangeClass=[];
        NumOfTrainingTimeseries = 0;
        for clusterID =1:8
            TimeseriesSamplesSet = randomizeSet(queryID,Array(clusterID),Array(clusterID+1)-1, 0.6 );
            for i=1:size(TimeseriesSamplesSet,2)
                TimeSeriesSamples{clusterID,i}=AllFeatures{relevantDataSet(i)}.frame1; 
                TimeSeriesRangeSamples{clusterID,i}= rangeFeatures(relevantDataSet(i),:);
                AllFeatureClass = [AllFeatureClass,AllFeatures{relevantDataSet(i)}.frame1];
                AllFeatureRangeClass =[AllFeatureRangeClass;rangeFeatures(relevantDataSet(i),:)];
            end
            setForClass{clusterID} = TimeseriesSamplesSet;
            NumOfTrainingTimeseries = NumOfTrainingTimeseries + size(TimeseriesSamplesSet,2);
        end
        
        FeatureDescriptors = AllFeatureClass(descriptorStart:descriptorEnd, :)';
        [revelantVector, relevantEigenValues] = PCA(FeatureDescriptors, options);
        ReducedFeatureDescriptors = FeatureDescriptors * revelantVector;
        
        [C, Xia, ic]= unique(ReducedFeatureDescriptors , 'rows'); % ia is the remaining column
        uniqueFeatures = (AllFeatureRangeClass (Xia, :));
%         uniquefeatures(7:11)=ReducedFeatureDescriptors(Xia,:);
        
        descriptorRange = zeros(2, options.ReducedDim);
        descriptorRange(1,:) = min(uniqueFeatures(:, reducedDescriptorRange));
        descriptorRange(2,:) = max(uniqueFeatures(:, reducedDescriptorRange));
        
        % cluster descriptors on training data with equal width histogram
        resolution = 2;
        % assume there would be duplicate here
        reducedDescriptor = clusterDescrs(ReducedFeatureDescriptors, descriptorRange, resolution);
        [C, Xia, ic]= unique(reducedDescriptor , 'rows'); % ia is the remaining column
        reducedDescriptor = reducedDescriptor(Xia,:);
        uniqueFeatures = uniqueFeatures(Xia,:);
        uniquefeatures(7:11) = reducedDescriptor;
  
 % represent the featre of each timeseries as maded for the training set. 
 % this  will be used to compute the relevance of each feature to the
 % specific timeseries
        for clusterID =1:8
            TimeseriesSamplesSet = randomizeSet(queryID,Array(clusterID),Array(clusterID+1)-1, 0.6 );
            for i=1:size(TimeseriesSamplesSet,2)
                TimeseriesSet = TimeSeriesSamples{clusterID,i}(:,:);
                FeatureDescriptors = TimeseriesSet(descriptorStart:descriptorEnd, :)';
                [revelantVector, relevantEigenValues] = PCA(FeatureDescriptors, options);
                ReducedFeatureDescriptors = FeatureDescriptors * revelantVector;
                reducedDescriptor = clusterDescrs(ReducedFeatureDescriptors, descriptorRange, resolution);
                TimeSeriesRangeSamples{clusterID,i}(:,7:11)= reducedDescriptor;
            end
        end
        
%% Compute the Relevance of  each feature for each timeseries rows is numner of timeseries Column is UniqueFeatures
        
end