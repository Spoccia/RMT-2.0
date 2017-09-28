clear;
clc;

featureFolder = ['D:\Mocap _ RMT2\Features Octave 3\Features 3 octave  SD 0_5 ST 2_8'];%['/Users/sicongliu/Desktop/features/NewPara/FullScale_SigmaT28SigmaD05_Octave3'];
dataFolder = ['D:\Mocap _ RMT2\data'];%['/Users/sicongliu/Desktop/data/mocap'];
% saveFolder = '/Users/sicongliu/Desktop/features/MoCapUnionScale';
saveFolder = 'D:\Mocap _ RMT2\Features Octave 3\Features 3 octave  SD 0_5 ST 2_8\UnPairedSVMUnballanced_1\';%'.';
dataSize = 184;
trainingPercentage = 0.6;
descriptorStart = 11;
descriptorEnd = 138;
StartReductedFeatures = 5;
descriptorStartingRange =7;
% MoCap data
Array = [1, 15, 51, 81, 99, 118, 149, 179, 185];
% testing data PCA
options = [];
options.ReducedDim = 10;

AllFeatures = cell(dataSize, 1);
% depdIndex, timeStart, timeEnd, timeOctave, depdOctave, 10-D descriptor
ProcessedAllFeatures = cell(dataSize, 1);
timeSeriesLength =zeros(1,dataSize);
for i = 1 : dataSize
    featurePath = [featureFolder,'/feature_',num2str(i),'.mat'];
    AllFeatures{i} = load(featurePath); % feature is frame1 from cell structure
    dataPath = [dataFolder, '/', num2str(i), '.csv'];
    data = csvread(dataPath);
    timeSeriesLength(1,i) = size(data, 1);
    rangeFeatures = zeros(size(AllFeatures{i}.frame1, 2), 6+options.ReducedDim);
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

fprintf('Loading Data done .\n');

for queryID = 1:23 % Array(clusterID):Array(clusterID + 1) - 1
    % select Training removing  the  feature for each Class
    
    AllFeatureClass =[];
    AllFeatureRangeClass=[];
    NumOfTrainingTimeseries = 0;
    TimeSeriesSamples=[];
    TimeSeriesRangeSamples=[];
    setForClass=[];
    for clusterID =1:8
        TimeseriesSamplesSet = randomizeSet(queryID,Array(clusterID),Array(clusterID+1)-1, 0.6 );
        for i=1:size(TimeseriesSamplesSet,2)
            TimeSeriesSamples{clusterID,i}=AllFeatures{TimeseriesSamplesSet(i)}.frame1;
            TimeSeriesRangeSamples{clusterID,i}= ProcessedAllFeatures{TimeseriesSamplesSet(i),:};%rangeFeatures(TimeseriesSamplesSet(i),:);
            
