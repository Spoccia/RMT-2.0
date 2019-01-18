clc;
clear;

DataType='Energy';
%DataType='Mocap';
% DataType='BirdSong';
basepath='D:\Motif_Results\Datasets\SynteticDataset\';%'/Users/sliu104/Desktop/Motif_Data/SynteticDataset/';%
featuresToInjectPath=[basepath,DataType,'\RandomVariate\instancessamesize\data','\FeaturesToInject\',];
randomWalkPath = [basepath,DataType,'\RandomVariate\instancessamesize\data','\RW_0_1\RW_'];
TimeSeriesPath = ['D:\Motif_Results\Datasets\',DataType,'\data\'];%['/Users/sliu104/Desktop/Motif_Data/TimeSeries/',DataType,'/data/'];
depdO=2;
num_of_motif=1;
delimiter='/';
DestDataPath = [basepath,DataType,'\RandomVariate\instancessamesize\data'];
NUM_VARIATE = 27;%Energy
%NUM_VARIATE = 62;% MoCap
% NUM_VARIATE = 13;% BirdSong
coherentinjectionFlag = 0  %% coherent
random_walk_instance = 10;
motif_instances = 10;
RWlength = 2500-59;
random_walk_scale = [0,0.1,0.25,0.5,0.75,1,2];%0.1;% randomWalkScale =
possibleMotifNUM=[1, 2, 3, 10];
%% for each posible motifs to inject prepare a random semlection of the possible reduced time sizes.
length_percentage_1 = [1,0.75,0.5,1,0.75,0.5,1,0.75,0.5,1,0.75,0.5];%[1,0.75,0.5];
% length_percentage_1 =[1,1,1,1,1,1,1,1,1,1,1,1];
length_percentage=[];
for pssMotID =1:num_of_motif%3
    randid= randperm(motif_instances);
    length_percentage=[length_percentage;length_percentage_1(randid)];
end
%%
%length_percentage= [1,0.75,1,0.5,0.75,0.5,1,0.75,1,0.5];
%D:\Motif_Results\Datasets\SynteticDataset\Energy\RandomVariate\instanceMultisize\FeaturesToInject
load([featuresToInjectPath,'allTSid.mat']);
originalTSIDArray=AllTS;
FeatureSelectionalID=[];%csvread([DestDataPath,'/FeaturesToInject/featureselectedinfiles.csv']);%
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
        %TSdata = csvread([TimeSeriesPath,num2str(originalTSID),'.csv'])';
        % Energy
        TSdata = csvread([TimeSeriesPath,num2str(originalTSID),'.csv']);% remove ' for Energy;
        
        F_select =randi(3);%FeatureSelectionalID(1,orgID);%
        %         V_select=FeatureSelectionalID(2,orgID);%randi(6);
        %FeatureSelectionalID=[FeatureSelectionalID,[F_select;V_select]];
        FeatureToInject = FeaturesToInject(:,F_select);
        DepdToInject = DepdToInject(DepdToInject(:,F_select)>0,F_select);
        %         if(V_select>3)
        %             DepdToInject = DepdToInject(4:6,F_select);
        %         else
        %             DepdToInject = DepdToInject(1:3,F_select);
        %         end
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
        
        %% compute random variate sets
        %         randomVariateSet= randperm(27);
        %         randomVariateSet=[randomVariateSet,randperm(27)];
        %         randomVariateSet= reshape(randomVariateSet(1:30),[3,10]);
        PossibleMotifs2rooms= [ 1  2  3  4  5  6
            7  8  9 13 14 15
            13 14 15 16 17 18
            10 11 12 19 20 21
            22 23 24 25 26 27
            6  5  4  3  2  1
            15 14 13  9  8  7
            18 17 16 15 14 13
            21 20 19 12 11 10
            27 26 25 24 23 22]';
        offSpace=0;
        for MotifId =1: num_of_motif
            timescope= FeatureToInject(4,MotifId)*3; % 29
            intervaltime=(round((FeatureToInject(2,MotifId)-timescope)) : (round((FeatureToInject(2,MotifId)+timescope+offSpace))));
            MotifsSections{MotifId}.data = TSdata(:,intervaltime((intervaltime>0 & intervaltime<=size(TSdata,2))));
            %             MotifsSections{MotifId}.depd = DepdToInject(:,MotifId);
            MotifsSections{MotifId}.cols = size(MotifsSections{MotifId}.data,2);
            LabelMotif=[LabelMotif,ones(1,motif_instances)*MotifId];
            SetOfVaraite=zeros(size(PossibleMotifs2rooms,1),motif_instances);
            
            
            if coherentinjectionFlag == 1  %% coherent
                SetOfVaraite = PossibleMotifs2rooms(:,randi(size(PossibleMotifs2rooms,2),1,motif_instances));
            else  %% Random
                for instanceMOTIFVariate =1: motif_instances                    
                    SetOfVaraite(:,instanceMOTIFVariate) = randperm(27,size(PossibleMotifs2rooms,1));
                end
            end
            MotifsVariateSet{MotifId}= SetOfVaraite;
            %MotifsVariateSet{MotifId}= [1 4 7 10 13 16 19 22 25 7; 2 5 8 11 14 17 20 22 26 8; 3 6 9 12 15 18 21 24 27 9];
            %             [7	1	13	10	22	7	1	13	10	22
            %                                         8	2	14	11	23	8	2	14	11	23
            %                                         9	3	15	12	24	9	3	15	12	24
            %                                         13	4	16	19	25	16	4	16	19	25
            %                                         14	5	17	20	26	17	5	17	20	26
            %                                         15	6	18	21	27	18	6	18	21	27];%
            %           [~,~,MotifsVariateSet{MotifId}]= featureInject(FeatureToInject(:,MotifId), DepdToInject(:,MotifId), sameVariateGroup, motif_instances, rndWalks1, FeatPositions, data, idm1, depdO,MotifId);
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
                        M1(DepdToInject,:);% M1(actualVariateToinject(actualVariateToinject(:,1)>0,1),:);
                    
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
        csvwrite([DestDataPath,'/FeaturesToInject/featureselectedinfiles.csv'],FeatureSelectionalID);
        
        
    end
    
end
fprintf('Feature Injection done .\n');
