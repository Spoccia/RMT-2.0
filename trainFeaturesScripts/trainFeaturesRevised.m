% compute contextual feature signifiacne for multi-variate (RMT) time series features
clear;
clc;
featureFolder = ['/Users/sicongliu/Desktop/features/NewPara/UnionScale_SigmaT28SigmaD05'];
dataFolder = ['/Users/sicongliu/Desktop/data/mocap'];
saveFolder = '/Users/sicongliu/Desktop/features/NewPara/UnionScale_SigmaT28SigmaD05';
dataSize = 184;

% MoCap data
Array = [1, 15, 51, 81, 99, 118, 149, 179, 185];

% load all features
AllFeatures = cell(dataSize, 1);
% features are organized as: 
% 1: timeStart
% 2: timeEnd
% 3: timeCenter
% 4: depdIndex
% 5: depdOct
% 6: timeOct
% 7-end:10-D descriptor

descriptorStart = 11;
descriptorEnd = 138;
reducedDescriptorRange = 7 : 16;
reducedDimension = 5;
featureDepdIndex = 1;
featureTimeIndex = 2;
featureDepdSigmaIndex = 3;
featureTimeSigmaIndex = 4;
featureDepdOctaveIndex = 5;
featureTimeOctaveIndex = 6;

% isPaired variable, 0 - unpaired, 1 - paired
isPaired = 1; 

ProcessedAllFeatures = cell(dataSize, 1);
for i = 1 : dataSize
    featurePath = [featureFolder,'/feature',num2str(i),'.mat'];
    AllFeatures{i} = load(featurePath); % feature is frame1 from cell structure
    dataPath = [dataFolder, '/', num2str(i), '.csv'];
    data = csvread(dataPath);
    timeSeriesLength = size(data, 1);
    rangeFeatures = zeros(size(AllFeatures{i}.frame1, 2), 16);
    
    for j = 1 : size(AllFeatures{i}.frame1, 2)
        % time ranges from timeCenter - 1*sigmaTime to timeCenter + 1*sigmaTime
        timeCenter = AllFeatures{i}.frame1(featureTimeIndex, j);
        timeSigma = AllFeatures{i}.frame1(featureTimeSigmaIndex, j);
        timeStart = max(timeCenter - timeSigma, 1);
        timeEnd = min(timeCenter + timeSigma, timeSeriesLength);
        depdIndex = AllFeatures{i}.frame1(featureDepdIndex, j);
        depdOctave = AllFeatures{i}.frame1(featureDepdOctaveIndex, j); % depd octave
        timeOctave = AllFeatures{i}.frame1(featureTimeOctaveIndex, j); % time octave
        
        rangeFeatures(j, 1) = timeStart;
        rangeFeatures(j, 2) = timeEnd;
        rangeFeatures(j, 3) = timeCenter;
        rangeFeatures(j, 4) = depdIndex;
        rangeFeatures(j, 5) = depdOctave;
        rangeFeatures(j, 6) = timeOctave;
    end
    ProcessedAllFeatures{i} = rangeFeatures;
end

