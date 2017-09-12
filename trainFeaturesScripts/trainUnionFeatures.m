% organize time series result into SVD
% first use SVD on descriptors, then use relevant and irrelavant count
clear;
clc;
classIndex = csvread('./classindex.csv');

ExtractNameX = '/Users/sicongliu/Desktop/features/MoCapUnionScale';
SavePath = '/Users/sicongliu/Desktop/features/MoCapUnionScale';
% for MoCap data
Array = [1, 15, 51, 81, 99, 118, 149, 179, 185];
% Array = [1, 15, 51, 81, 99, 118, 149, 179]; % ignore the last class

timee = zeros(8, 5); % ground truth -- 7 clusters

for clusterID = 1:8
    pp = tic;
    fprintf('clusterID: %d. \n', clusterID);
    trainingData3=[];
    for i = 1: size(Array, 2)-1
        if(i == clusterID)
        else
            tempTarget = Array(i):Array(i+1)-1;
            targetSize = size(tempTarget, 2);
            trainSize = floor(size(tempTarget, 2)*0.6);
            tempData = tempTarget(1 : trainSize);
            trainingData3 = [trainingData3 tempData];
        end
    end
    
    % each cluster use 60% train 40%(the rest) for test
    tempTarget = Array(clusterID):Array(clusterID+1)-1;
    targetSize = size(tempTarget, 2);
    trainSize = floor(size(tempTarget, 2)*0.6);
    trainingData1 = tempTarget(1 : trainSize);
    
    testData = trainingData3';
    XFeatures = [];
    
    % load training data
    for i = 1 : size(trainingData1, 2) % true data
        simOption = trainingData1(i);
        Xsavepath1 = [ExtractNameX,'/feature',num2str(simOption),'.mat'];
        load(Xsavepath1);
        
        XFeatures = [XFeatures frame1];
        clear XYZWframes descriptors timeCenter depdCenter timeSigma depdSigma
    end
    XFeatureTime=XFeatures(2, :);
    
    XFeatureDepd=XFeatures(1, :);
    
    XFeatureTimeOct=XFeatures(6, :);
    
    XFeatureDepdOct=XFeatures(5, :);
    
    XTrainingDescriptors=XFeatures(8:135, :)';
    fprintf('Training data loaded. \n');
    
    % train SVD on training dataset
    % use SVD on descriptors only
    options = [];
    options.ReducedDim = 10;
    % normalize before PCA
    % row=1;
    % XTrainingDescriptors = NormalizeFea(XTrainingDescriptors, row);
    % PCA, trainVector is the project matrix
    
    % monitor training data PCA time
    p = tic;
    [XtrainVector, XtrainValue] = PCA(XTrainingDescriptors',options);
    % XTrainingDescriptors = XTrainingDescriptors*XtrainVector;
    
    Xraw = [ XFeatureDepd' XFeatureTime' XFeatureDepdOct' XFeatureTimeOct' XtrainVector ];
    [C, Xia, ic]= unique(Xraw, 'rows'); % ia is the remaining column
    XUniqueFeature = (Xraw(Xia, :));
    timee(clusterID, 1) = timee(clusterID, 1) + toc(p);
    
    fprintf('Training SVD done. \n');
    
    XdescrRange = zeros(2, size(XtrainVector, 2));
    XdescrRange(1,:) = min(XUniqueFeature(:,5:end));
    XdescrRange(2,:) = max(XUniqueFeature(:,5:end));
    
    % for i = 1 : size(XdescrRange, 2)
    %     XdescrRange(1, i) = min(XUniqueFeature(:, i+4));
    %     XdescrRange(2, i) = max(XUniqueFeature(:, i+4));
    % end
    
    % cluster descriptors on training data
    % monitor clustering process
    
    p = tic;
    resolution = 2;
    XtrainVector11 = clusterDescrs(XtrainVector, XdescrRange, resolution);
    
    % update unique feature
    Xraw(:, 5:end) = XtrainVector11; % assume there would be duplicate here
    
    % update raw feature
    XUniqueFeature(:, 5:end) = clusterDescrs(XUniqueFeature(:, 5:end), XdescrRange, resolution);
    
    % unique again
    [C, Xia, ic]= unique(XUniqueFeature, 'rows'); % ia is the remaining column
    XUniqueFeature = (XUniqueFeature(Xia, :));
    timee(clusterID, 2) = timee(clusterID, 2) + toc(p);
    
    % load test data
    XFeaturesTest = [];
    for i = 1 : size(testData, 1)
        simOption = testData(i);
        Xsavepath1 = [ExtractNameX,'/feature',num2str(simOption),'.mat'];
        load(Xsavepath1);
        
        XFeaturesTest = [XFeaturesTest frame1];
    end
    
    XtimeCenter = XFeaturesTest(2, :);
    XdepdCenter = XFeaturesTest(1, :);
    XtestTimeOctave = XFeaturesTest(6, :);
    XtestDepdOctave = XFeaturesTest(5, :);
    XDescriptor = XFeaturesTest(8:135, :)';
    
    fprintf('Testing Data loaded. \n');
    
    % traing SVD on testing data
    % SVD on test data descriptors
    
    % testing data PCA
    p = tic;
    options = [];
    options.ReducedDim = 10;
    row=0;
    % [XtrainVector1, XtrainValue] = PCA(XDescriptor,options);
    [XtrainVector1, XtrainValue] = PCA(XDescriptor',options);
    % XDescriptor = XDescriptor*XtrainVector;
    XDescriptor = XtrainVector1;
    fprintf('Testing data SVD training data. \n');
    
    timee(clusterID, 3) = timee(clusterID, 3) + toc(p);
    % cluster on testing dataset
    % testing data clustering
    
    XDescriptor = clusterDescrs(XDescriptor, XdescrRange, resolution);
    
    XappCount = zeros(size(XUniqueFeature, 1), 2);
    
    Xtest =[XdepdCenter' XtimeCenter' XtestDepdOctave' XtestTimeOctave'  XDescriptor];
    
    % using testing and training to compute relevance feedback
    p = tic;
    for i = 1 : size(XappCount, 1)
        % Xtrain = XUniqueFeature(i,:);
        Xtrain = XUniqueFeature(i,:);
        
        % compute the frequency of a training vector appears in the
        % training set
        tt = find(all(bsxfun(@eq, Xraw, Xtrain), 2));
        XappCount(i, 1) = size(tt, 1);
        
        
        % compute the frequency of a training vector appears in the
        % testing set
        tt = find(all(bsxfun(@eq, Xtest, Xtrain), 2));
        XappCount(i, 2) = size(tt, 1);
    end
    % compute score, no need to sort
    XR = size(trainingData1, 2);
    XI = size(testData, 1);
    
    Ximportance = relevanceFeedback(XappCount, XR, XI);
    % relevance feedback done
    timee(clusterID, 4) = timee(clusterID, 4) + toc(p);
    
    timee(clusterID, 5) = timee(clusterID, 5) + toc(pp);
    csvwrite([SavePath,'\importance',num2str(clusterID), '.csv'], Ximportance);
    csvwrite([SavePath,'\uniqueFeature',num2str(clusterID), '.csv'], XUniqueFeature);
    
    % save project matrix
    % XtrainVector
    csvwrite([SavePath,'\projectMatrix',num2str(clusterID), '.csv'], XtrainVector);
    
    % save projected descr range
    csvwrite([SavePath,'\descrRange',num2str(clusterID), '.csv'], XdescrRange);
    
    csvwrite([SavePath,'/testObj',num2str(clusterID), '.csv'], testData);
    csvwrite([SavePath,'/trainObj',num2str(clusterID), '.csv'], trainingData1);
    csvwrite([SavePath,'/training',num2str(clusterID), '.csv'], trainingData1);
end
timee1 = zeros(8, 3);
timee1(:,1) = timee(:,1) + timee(:,3);
timee1(:,2) = timee(:,2) + timee(:,4);
timee1(:,3) = timee(:,5);
csvwrite([SavePath,'/trainingTime.csv'], timee1);
fprintf('All done, \n');