clc;
clear;

% FeaturePath = 'D:\Motif_Results\Datasets\Mocap\Features_RMT\1_euclid\';
TimeSeriesIndex = 10;
TS_name = num2str(TimeSeriesIndex);
TEST = ['Mocap_test', TS_name];

FeaturePath = '/Users/sicongliu/Desktop/MyRMT/FeaturesToInject/MoCap/RMTFeatures';
FeaturePath = [FeaturePath, '/', num2str(TimeSeriesIndex), '/'];
kindofBasicTS = 'randomWalk'; %'Sinusoidal';%'flat';%
if(strcmp(kindofBasicTS, 'flat') == 1)
    KindOfDataset = 'FlatTS_MultiFeatureDiffClusters\';
elseif(strcmp(kindofBasicTS, 'Sinusoidal') == 1)
    KindOfDataset = 'CosineTS_MultiFeatureDiffClusters\';%
elseif(strcmp(kindofBasicTS, 'randomWalk') == 1)
    KindOfDataset = 'RandomWalkTS_MultiFeatureDiffClusters\';%
end

% DestDataPath = 'D:\Motif_Results\Datasets\SynteticDataset\data';
DestDataPath = '/Users/sicongliu/Desktop/MyRMT/FeaturesToInject/MoCap/InjectedFeatures';
sinFreq = 1;

DepO = 2;  % octave depd
TimeO = 2; % octave time

nummotifs = 2; % use 2 different (unrelated) features to inject them
% numFeatureforClass = 2;%1;
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

% first find featuers of different length using time sigma info
featuresOfInterest = featuresOfInterest';
[featuresOfInterest, sortedIndex] = sortrows(featuresOfInterest, 4);
featuresOfInterest = featuresOfInterest';
% re-arrange depdscale index
sortedIndex = sortedIndex';
dpscale = dpscale(:, sortedIndex);

myRandom = pickRandomFeatures(featuresOfInterest, dpscale, nummotifs);

% while(timeLengthFlag | variateFlag)
%     myRandom = randi([1, columns], 1, nummotifs);
%     [timeLengthFlag, variateFlag] = DifferentTimeLengthsVariate(myRandom, featuresOfInterest, dpscale);
%     pickRandomFeatures(featuresOfInterest, dpscale);
%     % variateFlag= DifferentVariates(myRandom, featuresOfInterest, depdScale);
% end

MotifsFeatures = [];
motifdpscale = [];

% loop feature index from previously created structure-myRandom
for ii=1:nummotifs
    A = featuresOfInterest(:, myRandom(ii));
    B = dpscale(:, myRandom(ii));
    MotifsFeatures = [MotifsFeatures, A];
    motifdpscale = [motifdpscale, B];
end

% datarows : variates
% datacoln : time stamps
[datarows, datacoln] = size(data);

% rows : feature dimensions
% colmn : number of base-motif-features
[rows, colmn] = size(MotifsFeatures);
A = MotifsFeatures; % original features
B = motifdpscale;
timescope = A(4, :) * 3; %+offSpace;

if(strcmp(kindofBasicTS, 'randomWalk') == 1)
    rndWalks = rndWalkGeneration(size(data,1), 2 * size(data,2)); % generate random walk z-normalized
end

origRW = rndWalks;

% FeatPositions: 
% class label, time center of original features, time start, time end
FeatPositions = zeros(NumInstances, 4); 
Step = floor(size(rndWalks, 2) / NumInstances); % avoid injecting features in the same position
pStep = 0; % count the injection location

for ii = 1 : NumInstances
    i = randi([1, size(A, 2)], 1, 1);
    intervaltime = (max(round((A(2, i) - timescope(i)), 0)) : (min(round((A(2, i) + timescope(i))), size(data, 2)))); % feature time scope (integer)
    % motifData = data(:, intervaltime((intervaltime > 0 & intervaltime <= size(data, 2)))); 
    motifData = data(:, intervaltime); 
    [~, motifclmn] = size(motifData);
    
    % random select the injection position
    starter = randi([pStep, max(pStep + Step - motifclmn, 0)],1,1);
    FeatPositions(ii,:) = [i, A(2,i), starter, starter + motifclmn - 1];
    
    if(strcmp(kindofBasicTS, 'randomWalk') == 1 | strcmp(kindofBasicTS, 'flat') == 1)
        rndWalks(B((B(:, i) > 0), i), starter : starter + motifclmn - 1) = motifData(B(B(:, i) > 0, i), :); % inject the features into random walk time series data
    elseif(strcmp(kindofBasicTS, 'Sinusoidal') == 1)
        rndWalks(B((B(:, i) > 0), i), starter : starter + motifclmn-1) = motifData(B(B(: ,i) > 0, i), :);
    end
    pStep = pStep + Step;
end

if(exist([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\'],'dir')==0)
    mkdir([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\']);
end
csvwrite([DestDataPath,'\',TEST,'.csv'],rndWalks);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','rndData_',TEST,'.csv'],origRW);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','FeaturePosition_',TEST,'.csv'],FeatPositions);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','dpscale_',TEST,'.csv'],B);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','FeaturesEmbedded_',TEST,'.csv'],A);
