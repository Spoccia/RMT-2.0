clc;
clear;

number_of_files = 10;

% only one option from below will work
pick_small_feature = 0;
pick_large_feature = 0;
pick_random_feature = 0;

current_OS = 'Mac'; % windows
if (strcmp(current_OS, 'windows') == 1)
    delimiter = '\';
else
    delimiter = '/';
end

TimeSeriesIndex = 1;
TS_name = num2str(TimeSeriesIndex);
% Data_Type = ['Energy_Building']; % MoCap
Data_Type = ['MoCap']; % MoCap

% FeaturePath = 'D:\Motif_Results\Datasets\Mocap\Features_RMT';
% DestDataPath = 'D:\Motif_Results\Datasets\SynteticDataset\data';
if(strcmp(Data_Type, 'Energy_Building') == 1)
    FeaturePath = '/Users/sliu104/Desktop/EnergyTestData/RMT';
    DestDataPath = ['/Users/sliu104/Desktop/EnergyTestData/InjectedFeatures'];
else
    FeaturePath = '/Users/sliu104/Desktop/MoCapTestData/RMT';
    DestDataPath = ['/Users/sliu104/Desktop/MoCapTestData/InjectedFeatures'];
end


random_walk_path = ['/Users/sliu104/Desktop/RandomWalks_Generated/'];
FeaturePath = [FeaturePath, delimiter, num2str(TimeSeriesIndex), delimiter];

% two values below not 1 or 0 at the same
multiScaleFeatureInjection = 0; % 0;
differentVariateGroupInjection = 1; % 0

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

pattern_features_folder_path = ['/Users/sliu104/Desktop/Pattern_Features_For_Injection'];
save_counter = 1;
for nn = 1 : number_of_files
    TEST_1 = [Data_Type, num2str(nn)];
    
    random_walk_file = [random_walk_path, 'RandomWalk_', num2str(nn), '.csv'];
    rndWalks1 = csvread(random_walk_file);
    
    % FeatPositions: class label, time center of original features, time start, time end
    FeatPositions = zeros(NumInstances, 4);
    
    % avoid injecting features in the same position
    Step = floor(size(rndWalks1, 2) / NumInstances);
    
    feature_TS_ID = [24, 35, 85, 127];
    % read features for injection
    for i = 1 : size(feature_TS_ID, 2)
        depd_file_path = [pattern_features_folder_path, '/Depd', num2str(feature_TS_ID(i)), '_50.csv'];
        feature_file_path = [pattern_features_folder_path, '/Features', num2str(feature_TS_ID(i)), '_50.csv'];
        pattern_variates = csvread(depd_file_path);
        pattern_features = csvread(feature_file_path);
        
        patternVariates = [];
        % pick pick random 3 variates
        picked_variate_index = randi(size(nonzeros(pattern_variates(:, 1)), 1));
        while(size(patternVariates, 1) < 3)
            while(sum(ismember(picked_variate_index, patternVariates)) >= 1)
                picked_variate_index = randi(size(nonzeros(pattern_variates(:, 1)), 1));
            end
            patternVariates = [patternVariates; picked_variate_index];
        end
        patternFeature = pattern_features(:, 1);
        
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
            % dpscale_injected = [ dpscale_injected, patternVariates];
        end
        
        
        save_random_walk_path = [DestDataPath, delimiter, 'MoCap', num2str(save_counter), '.csv'];
        save_feature_position_path = [DestDataPath, delimiter, 'FeaturePosition_MoCap', num2str(save_counter), '.csv'];
        save_injected_variates_path = [DestDataPath, delimiter, 'dpscale_MoCap', num2str(save_counter), '.csv'];
        save_pattern_feature_path = [DestDataPath, delimiter, 'FeaturesEmbedded_MoCap', num2str(save_counter), '.csv'];
        csvwrite(save_random_walk_path, rndWalks1);
        csvwrite(save_feature_position_path, FeatPositions1);
        csvwrite(save_injected_variates_path, injectedVariates1);
        csvwrite(save_pattern_feature_path, patternFeature);
        
        
        save_counter = save_counter + 1;
    end
end

fprintf('Manual injection done .\n');