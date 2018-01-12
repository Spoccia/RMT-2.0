clc;
clear;

% pick a multi-variate feature
% cut off time sigma, inject as a multi-scale features, options for
% different variate groups injections as well

% FeaturePath = 'D:\Motif_Results\Datasets\Mocap\Features_RMT\1_euclid\';
TimeSeriesIndex = 10;
TS_name = num2str(TimeSeriesIndex);
TEST = ['Mocap_test', TS_name];

FeaturePath = '/Users/sicongliu/Desktop/MyRMT/FeaturesToInject/MoCap/RMTFeatures';
FeaturePath = [FeaturePath, '/', num2str(TimeSeriesIndex), '/'];
motifInjectionOption = 'Random'; % 'RoundRobin'
kindofBasicTS = 'randomWalk'; %'Sinusoidal';%'flat';%
if(strcmp(kindofBasicTS, 'flat') == 1)
    KindOfDataset = 'FlatTS_MultiFeatureDiffClusters\';
elseif(strcmp(kindofBasicTS, 'Sinusoidal') == 1)
    KindOfDataset = 'CosineTS_MultiFeatureDiffClusters\';%
elseif(strcmp(kindofBasicTS, 'randomWalk') == 1)
    KindOfDataset = 'RandomWalkTS_MultiFeatureDiffClusters\';%
end

% two values below not 1 or 0 at the same
multiScaleFeatureInjection = 1; % 0;
differentVariateGroupInjection = 1; % 0

% DestDataPath = 'D:\Motif_Results\Datasets\SynteticDataset\data';
DestDataPath = '/Users/sicongliu/Desktop/MyRMT/FeaturesToInject/MoCap/InjectedFeatures';
sinFreq = 1;

% pick features from higher octaves
DepO = 2;  % octave depd
TimeO = 2; % octave time

NumInstances = 10; % inject into 10 locations
dpscale = [];
frame1 = [];

% read the depd involved for the corresponding features
dpscale = csvread(strcat(FeaturePath, 'DistancesDescriptor/DepdScale_IM_', TS_name, '_DepO_', num2str(DepO), '_TimeO_', num2str(TimeO), '.csv'));

savepath1 = [FeaturePath, 'feature_', TS_name, '.mat'];
savepath2 = [FeaturePath, 'idm_', TS_name, '.mat'];
savepath3 = [FeaturePath, 'MetaData_', TS_name, '.mat'];
load(savepath1);
load(savepath2);
load(savepath3);

% So far only use features from higher octaves
indexfeatureGroup = (frame1(6,:) == TimeO & frame1(5,:) == DepO);
featuresOfInterest = frame1(:, indexfeatureGroup);

[rows, columns] = size(featuresOfInterest);

% put time lengths and different variates check
% if they share the same variate or length keep looping

timeLengthFlag = 1;
variateFlag = 1;

% datarows : variates
% datacoln : time stamps
[datarows, datacoln] = size(data);

if(strcmp(kindofBasicTS, 'randomWalk') == 1)
    rndWalks = rndWalkGeneration(size(data,1), 2 * size(data,2)); % generate random walk z-normalized
end

origRW = rndWalks;

% FeatPositions: class label, time center of original features, time start, time end
FeatPositions = zeros(NumInstances, 4);

% avoid injecting features in the same position
Step = floor(size(rndWalks, 2) / NumInstances); 

% count the injection location
pStep = 0; 

if(multiScaleFeatureInjection == 1)
    % pick different locations, same group of variate for injection
    sameVariateGroup = 1;
    
    cutOffRate = 0.5;
    % pick features of different time scales
    [patternFeature, variates] = pickLargestTimeSimgaFeaturesCutOff(featuresOfInterest, dpscale, cutOffRate);
    [rndWalks, FeatPositions] = featureInject(patternFeature, variates, sameVariateGroup, NumInstances, rndWalks, FeatPositions, data);
end

if(differentVariateGroupInjection == 1)
    % pick different locations, different group of variates for injection
    sameVariateGroup = 0;
    
    % pick feature that covers the smallest portion of variates
    [patternFeature, variates] = pickSmallestVariateCoverageFeatures(featuresOfInterest, dpscale);
    [rndWalks, FeatPositions] = featureInject(patternFeature, variates, sameVariateGroup, NumInstances, rndWalks, FeatPositions, data);
end

if(exist([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\'],'dir')==0)
    mkdir([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\']);
end
csvwrite([DestDataPath,'\',TEST,'.csv'],rndWalks);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','rndData_',TEST,'.csv'],origRW);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','FeaturePosition_',TEST,'.csv'],FeatPositions);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','dpscale_',TEST,'.csv'],variates);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','FeaturesEmbedded_',TEST,'.csv'],patternFeature);

