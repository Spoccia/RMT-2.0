clc;
clear;

number_of_files = 3;

% only one option from below will work
pick_small_feature = 1;
pick_large_feature = 0;
pick_random_feature = 0;

current_OS = 'Mac'; % windows
if (strcmp(current_OS, 'windows') == 1)
    delimiter = '\';
else
    delimiter = '/';
end

TimeSeriesIndex = 2;
TS_name = num2str(TimeSeriesIndex);
% Data_Type = ['Energy_Building']; % MoCap
Data_Type = ['MoCap']; % MoCap

% FeaturePath = 'D:\Motif_Results\Datasets\Mocap\Features_RMT';
% DestDataPath = 'D:\Motif_Results\Datasets\SynteticDataset\data';
if(strcmp(Data_Type, 'Energy_Building') == 1)
    FeaturePath = '/Users/sliu104/Desktop/EnergyTestData/RMT';
    DestDataPath = ['/Users/sliu104/Desktop/EnergyTestData/InjectedFeatures_', num2str(TimeSeriesIndex)];
else
    FeaturePath = '/Users/sliu104/Desktop/MoCapTestData/RMT';
    DestDataPath = ['/Users/sliu104/Desktop/MoCapTestData/InjectedFeatures_', num2str(TimeSeriesIndex)];
end

FeaturePath = [FeaturePath, delimiter, num2str(TimeSeriesIndex), delimiter];

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
multiScaleFeatureInjection = 0; % 0;
differentVariateGroupInjection = 1; % 0

sinFreq = 1;

% pick features from higher octaves
DepdO = 2; % octave depd
TimeO = 2; % octave time

NumInstances = 10; % inject into 10 locations
dpscale = [];
frame1 = [];

% read the depd involved for the corresponding features
dpscale = csvread(strcat(FeaturePath, 'DistancesDescriptor', delimiter, 'DepdScale_IM_', TS_name, '_DepO_', num2str(DepdO), '_TimeO_', num2str(TimeO), '.csv'));

savepath1 = [FeaturePath, 'feature_', TS_name, '.mat'];
savepath2 = [FeaturePath, 'idm_', TS_name, '.mat'];
savepath3 = [FeaturePath, 'MetaData_', TS_name, '.mat'];
load(savepath1);
load(savepath2);
load(savepath3);

% load metadata graph
metadataPath = [FeaturePath, 'idm_', num2str(TimeSeriesIndex), '.mat'];
idm = load(metadataPath);
idm = idm.idm1;

% So far only use features from higher octaves
indexfeatureGroup = (frame1(6,:) == TimeO & frame1(5,:) == DepdO);
featuresOfInterest = frame1(:, indexfeatureGroup);

[rows, columns] = size(featuresOfInterest);

% put time lengths and different variates check
% if they share the same variate or length keep looping

timeLengthFlag = 1;
variateFlag = 1;

% datarows : variates
% datacoln : time stamps
[datarows, datacoln] = size(data);

MoCap_Flat_Variate = [34 : 46];
for nn = 1 : number_of_files
    TEST_1 = [Data_Type, num2str((nn - 1) * 2 + 1)];
    TEST_2 = [Data_Type, num2str((nn - 1) * 2 + 2)];
    if(strcmp(kindofBasicTS, 'randomWalk') == 1)
        % rndWalks1 : 0 - 1
        % rndWalks2 : scaled range
        % both same size as original data
        
        % MoCap: No need to scale, Energy: scale to 10%
        time_stamps_scale = 1;
        [rndWalks1,rndWalks2] = rndWalkGenerationbigSize(size(data,1), floor(size(data, 2) * time_stamps_scale), data);
        
        % ignore flat variate in this case
        if(strcmp(Data_Type, 'MoCap') == 1) 
            rndWalks2(MoCap_Flat_Variate,:)=rndWalks1(MoCap_Flat_Variate,:);
        end
        
        
    end
    
    origRW1 = rndWalks1;
    origRW2 = rndWalks2;
    
    % FeatPositions: class label, time center of original features, time start, time end
    FeatPositions = zeros(NumInstances, 4);
    
    % avoid injecting features in the same position
    Step = floor(size(rndWalks1, 2) / NumInstances);
    
    % count the injection location
    pStep = 0;
    
    % dpscale_injected=[];
    if(multiScaleFeatureInjection == 1)
        % pick different locations, same group of variate for injection
        sameVariateGroup = 1;
        
        cutOffRate = 0.5;
        % pick features of different time scales
        [patternFeature, patternVariates] = pickLargestTimeSimgaFeaturesCutOff(featuresOfInterest, dpscale, cutOffRate);
        [rndWalks, FeatPositions, injectedVariates] = featureInject(patternFeature, patternVariates, sameVariateGroup, NumInstances, rndWalks, FeatPositions, data, idm, DepdO);
    end
    
    if(differentVariateGroupInjection == 1)
        % pick different locations, different group of variates for injection
        sameVariateGroup = 0;
        
        % pick feature that covers the smallest portion of variates
        if(pick_small_feature == 1)
            [patternFeature, patternVariates] = pickSmallestVariateCoverageFeatures(featuresOfInterest, dpscale);
        end
        
        if(pick_large_feature == 1)
            [patternFeature, patternVariates] = pickLargestVariateCoverageFeatures(featuresOfInterest, dpscale);
        end
        
        if(pick_random_feature == 1)
            [patternFeature, patternVariates] = pickRandomVariateCoverageFeatures(featuresOfInterest, dpscale);
        end
        [rndWalks1, FeatPositions1, injectedVariates1] = featureInject(patternFeature, patternVariates, sameVariateGroup, NumInstances, rndWalks1, FeatPositions, data, idm, DepdO);
        [rndWalks2, FeatPositions2, injectedVariates2] = featureInject(patternFeature, patternVariates, sameVariateGroup, NumInstances, rndWalks2, FeatPositions, data, idm, DepdO);
        % dpscale_injected = [ dpscale_injected, patternVariates];
    end
    
    if(exist([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter], 'dir')==0)
        mkdir([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter]);
    end
    if(exist([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_2, delimiter], 'dir')==0)
        mkdir([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_2, delimiter]);
    end
    csvwrite([DestDataPath, delimiter, TEST_1,'.csv'], rndWalks1);
    csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, 'rndData_', TEST_1, '.csv'], origRW1);
    csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter, 'FeaturePosition_', TEST_1, '.csv'], FeatPositions1);
    csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter, 'dpscale_', TEST_1, '.csv'], injectedVariates1);
    % csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter, 'injectedDpscale_', TEST_1, '.csv'], injectedVariates1);
    csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter, 'FeaturesEmbedded_', TEST_1, '.csv'], patternFeature);
    
    csvwrite([DestDataPath, delimiter, TEST_2,'.csv'],rndWalks2);
    csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, 'rndData_', TEST_2,'.csv'],origRW2);
    csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_2, delimiter, 'FeaturePosition_', TEST_2, '.csv'], FeatPositions2);
    csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_2, delimiter, 'dpscale_', TEST_2, '.csv'], injectedVariates2);
    % csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_2, delimiter, 'injectedDpscale_', TEST_2, '.csv'], injectedVariates2);
    csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_2, delimiter, 'FeaturesEmbedded_', TEST_2, '.csv'], patternFeature);
end

fprintf('Manual injection done .\n');