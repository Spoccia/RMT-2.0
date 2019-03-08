clc;
clear;

% DataType='Energy';
DataType='Mocap';
% DataType='BirdSong';
basepath='D:\Motif_Results\Datasets\SynteticDataset\';%'/Users/sliu104/Desktop/Motif_Data/SynteticDataset/';%
featuresToInjectPath=[basepath,DataType,'\Coherent Shift Variate 1M ',DataType,'\instancessamesize\data/FeaturesToInject/'];%,'/RandomVariate','/instancesmultisize/data/FeaturesToInject/'];
randomWalkPath = [basepath,DataType,'\Coherent Shift Variate 1M ',DataType,'\instancessamesize/data/RW_0_1/RW_'];
TimeSeriesPath = ['D:\Motif_Results\Datasets\',DataType,'/data/'];%['/Users/sliu104/Desktop/Motif_Data/TimeSeries/',DataType,'/data/'];
depdO=2;
coherentinjectionFlag =  1;% 0;%if coherent;
num_of_motif=1;
delimiter='/';
DestDataPath = [basepath,DataType,'\Coherent Shift Variate 1M ',DataType,'\instancessamesize\data/'];
% NUM_VARIATE = 27;%Energy
NUM_VARIATE = 62;% MoCap
% NUM_VARIATE = 13;% BirdSong
random_walk_instance = 10;
motif_instances = 10;
RWlength = 2500-59;
random_walk_scale = [0,0.1,0.25,0.5,0.75,1,2];%0.1;% randomWalkScale =
possibleMotifNUM=[1, 2, 3, 10];
%% for each posible motifs to inject prepare a random semlection of the possible reduced time sizes.
% length_percentage_1 = [1,0.75,0.5,1,0.75,0.5,1,0.75,0.5,1,0.75,0.5];%[1,0.75,0.5];
 length_percentage_1 =[1,1,1,1,1,1,1,1,1,1,1,1];
length_percentage=[];
for pssMotID =1:num_of_motif%3
    randid= randperm(motif_instances);
    length_percentage=[length_percentage;length_percentage_1(randid)];
end
% length_percentage= [1,0.75,0.5,1,0.75,0.5,1,0.75,1,0.5];
%%
load([featuresToInjectPath,'allTSid.mat']);
originalTSIDArray=AllTS;
FeatureSelectionalID = 1;% csvread([DestDataPath,'/FeaturesToInject/featureselectedinfiles.csv']);%[];   
for orgID = 1:30 %length(originalTSIDArray)%2
    originalTSID = originalTSIDArray(orgID);
    load(['D:\Motif_Results\Datasets\',DataType,'\Features_RMT\',num2str(originalTSID),'\feature_',num2str(originalTSID),'.mat']);
    load(['D:\Motif_Results\Datasets\',DataType,'\Features_RMT\',num2str(originalTSID),'\idm_',num2str(originalTSID),'.mat']);
    load(['D:\Motif_Results\Datasets\',DataType,'\Features_RMT\',num2str(originalTSID),'\MetaData_',num2str(originalTSID),'.mat']);
    
    %     originalTSID = 1;
    for pssMotID = 1 : num_of_motif% 3%length(possibleMotifNUM)%4:4
        
        
        num_of_motif = possibleMotifNUM(pssMotID);%3; % NumOfMotifs = 1;
        NumInstances= motif_instances*num_of_motif;
        id_test_name = 'MV_Sync_Motif';
        testNAME = [id_test_name,num2str(num_of_motif)];
        
        % load  the features and the data
        FeaturesToInject = csvread([featuresToInjectPath,'Features',num2str(originalTSID),'.csv']);
        DepdToInject = csvread([featuresToInjectPath,'depd',num2str(originalTSID),'.csv']);
        
        % MOCAP BirdSong
        TSdata = csvread([TimeSeriesPath,num2str(originalTSID),'.csv'])';
        % Energy
        %          TSdata = csvread([TimeSeriesPath,num2str(originalTSID),'.csv']);% remove ' for Energy;
        
%         FeatureToInject = FeaturesToInject(:,1:num_of_motif);
%         DepdToInject = DepdToInject(:,1:num_of_motif);
         
        %
        %         TEST_1 = [DataType,'MVSyncMotif',num2str(num_of_motif),'_' ,num2str(originalTSID)];
        %
        % read random walk files
        random_walk_file = [randomWalkPath, num2str(1), '.csv'];
        rndWalks1 = csvread(random_walk_file);
        %
        %         % FeatPositions: class label, time center of original features, time start, time end
        FeatPositions = zeros(NumInstances, 4);
        %
        %         % avoid injecting features in the same position
        Step = floor(size(rndWalks1, 2) / NumInstances);
        
        % count the injection location
        pStep = 0;
        
        % read features for injection, pick different locations, different group of variates for injection
        sameVariateGroup = 0;
        %%    Prepare  the order of injection of the motifs
        LabelMotif = [];
        MotifsVariateSet=[];
        
        offSpace=0;
        
     
        for MotifId =1: num_of_motif
            selectRandomMotif= FeatureSelectionalID(orgID);%randi(2);
%             if(originalTSID==5)
%                 selectRandomMotif=1;
%             end
            FeatureSelectionalID=[FeatureSelectionalID,selectRandomMotif];
            
            FeatureToInject = FeaturesToInject(:,selectRandomMotif);
            DepdToInject = DepdToInject(:,selectRandomMotif);
            timescope= FeatureToInject(4,MotifId)*3; % 29
            deploc= DepdToInject(:,MotifId);
            intervaltime=(round((FeatureToInject(2,MotifId)-timescope)) : (round((FeatureToInject(2,MotifId)+timescope+offSpace))));
            MotifsSections{MotifId}.data = TSdata(:,intervaltime((intervaltime>0 & intervaltime<=size(TSdata,2))));
            
            MotifsSections{MotifId}.cols = size(MotifsSections{MotifId}.data,2);
            MotifsSections{MotifId}.depd = deploc;
            LabelMotif=[LabelMotif,ones(1,motif_instances)*MotifId];
            %% coherent injection
            MotifsVariateSet_Support=[];
            if coherentinjectionFlag == 1
%                 load('D:\Motif_Results\Datasets\SynteticDataset\Mocap\Coherent Shift Variate 1M Mocap\allPossibleVariatesGroups.mat');
%                 TempPossVariates= orderedDepdBySize{3};
%                 MotifsVariateSet_Support{MotifId}= TempPossVariates(1:3,:);
                %%old
                [~,~,MotifsVariateSet_Support{MotifId}]= featureInject(FeatureToInject(:,MotifId), DepdToInject(:,MotifId), sameVariateGroup, motif_instances, rndWalks1, FeatPositions, data, idm1, depdO,MotifId);
                
                selectVaraiteGroupsrandom=     randi(size(MotifsVariateSet_Support{MotifId},2),1,motif_instances);
                MotifsVariateSet{MotifId}= MotifsVariateSet_Support{MotifId}(:,selectVaraiteGroupsrandom);
                
            else
            %% random injection
            TempRandomVariateSet=[];
            MoCap_avoidingflatvariate= [1:33,35:45,47:62];
            numofRandomVariateToInject = size (MotifsSections{MotifId}.depd(MotifsSections{MotifId}.depd(:,1)>0,1),1);
            for  intI=1:motif_instances
                randomVariateSet= randperm(60);
                TempRandomVariateSet = [TempRandomVariateSet,MoCap_avoidingflatvariate(randomVariateSet(1:numofRandomVariateToInject))'];
%                 a=size(DepdToInject(DepdToInject(:,MotifId)>0,MotifId),1)*10;
%                 TempRandomVariateSet= [TempRandomVariateSet,reshape(MoCap_avoidingflatvariate(randomVariateSet(1:a)),[size(DepdToInject(DepdToInject(:,MotifId)>0,MotifId),1),10])];
            end
%                 selectVaraiteGroupsrandom = randi(size(TempRandomVariateSet{MotifId},2),1,motif_instances);
                MotifsVariateSet{MotifId} = TempRandomVariateSet;%(:,selectVaraiteGroupsrandom);
            end
            
        end
        LabelMotif = LabelMotif( randperm(length(LabelMotif))) ; %%this label  ahve to be readed and used to inject  a motif instance selecting gthe variate assigned to the specific istance
        %%
        startInj=30;
        Step= floor( RWlength/(motif_instances*num_of_motif));
        startTime =zeros(1,motif_instances*num_of_motif);
        starterTime(1) = startInj ;
        %% determine the temporal position for each instance
        for i=1:NumInstances%motif_instances*num_of_motif
            motifclmn = MotifsSections{LabelMotif(i)}.cols;
            starterTime (i)= randi([startInj+pStep,startInj+pStep+Step-motifclmn],1,1);
            pStep=pStep+Step;
        end
        %%
        TSNAMEFIX=testNAME;
        for rwscale = 1 : size(random_walk_scale,2)
            for i =1 : random_walk_instance
                %                 TEST_1 = [DataType,'MVSyncMotif',num2str(num_of_motif),'_' ,num2str(originalTSID) ,'_instance_',num2str(i)];
                testNAME = [TSNAMEFIX,'_',num2str(originalTSID),'_instance_',num2str(i)];
                EachInstanceDependency=[];
                randomwalkData = csvread([randomWalkPath,num2str(i),'.csv']);
                NormInterval=[zeros(NUM_VARIATE,1),ones(NUM_VARIATE,1)];
                
                if random_walk_scale(rwscale)~=0
                    NormInterval(:,1)= (min(TSdata')*random_walk_scale(rwscale))';
                    NormInterval(:,2)= (max(TSdata')*random_walk_scale(rwscale))';
                    randomwalkData= NormalizeRandomWalk(randomwalkData,NormInterval,0);
                end
                Motif1RW=randomwalkData;
                FeatPositions = zeros(motif_instances*num_of_motif,4);%NEW
                idxMotifID(:)=ones(3,1);%NEW
                for motifInstance = 1: motif_instances*num_of_motif
                    MotifID=LabelMotif(motifInstance);
                    length_index = length_percentage(MotifID,idxMotifID(MotifID));
                    actualVariateToinject= MotifsVariateSet{MotifID}(:,idxMotifID(MotifID));
                    idxMotifID(MotifID)=idxMotifID(MotifID)+1;
                    if(length_index == 0)
                        length_index = size(length_percentage, 2);
                    end
                    M1 = imresize( MotifsSections{MotifID}.data,[size( MotifsSections{MotifID}.data,1), size( MotifsSections{MotifID}.data,2)*length_index]);%length_percentage(length_index)]);
                    scalingTime =size(M1,2);
                    
                    Motif1RW(actualVariateToinject((actualVariateToinject(:,1)>0),1),starterTime(motifInstance):starterTime(motifInstance)+scalingTime-1) = ...
                       M1(MotifsSections{MotifId}.depd(MotifsSections{MotifId}.depd(:,1)>0,1),:);% M1(actualVariateToinject(actualVariateToinject(:,1)>0,1),:);
                    
                    FeatPositions(motifInstance,:)=[MotifID,motifInstance,starterTime(motifInstance),starterTime(motifInstance)+scalingTime-1];
                    EachInstanceDependency=[EachInstanceDependency, actualVariateToinject ];
                end
                if(exist([DestDataPath,'\IndexEmbeddedFeatures\'],'dir')==0)
                    mkdir([DestDataPath,'\IndexEmbeddedFeatures\']);
                end
                csvwrite([DestDataPath,'\',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],Motif1RW);
                csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','FeaturePosition_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],FeatPositions);%,testNAME,'\'
                csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','dpscale_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],EachInstanceDependency);
                %               csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','ORGRW',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],randomwalkData);
                csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','Parameters_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],[originalTSID;num_of_motif;motif_instances;i;random_walk_scale(rwscale)]);
            end
        end
        %[rndWalks1, FeatPositions1, injectedVariates1] = featureInject(FeatureToInject, DepdToInject, sameVariateGroup, motif_instances, rndWalks1, FeatPositions, data, idm1, depdO);
        % dpscale_injected = [ dpscale_injected, patternVariates];
        
        %         if(exist([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter], 'dir')==0)
        %             mkdir([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter]);
        %         end
        %
        %         csvwrite([DestDataPath, delimiter, TEST_1,'.csv'], rndWalks1);
        %         csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter, 'FeaturePosition_', TEST_1, '.csv'], FeatPositions1);
        %         csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter, 'dpscale_', TEST_1, '.csv'], injectedVariates1);
        %         csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter, 'FeaturesEmbedded_', TEST_1, '.csv'], patternFeature);
        %
        
    end
    
end
csvwrite([DestDataPath,'/FeaturesToInject/featureselectedinfiles.csv'],FeatureSelectionalID);
fprintf('Feature Injection done .\n');


%         MotifsSections=[];
%         offSpace=0;
%         for MotifId =1: num_of_motif
%             timescope= FeatureToInject(4,MotifId)*3; % 29
%             intervaltime=(round((FeatureToInject(2,MotifId)-timescope)) : (round((FeatureToInject(2,MotifId)+timescope+offSpace))));
%             MotifsSections{MotifId}.data = TSdata(:,intervaltime((intervaltime>0 & intervaltime<=size(TSdata,2))));
%             MotifsSections{MotifId}.depd = DepdToInject(:,MotifId);
%             MotifsSections{MotifId}.cols = size(MotifsSections{MotifId}.data,2);
%         end
%         startInj=30;
%         Step= floor( RWlength/(motif_instances*num_of_motif));
%         startTime =zeros(1,motif_instances*num_of_motif);
%         starterTime(1) = startInj ;
%         LabelMotif = [];
%         for i =1: num_of_motif
%             LabelMotif=[LabelMotif,ones(1,motif_instances)*i];
%         end
%         LabelMotif = LabelMotif( randperm(length(LabelMotif))) ;
%         pStep=0;
%         for i=1:motif_instances*num_of_motif
%             motifclmn = MotifsSections{LabelMotif(i)}.cols;
%             starterTime (i)= randi([startInj+pStep,startInj+pStep+Step-motifclmn],1,1);
%             pStep=pStep+Step;
%         end
%         % Counter =1;
%         TSNAMEFIX=testNAME;
%         for rwscale = 1 : size(random_walk_scale,2)
%             for i =1 : random_walk_instance
%                 % read the 0-1 randomwalk
%
%                 testNAME = [TSNAMEFIX,'_',num2str(originalTSID),'_instance_',num2str(i)];
%
%                 EachInstanceDependency=[];
%                 randomwalkData = csvread([randomWalkPath,num2str(i),'.csv']);
%                 NormInterval=[zeros(NUM_VARIATE,1),ones(NUM_VARIATE,1)];
%
%                 if random_walk_scale(rwscale)~=0
%                     NormInterval(:,1)= (min(TSdata')*random_walk_scale(rwscale))';
%                     NormInterval(:,2)= (max(TSdata')*random_walk_scale(rwscale))';
%                     randomwalkData= NormalizeRandomWalk(randomwalkData,NormInterval,0);
%                 end
%                 Motif1RW=randomwalkData;
%                 %             minvalueTS = min(TSdata');
%                 %             maxvalueTS = max(TSdata');
%                 %         Motif1RW = scaleRW(randomwalkData,maxvalueTS,minvalueTS,random_walk_scale(rwscale));
%
%                 FeatPositions = zeros(motif_instances*num_of_motif,4);%NEW
%                 idxMotifID(:)=ones(3,1);%NEW
%                 for motifInstance = 1: motif_instances*num_of_motif
%                     MotifID=LabelMotif(motifInstance);
%
%
%                     length_index = length_percentage(MotifID,idxMotifID(MotifID));
%                     %  length_index =  mod(motifInstance, length(length_percentage));
%                     idxMotifID(MotifID)=idxMotifID(MotifID)+1;
%                     if(length_index == 0)
%                         length_index = size(length_percentage, 2);
%                     end
%                     M1 = imresize( MotifsSections{MotifID}.data,[size( MotifsSections{MotifID}.data,1), size( MotifsSections{MotifID}.data,2)*length_index]);%length_percentage(length_index)]);
%                     scalingTime =size(M1,2);
%
%                     Motif1RW(MotifsSections{MotifID}.depd((MotifsSections{MotifID}.depd(:,1)>0),1),starterTime(motifInstance):starterTime(motifInstance)+scalingTime-1) = ...
%                         M1(MotifsSections{MotifID}.depd(MotifsSections{MotifID}.depd(:,1)>0,1),:);
%
%                     FeatPositions(motifInstance,:)=[MotifID,motifInstance,starterTime(motifInstance),starterTime(motifInstance)+scalingTime-1];
%                     EachInstanceDependency=[EachInstanceDependency, MotifsSections{MotifID}.depd ];
%                 end
%
%                 if(exist([DestDataPath,'\IndexEmbeddedFeatures\'],'dir')==0)
%                     mkdir([DestDataPath,'\IndexEmbeddedFeatures\']);
%                 end
%                 csvwrite([DestDataPath,'\',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],Motif1RW);
%                 csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','FeaturePosition_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],FeatPositions);%,testNAME,'\'
%                 csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','dpscale_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],EachInstanceDependency);
%                 % csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','ORGRW',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],randomwalkData);
%                 csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','Parameters_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],[originalTSID;num_of_motif;motif_instances;i;random_walk_scale(rwscale)]);
%             end
%
%             %     mkdir([DestDataPath,'\IndexEmbeddedFeatures\Mocap_test',num2str(name+6),'\']);
%         end
%     end
% end

%
% number_of_files = 10;
%
% % only one option from below will work
% pick_small_feature = 1;
% pick_large_feature = 0;
% pick_random_feature = 0;
%
% current_OS = 'Mac'; % windows
% if (strcmp(current_OS, 'windows') == 1)
%     delimiter = '\';
% else
%     delimiter = '/';
% end
%
% TimeSeriesIndex = 1;
% TS_name = num2str(TimeSeriesIndex);
% % Data_Type = ['Energy_Building']; % MoCap
% Data_Type = ['MoCap']; % MoCap
%
% % FeaturePath = 'D:\Motif_Results\Datasets\Mocap\Features_RMT';
% % DestDataPath = 'D:\Motif_Results\Datasets\SynteticDataset\data';
% if(strcmp(Data_Type, 'Energy_Building') == 1)
%     FeaturePath = '/Users/sliu104/Desktop/EnergyTestData/RMT';
%     DestDataPath = ['/Users/sliu104/Desktop/EnergyTestData/InjectedFeatures_', num2str(TimeSeriesIndex)];
% else
%     FeaturePath = '/Users/sliu104/Desktop/MoCapTestData/RMT';
%     DestDataPath = ['/Users/sliu104/Desktop/MoCapTestData/InjectedFeatures_', num2str(TimeSeriesIndex)];
% end
%
% random_walk_path = ['/Users/sliu104/Desktop/RandomWalks_Generated/'];
% FeaturePath = [FeaturePath, delimiter, num2str(TimeSeriesIndex), delimiter];
%
% % pick features from higher octaves
% DepdO = 2; % octave depd
% TimeO = 2; % octave time
%
% NumInstances = 10; % inject into 10 locations
% frame1 = [];
%
% % read the depd involved for the corresponding features
% dpscale = csvread(strcat(FeaturePath, 'DistancesDescriptor', delimiter, 'DepdScale_IM_', TS_name, '_DepO_', num2str(DepdO), '_TimeO_', num2str(TimeO), '.csv'));
%
% savepath1 = [FeaturePath, 'feature_', TS_name, '.mat'];
% savepath2 = [FeaturePath, 'idm_', TS_name, '.mat'];
% savepath3 = [FeaturePath, 'MetaData_', TS_name, '.mat'];
% load(savepath1);
% load(savepath2);
% load(savepath3);
%
% % load metadata graph
% metadataPath = [FeaturePath, 'idm_', num2str(TimeSeriesIndex), '.mat'];
% idm = load(metadataPath);
% idm = idm.idm1;
%
% % So far only use features from higher octaves
% indexfeatureGroup = (frame1(6,:) == TimeO & frame1(5,:) == DepdO);
% featuresOfInterest = frame1(:, indexfeatureGroup);
%
% [rows, columns] = size(featuresOfInterest);
%
% % put time lengths and different variates check
% % if they share the same variate or length keep looping
%
% timeLengthFlag = 1;
% variateFlag = 1;
%
% % datarows : variates
% % datacoln : time stamps
% [datarows, datacoln] = size(data);
%
% for nn = 1 : number_of_files
%     TEST_1 = [Data_Type, num2str(nn)];
%
%     % read randomwalk here
%     % [rndWalks1,rndWalks2] = rndWalkGenerationbigSize(size(data,1), floor(size(data, 2) * time_stamps_scale), data);
%
%     random_walk_file = [random_walk_path, 'RandomWalk_', num2str(nn), '.csv'];
%     rndWalks1 = csvread(random_walk_file);
%
%     % FeatPositions: class label, time center of original features, time start, time end
%     FeatPositions = zeros(NumInstances, 4);
%
%     % avoid injecting features in the same position
%     Step = floor(size(rndWalks1, 2) / NumInstances);
%
%     % count the injection location
%     pStep = 0;
%
%     % read features for injection
%     % pick different locations, different group of variates for injection
%     sameVariateGroup = 0;
%
%     % pick feature that covers the smallest portion of variates
%     if(pick_small_feature == 1)
%         [patternFeature, patternVariates] = pickSmallestVariateCoverageFeatures(featuresOfInterest, dpscale);
%     end
%
%     if(pick_large_feature == 1)
%         [patternFeature, patternVariates] = pickLargestVariateCoverageFeatures(featuresOfInterest, dpscale);
%     end
%
%     if(pick_random_feature == 1)
%         [patternFeature, patternVariates] = pickRandomVariateCoverageFeatures(featuresOfInterest, dpscale);
%     end
%     [rndWalks1, FeatPositions1, injectedVariates1] = featureInject(patternFeature, patternVariates, sameVariateGroup, NumInstances, rndWalks1, FeatPositions, data, idm, DepdO);
%     % dpscale_injected = [ dpscale_injected, patternVariates];
%
%     if(exist([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter], 'dir')==0)
%         mkdir([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter]);
%     end
%
%     csvwrite([DestDataPath, delimiter, TEST_1,'.csv'], rndWalks1);
%     csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter, 'FeaturePosition_', TEST_1, '.csv'], FeatPositions1);
%     csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter, 'dpscale_', TEST_1, '.csv'], injectedVariates1);
%     % csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter, 'injectedDpscale_', TEST_1, '.csv'], injectedVariates1);
%     csvwrite([DestDataPath, delimiter, 'IndexEmbeddedFeatures', delimiter, TEST_1, delimiter, 'FeaturesEmbedded_', TEST_1, '.csv'], patternFeature);
% end
%
% fprintf('Manual injection done .\n');