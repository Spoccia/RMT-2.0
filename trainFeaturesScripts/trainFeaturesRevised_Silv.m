% organize time series result into SVD, first use SVD on descriptors, then use relevant and irrelavant count
clear;
clc;

% classIndex = csvread('./classindex.csv');

featureFolder = ['D:\Test Traning\dataFeatures'];
dataFolder = ['D:\Test Traning\data'];
% saveFolder = '/Users/sicongliu/Desktop/features/MoCapUnionScale';
saveFolder = '.';
dataSize = 184;

% MoCap data
Array = [1, 15, 51, 81, 99, 118, 149, 179, 185];
% Array = [1, 15, 51, 81, 99, 118, 149, 179];

% load all features
AllFeatures = cell(dataSize, 1);
% depdIndex, timeStart, timeEnd, timeOctave, depdOctave, 10-D descriptor
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
        timeStart = max(AllFeatures{i}.frame1(2, j) - AllFeatures{i}.frame1(4, j), 1);
        timeEnd = min(AllFeatures{i}.frame1(2, j) + AllFeatures{i}.frame1(4, j), timeSeriesLength);
        rangeFeatures(j, 4) = AllFeatures{i}.frame1(1, j); % Dependency center
        rangeFeatures(j, 3) = AllFeatures{i}.frame1(2, j); % Time center
        rangeFeatures(j, 5) = AllFeatures{i}.frame1(5, j); % Dep octave
        rangeFeatures(j, 6) = AllFeatures{i}.frame1(6, j); % Time octave
        rangeFeatures(j, end) = AllFeatures{i}.frame1(2, j);
        rangeFeatures(j, 1) = timeStart;
        rangeFeatures(j, 2) = timeEnd;
    end
    ProcessedAllFeatures = rangeFeatures;
end

