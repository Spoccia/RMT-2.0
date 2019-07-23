clc;
clear;

% DataType='Energy';
DataType='Mocap';
% DataType='BirdSong';
basepath='D:\Motif_Results\Datasets\SynteticDataset\';%'/Users/sliu104/Desktop/Motif_Data/SynteticDataset/';%MocapRandomShift
featuresToInjectPath=[basepath,DataType,'\',DataType,'RandomShift\SameSize\data\FeaturesToInject\'];
    %'CoherentShift\MultiSize\data\FeaturesToInject\'];
%,'/RandomVariate','/instancesmultisize/data/FeaturesToInject/'];
randomWalkPath = [basepath,DataType,'\',DataType,'RandomShift\SameSize\data\RW_0_1/RW_'];
%'CoherentShift\MultiSize\data\RW_0_1/RW_'];
TimeSeriesPath = ['D:\Motif_Results\Datasets\',DataType,'/data/'];%['/Users/sliu104/Desktop/Motif_Data/TimeSeries/',DataType,'/data/'];
depdO=2;
coherentinjectionFlag = 0;% 1;% if coherent;
num_of_motif=1;
delimiter='/';
DestDataPath = [basepath,DataType,'\',DataType,'RandomShift\SameSize\data\'];
%'CoherentShift\MultiSize\data\'];
% NUM_VARIATE = 27;%Energy
NUM_VARIATE = 62;% MoCap
% NUM_VARIATE = 13;% BirdSong
random_walk_instance = 10;
motif_instances = 10;
RWlength = 2500-100;
random_walk_scale = [0,0.1,0.25,0.5,0.75,1,2];%0.1;% randomWalkScale =
possibleMotifNUM=[1, 2, 3, 10];

% length_percentage= [1,0.75,0.5,1,0.75,0.5,1,0.75,1,0.5];
%%
load([featuresToInjectPath,'allTSid.mat']);
originalTSIDArray=sort(AllTS(1:30));
FeatureSelectionalID = 1;% csvread([DestDataPath,'/FeaturesToInject/featureselectedinfiles.csv']);%[];   
for orgID = 1:30 %length(originalTSIDArray)%2
    %% for each posible motifs to inject prepare a random semlection of the possible reduced time sizes.
% length_percentage_1 = [1,0.75,0.5,1,0.75,0.5,1,0.75,0.5,1,0.75,0.5];%[1,0.75,0.5];
 length_percentage_1 =[1,1,1,1,1,1,1,1,1,1,1,1];
length_percentage=[];
for pssMotID =1:num_of_motif%3
    randid= randperm(motif_instances);
    length_percentage=[length_percentage;length_percentage_1(randid)];
end
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
                    %% shift variates to avoid big jumps
                    listvariates=MotifsSections{MotifID}.depd((MotifsSections{MotifID}.depd(:,1)>0),1);
                    MotifInstanceShifted=M1;
                    variatesofInjection =  actualVariateToinject((actualVariateToinject(:,1)>0),1);
                    StartRWvalues=Motif1RW(:,starterTime(motifInstance));
                    RwtoShift= Motif1RW(:,starterTime(motifInstance):RWlength);
                    for varaitetouse=1:size(listvariates)
                        VariateShift= MotifInstanceShifted(listvariates(varaitetouse),1)-StartRWvalues(variatesofInjection(varaitetouse),1);
                        MotifInstanceShifted(listvariates(varaitetouse),:)= MotifInstanceShifted(listvariates(varaitetouse),:)-VariateShift;
                    end
                    
                    Motif1RW(actualVariateToinject((actualVariateToinject(:,1)>0),1),starterTime(motifInstance):starterTime(motifInstance)+scalingTime-1) = ...
                       MotifInstanceShifted(MotifsSections{MotifId}.depd(MotifsSections{MotifId}.depd(:,1)>0,1),:);% M1(actualVariateToinject(actualVariateToinject(:,1)>0,1),:);
                    
                   Motif1RW(actualVariateToinject((actualVariateToinject(:,1)>0),1),starterTime(motifInstance)+scalingTime:RWlength)= ...
                        RwtoShift(actualVariateToinject((actualVariateToinject(:,1)>0),1),1:end-scalingTime);
                   
                    FeatPositions(motifInstance,:)=[MotifID,motifInstance,starterTime(motifInstance),starterTime(motifInstance)+scalingTime-1];
                    EachInstanceDependency=[EachInstanceDependency, actualVariateToinject ];
                    clear('MotifInstanceShifted');
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
        
    end
    
end
csvwrite([DestDataPath,'/FeaturesToInject/featureselectedinfiles.csv'],FeatureSelectionalID);
fprintf('Feature Injection done .\n');