p = tic;
for clusterID = 1:8
    for queryID = Array(clusterID):Array(clusterID + 1) - 1
        fprintf('query ID: %d, clusterID: %d. \n', queryID, clusterID);
        
        % each cluster use 60% train 40%(the rest) for test
        relevantFeatures = [];
        relevantRangeFeatures = [];
        relevantDataSet = randomizeSet(queryID,Array(clusterID),Array(clusterID+1)-1, 0.6 );
        for i=1:size(relevantDataSet,2)
            relevantFeatures = [relevantFeatures, AllFeatures{relevantDataSet(i)}.frame1];%countTrainingTimeSeries + Array(clusterID)-1}.frame1];
            relevantRangeFeatures = [relevantRangeFeatures; ProcessedAllFeatures{relevantDataSet(i)}];%countTrainingTimeSeries + Array(clusterID)-1}.frame1];
        end
        
        % load test data
        irRelevantDataSet=[];
        irRelevantFeatures = [];
        irRelevantRangeFeatures = [];
        for i = 1: size(Array, 2)-1
            if(i == clusterID)
            else
                irRelevantDataSet = [irRelevantDataSet,randomizeSet(queryID,Array(i),Array(i+1)-1, 0.6 )];
            end
        end
        for i=1:size(irRelevantDataSet,2)
            irRelevantFeatures = [irRelevantFeatures, AllFeatures{irRelevantDataSet(i)}.frame1];
            irRelevantRangeFeatures = [irRelevantRangeFeatures; ProcessedAllFeatures{irRelevantDataSet(i)}];
            
        end
        
        relevantFeatureDescriptors = relevantFeatures(descriptorStart:descriptorEnd, :)';
        
        % train SVD on training dataset, use SVD on descriptors only
        options = [];
        options.ReducedDim = reducedDimension;
        % PCA, trainVector is the project matrix
        
        [revelantVector, relevantEigenValues] = PCA(relevantFeatureDescriptors, options);
        relevantFeatureDescriptors = relevantFeatureDescriptors * revelantVector;
       
        [C, Xia, ic]= unique(relevantRangeFeatures, 'rows'); % ia is the remaining column
        uniqueFeatures = (relevantRangeFeatures(Xia, :));
        
        descriptorRange = zeros(2, options.ReducedDim);
        descriptorRange(1,:) = min(uniqueFeatures(:, reducedDescriptorRange));
        descriptorRange(2,:) = max(uniqueFeatures(:, reducedDescriptorRange));
        
        % cluster descriptors on training data with equal width histogram
        resolution = 2;
        
        % assume there would be duplicate here
        relevantRangeFeatures(:, reducedDescriptorRange) = clusterDescrs(relevantFeatureDescriptors, descriptorRange, resolution);
        
        % update raw feature
        uniqueFeatures(:, reducedDescriptorRange) = clusterDescrs(uniqueFeatures(:, reducedDescriptorRange), descriptorRange, resolution);
        
        % unique again
        [C, Xia, ic]= unique(uniqueFeatures, 'rows'); % ia is the remaining column
        uniqueFeatures = (uniqueFeatures(Xia, :));
        
        irrelevantFeatureDescriptors = irRelevantFeatures(descriptorStart:descriptorEnd, :)';
        
        % traing SVD on testing data
        [irrevelantVector, irrelevantEigenValues] = PCA(irrelevantFeatureDescriptors, options);
        irrelevantFeatureDescriptors = irrelevantFeatureDescriptors * irrevelantVector;
        
        % testing data clustering
        irRelevantRangeFeatures(:, reducedDescriptorRange) = clusterDescrs(irrelevantFeatureDescriptors, descriptorRange, resolution);
        
        % relevance
        relevanceCount = zeros(size(uniqueFeatures, 1), 2);
        
        % using testing and training to compute relevance feedback
        for i = 1 : size(relevanceCount, 1)
            relevantFeatureVector = uniqueFeatures(i,:);
            % do the look up for both relevant range features and irrelevant range features
            RelevanceVector = featureLookUp(relevantRangeFeatures, relevantFeatureVector, isPaired);
            relevanceCount(i, 1) = size(RelevanceVector, 1);
            
            IrRelevanceVector = featureLookUp(irRelevantRangeFeatures, relevantFeatureVector, isPaired);
            relevanceCount(i, 2) = size(IrRelevanceVector, 1);
        end
        % compute score, no need to sort
        
        Relevance = size(relevantDataSet, 2); % original training size
        
        IrRelevance = size(irRelevantDataSet, 2);
        relevantFeatureImportance = relevanceFeedback(relevanceCount, Relevance, IrRelevance);
        
        csvwrite([saveFolder,'/importance',num2str(queryID), '.csv'], relevantFeatureImportance);
        csvwrite([saveFolder,'/uniqueFeature',num2str(queryID), '.csv'], uniqueFeatures);
        
        % save project matrix
        csvwrite([saveFolder,'/projectMatrix',num2str(queryID), '.csv'], revelantVector);
        
        % save projected descr range
        csvwrite([saveFolder,'/descrRange', num2str(queryID), '.csv'], descriptorRange);
        
        csvwrite([saveFolder,'/testObj', num2str(queryID),'.csv'], irRelevantDataSet);
    end
end
time = toc(p);
csvwrite([saveFolder,'/trainingTime.csv'], time);
fprintf('All done, \n');