p = tic;
for clusterID = 1:8
    for queryID = Array(clusterID):Array(clusterID + 1) - 1
        fprintf('query ID: %d, clusterID: %d. \n', queryID, clusterID);
        testData=[];
        for i = 1: size(Array, 2)-1
            if(i == clusterID)
            else
                dataFromOtherCluster = Array(i):Array(i+1)-1;
                trainSize = floor(size(dataFromOtherCluster, 2)*0.6);
                tempData = dataFromOtherCluster(1 : trainSize);
                testData = [testData tempData];
            end
        end
        
        % each cluster use 60% train 40%(the rest) for test
        dataFromCurrentCluster = Array(clusterID):Array(clusterID+1)-1;
        % currentClusterFileSize = size(dataFromCurrentCluster, 2);
        
        trainSize = floor(size(dataFromCurrentCluster, 2)*0.6);
        % trainingData1 = dataFromCurrentCluster(2 : trainSize+1);
        trainingDataStart = dataFromCurrentCluster(2);
        
        testData = testData';
        trainingFeatures = [];
        rangeFeatures = [];
        
        countTrainingTimeSeries = 1;
        % load training data
        % clusterID = 2;
        % queryID = 1;
    
        while(countTrainingTimeSeries <=trainSize)%for i = 1 : size(trainingData1, 2) % true data
            if (countTrainingTimeSeries + Array(clusterID)-1)== queryID
                trainSize=trainSize+1;
            else
                % dataElementIndex = trainingData1(i);
                
                % XsaveFolder1 = [featureFolder,'/feature',num2str(dataElementIndex),'.mat'];
                % load(XsaveFolder1);
                trainingFeatures = [trainingFeatures AllFeatures{countTrainingTimeSeries + Array(clusterID)-1}.frame1];

            end
            countTrainingTimeSeries = countTrainingTimeSeries+1;
        end
        
        timeStart = trainingFeatures(2, :) - trainingFeatures(4, :);%, 1
        timeStart(timeStart>1)= 1;
        timeEnd = trainingFeatures(2, :) + trainingFeatures(4, :);%, timeSeriesLength
        timeEnd(timeEnd>timeSeriesLength) = timeSeriesLength;
        
        Training_rangeFeatures = zeros(16,size(trainingFeatures,2));        
        Training_rangeFeatures(1,:)=timeStart;
        Training_rangeFeatures(2,:)=timeEnd;
        Training_rangeFeatures(3,:)=trainingFeatures(2, :);
        Training_rangeFeatures(4,:)=trainingFeatures(1, :);
        Training_rangeFeatures(5,:)=trainingFeatures(5, :);
        Training_rangeFeatures(6,:)=trainingFeatures(6, :);
        
        featureDepd = trainingFeatures(1, :);
        featureTime = trainingFeatures(2, :);
        featureDepdOctave = trainingFeatures(5, :);
        featureTimeOctave = trainingFeatures(6, :);
        Training_rangeFeatures()
        trainingDescriptors = trainingFeatures(8:135, :)';
        
        % train SVD on training dataset, use SVD on descriptors only
        options = [];
        options.ReducedDim = 10;
        % PCA, trainVector is the project matrix
        
        [trainedVector, trainValues] = PCA(trainingDescriptors',options);
        % trainingDescriptors = trainingDescriptors*trainedVector;
        Training_rangeFeatures(7:16,:) = trainedVector';
        
%   %      rawFeatures = [ featureDepd'  trainedVector featureTime' featureDepdOctave' featureTimeOctave'];
% %         [C, Xia, ic]= unique(rawFeatures(:, end-3), 'rows'); % ia is the remaining column
% %         uniqueFeatures = (rawFeatures(Xia, :));
        
        [C,Xia,ic] = unique(Training_rangeFeatures(3:end,:)','rows');
        UniqueFeatures_Silv = Training_rangeFeatures(:,Xia);
        
% %         descriptorRange = zeros(2, size(trainedVector, 2));
% %         descriptorRange(1,:) = min(uniqueFeatures(:,5:end));
% %         descriptorRange(2,:) = max(uniqueFeatures(:,5:end));
        
        descriptorRange_Silv = zeros(2,options.ReducedDim);
        descriptorRange_Silv(1,:) = min(UniqueFeatures_Silv(7:end,:)');
        descriptorRange_Silv(2,:) = max(UniqueFeatures_Silv(7:end,:)');
        
        % cluster descriptors on training data
        
        resolution = 2;
        % assume there would be duplicate here
        % rawFeatures(:, 5:end) = clusterDescrs(trainedVector, descriptorRange, resolution);
% %         rawFeatures(:, 2:end-3) = clusterDescrs(trainedVector, descriptorRange, resolution);
        supportVar = clusterDescrs(trainedVector, descriptorRange_Silv, resolution);
        Training_rangeFeatures(7:16,:) =supportVar';
        % update raw feature
        % uniqueFeatures(:, 5:end) = clusterDescrs(uniqueFeatures(:, 5:end), descriptorRange, resolution);

% %         uniqueFeatures(:, 2:end-3) = clusterDescrs(uniqueFeatures(:, 5:end), descriptorRange, resolution);
        supportVar = clusterDescrs(UniqueFeatures_Silv(7:end,:)', descriptorRange_Silv, resolution);
        UniqueFeatures_Silv(7:end,:) = supportVar';
        
%         % unique again
%         [C, Xia, ic]= unique(uniqueFeatures(:, end-3), 'rows'); % ia is the remaining column
%         uniqueFeatures = (uniqueFeatures(Xia, :));
        
         [C, Xia, ic]=unique(UniqueFeatures_Silv(3:end,:)', 'rows');
        UniqueFeatures_Silv = UniqueFeatures_Silv(:,Xia);
        % load test data
        testFeatures = [];
        for i = 1 : size(testData, 1)
            dataElementIndex = testData(i);
            %             XsaveFolder1 = [featureFolder,'/feature',num2str(dataElementIndex),'.mat'];
            %             load(XsaveFolder1);
            testFeatures = [testFeatures AllFeatures{dataElementIndex}.frame1];
        end
        
        featureDepdCenter = testFeatures(1, :);
        featureTimeCenter = testFeatures(2, :);
        testFeatureTimeOctave = testFeatures(6, :);
        testFeatureDepdOctave = testFeatures(5, :);
        testFeatureDescriptor = testFeatures(8:135, :)';
        
        % traing SVD on testing data
        % SVD on test data descriptors
        
        % testing data PCA
        options = [];
        options.ReducedDim = 10;
        row=0;
        
        [trainedVector1, trainValues] = PCA(testFeatureDescriptor',options);
        % testFeatureDescriptor = testFeatureDescriptor*trainedVector;
        testFeatureDescriptor = trainedVector1;
        % testing data clustering
        testFeatureDescriptor = clusterDescrs(testFeatureDescriptor, descriptorRange, resolution);
        
        XappCount = zeros(size(uniqueFeatures, 1), 2);
        
        rawTestFeatures =[featureDepdCenter' featureTimeCenter' testFeatureDepdOctave' testFeatureTimeOctave'  testFeatureDescriptor];
        
        % using testing and training to compute relevance feedback
        for i = 1 : size(XappCount, 1)
            % Xtrain = uniqueFeatures(i,:);
            Xtrain = uniqueFeatures(i,:);
            
            % need to modify the look-up function
            
            % compute the frequency of a training vector appears in the
            % training set
            tt = find(all(bsxfun(@eq, rawFeatures, Xtrain), 2));
            XappCount(i, 1) = size(tt, 1);
            
            % compute the frequency of a training vector appears in the
            % testing set
            tt = find(all(bsxfun(@eq, rawTestFeatures, Xtrain), 2));
            XappCount(i, 2) = size(tt, 1);
        end
        % compute score, no need to sort
        Relevance = floor(size(dataFromCurrentCluster, 2)*0.6); % original training size
        InRelevance = size(testData, 1);
        
        featureImportance = relevanceFeedback(XappCount, Relevance, InRelevance);
        % relevance feedback done
        
        csvwrite([saveFolder,'/importance',num2str(queryID), '_', num2str(clusterID), '.csv'], featureImportance);
        csvwrite([saveFolder,'/uniqueFeature',num2str(queryID), '_', num2str(clusterID), '.csv'], uniqueFeatures);
        
        % save project matrix
        csvwrite([saveFolder,'/projectMatrix',num2str(queryID), '_', num2str(clusterID), '.csv'], trainedVector);
        
        % save projected descr range
        csvwrite([saveFolder,'/descrRange', num2str(queryID), '_', num2str(clusterID), '.csv'], descriptorRange);
        
        csvwrite([saveFolder,'/testObj', num2str(queryID), '_', num2str(clusterID), '.csv'], testData);
        csvwrite([saveFolder,'/trainObj', num2str(queryID), '_', num2str(clusterID), '.csv'], trainingData1);
        csvwrite([saveFolder,'/training', num2str(queryID), '_', num2str(clusterID), '.csv'], trainingData1);
    end
end
time = toc(p);
csvwrite([saveFolder,'/trainingTime.csv'], time);
fprintf('All done, \n');