%             AllFeatureClass = [AllFeatureClass,AllFeatures{TimeseriesSamplesSet(i)}.frame1];
%             AllFeatureRangeClass =[AllFeatureRangeClass; ProcessedAllFeatures{TimeseriesSamplesSet(i),:}];
        end
        setForClass{clusterID} = TimeseriesSamplesSet;
        
        NumOfTrainingTimeseries = NumOfTrainingTimeseries + size(TimeseriesSamplesSet,2);
    end
    
    for goodClass =1:8
        GoodFeatureSet=[];
        goodFeatureRangeSet=[];
        numTS = size(setForClass{goodClass},2);
        for Fset =1 :numTS
            GoodFeatureSet = [GoodFeatureSet,AllFeatures{setForClass{goodClass}(i)}.frame1];
            goodFeatureRangeSet=[goodFeatureRangeSet; ProcessedAllFeatures{setForClass{goodClass}(i),:}];
        end
    AllFeatureClass=GoodFeatureSet;
    AllFeatureRangeClass=goodFeatureRangeSet;
    
    FeatureDescriptors = AllFeatureClass(descriptorStart : descriptorEnd, :)';
    [revelantVector, relevantEigenValues] = PCA(FeatureDescriptors, options);
    ReducedFeatureDescriptors = FeatureDescriptors * revelantVector;
    
    AllFeatureRangeClass(:,7 : 6 + options.ReducedDim) = ReducedFeatureDescriptors;
    [C, Xia, ic] = unique(AllFeatureRangeClass(:,StartReductedFeatures : 6 + options.ReducedDim) , 'rows'); % ia is the remaining column
    uniqueFeatures = AllFeatureRangeClass (Xia, :);
    ReducedFeatureDescriptors = ReducedFeatureDescriptors(Xia, :);
    % uniquefeatures(7:11)=ReducedFeatureDescriptors(Xia,:);
    
    descriptorRange = zeros(2, options.ReducedDim);
    descriptorRange(1,:) = min(ReducedFeatureDescriptors);%min(uniqueFeatures(:, reducedDescriptorRange));
    descriptorRange(2,:) = max(ReducedFeatureDescriptors);%max(uniqueFeatures(:, reducedDescriptorRange));
    
    % cluster descriptors on training data with equal width histogram
    resolution = 2;
    % assume there would be duplicate here
    reducedDescriptor = clusterDescrs(ReducedFeatureDescriptors, descriptorRange, resolution);
    uniqueFeatures(:,7:6 + options.ReducedDim) = reducedDescriptor;
    [C, Xia, ic]= unique(uniqueFeatures(:,StartReductedFeatures: 6+options.ReducedDim) , 'rows'); % ia is the remaining column
    reducedDescriptor = reducedDescriptor(Xia,:);
    uniqueFeatures = uniqueFeatures(Xia,:);
    
    
    % represent the featre of each timeseries as maded for the training set.
    % this  will be used to compute the relevance of each feature to the
    % specific timeseries
    
    % Testing Phase
    % sample data from other cluster
    
    for clusterID =1:8
     TimeseriesSamplesSet = setForClass{clusterID};%randomizeSet(queryID,Array(clusterID),Array(clusterID+1)-1, 0.6 );
        for i=1:size(TimeseriesSamplesSet,2)
            TimeseriesSet = TimeSeriesSamples{clusterID,i}(:,:);
            FeatureDescriptors = TimeseriesSet(descriptorStart:descriptorEnd, :)';
            
            % [revelantVector, relevantEigenValues] = PCA(FeatureDescriptors, options);
            ReducedFeatureDescriptors = FeatureDescriptors * revelantVector;
            reducedDescriptor = clusterDescrs(ReducedFeatureDescriptors, descriptorRange, resolution);
            
            TimeSeriesRangeSamples{clusterID,i}(:,7 : 6 + options.ReducedDim)= reducedDescriptor;
        end
    end
    'data setted complete'
    % Compute the Relevance of  each feature for each timeseries rows is numner of timeseries Column is UniqueFeatures
    
    % compute TF count matrix for SVM training
    [TFMatrix, TFLabelVector] = BuildTFMatrixCandan(TimeSeriesRangeSamples, uniqueFeatures,setForClass,StartReductedFeatures,goodClass);
    
    % use SVM to train TFMatrix
    TFMatrix = sparse(TFMatrix);
    model = train(TFLabelVector, TFMatrix, '-s 5');
    
    fprintf('save training index: %d to file .\n', queryID);
    % save training models
    if(exist(saveFolder,'dir')==0)
        mkdir(saveFolder);
    end
%     for clusterID = 1 : 8
       savePathImportance = [saveFolder, 'importance_Class_', num2str(goodClass), '_', num2str(queryID), '.csv'];
       savePathUniqueFeatures = [saveFolder, 'uniqueFeature_Class_', num2str(goodClass), '_', num2str(queryID), '.csv'];
       savePathProjectVector = [saveFolder, 'projectMatrix_Class_', num2str(goodClass), '_', num2str(queryID), '.csv'];
       savePathDescrRange = [saveFolder, 'descrRange_Class_', num2str(goodClass), '_', num2str(queryID), '.csv'];
       
       csvwrite(savePathImportance, model.w);%(clusterID, :)');
       csvwrite(savePathUniqueFeatures, uniqueFeatures);
       csvwrite(savePathProjectVector, revelantVector);
       csvwrite(savePathDescrRange, descriptorRange);
%     end
    end
end