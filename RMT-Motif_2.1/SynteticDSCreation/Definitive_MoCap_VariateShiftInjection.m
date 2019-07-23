


clc;
clear;

DataType='Mocap';
basepath='D:\Motif_Results\Datasets\SynteticDataset\';
featuresToInjectPath=[basepath,DataType,'\',DataType,'RandomShift\SameSize\data\FeaturesToInject\'];
% featuresToInjectPath=[basepath,DataType,'\',DataType,'CoherentShift\SameSize\data\FeaturesToInject\'];

randomWalkPath = [basepath,DataType,'\',DataType,'RandomShift\SameSize\data\RW_0_1/RW_'];
% randomWalkPath = [basepath,DataType,'\',DataType,'CoherentShift\SameSize\data\RW_0_1/RW_'];

TimeSeriesPath = ['D:\Motif_Results\Datasets\',DataType,'\data\'];
depdO=2;
num_of_motif=1;
delimiter='/';
DestDataPath = [basepath,DataType,'\',DataType,'RandomShift\SameSize\data\'];
% DestDataPath = [basepath,DataType,'\',DataType,'CoherentShift\SameSize\data\'];
%NUM_VARIATE = 27;%Energy
NUM_VARIATE = 62;% MoCap
% NUM_VARIATE = 13;% BirdSong
coherentinjectionFlag = 0;% not coherent %1;% coherent % 
random_walk_instance = 10;
motif_instances = 10;
TotalRWlength =2500;
RWlength = TotalRWlength-100;
random_walk_scale = [0,0.1,0.25,0.5,0.75,1,2];%0.1;% randomWalkScale =
possibleMotifNUM=[1, 2, 3, 10];

%%
%length_percentage= [1,0.75,1,0.5,0.75,0.5,1,0.75,1,0.5];
%D:\Motif_Results\Datasets\SynteticDataset\Energy\RandomVariate\instanceMultisize\FeaturesToInject
load([featuresToInjectPath,'allTSid.mat']);
originalTSIDArray=sort(AllTS(1:30));
FeatureSelectionalID=[];%csvread([DestDataPath,'/FeaturesToInject/featureselectedinfiles.csv']);%
for orgID = 1:30 %length(originalTSIDArray)%2
    %% for each posible motifs to inject prepare a random semlection of the possible reduced time sizes.
%     length_percentage_1 = [1,0.75,0.5,1,0.75,0.5,1,0.75,0.5,1,0.75,0.5];%[1,0.75,0.5];
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
        id_test_name = 'Motif';
        testNAME = [id_test_name,num2str(num_of_motif)];
        
        % load  the features and the data
        FeaturesToInject = csvread([featuresToInjectPath,'Features',num2str(originalTSID),'.csv']);
        DepdToInject = csvread([featuresToInjectPath,'depd',num2str(originalTSID),'.csv']);
        
        % MOCAP BirdSong
        TSdata = csvread([TimeSeriesPath,num2str(originalTSID),'.csv'])';
        % Energy
        %TSdata = csvread([TimeSeriesPath,num2str(originalTSID),'.csv']);% remove ' for Energy;
        
        F_select =1;%randi(3);%FeatureSelectionalID(1,orgID);%
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
        CenterVariates=[16,21,18,24];
        tempidx = find(CenterVariates==FeatureToInject(1,1));
        PossibleMotifs2rooms=[25 26 27 28 29 30 31 32 33 34 35 36;
            37 38 39 40 41 42 43 44 45 46 47 48 ]';
        if tempidx>2
            PossibleMotifs2rooms=[30 31 32 33 34 35 36;
                42 43 44 45 46 47 48 ]';
        end
        offSpace=0;
        %% read data for motif injection
        for MotifId =1: num_of_motif
            timescope= FeatureToInject(4,MotifId)*3; % 29
            intervaltime=(round((FeatureToInject(2,MotifId)-timescope)) : (round((FeatureToInject(2,MotifId)+timescope+offSpace))));
            MotifsSections{MotifId}.data = TSdata(:,intervaltime((intervaltime>0 & intervaltime<=size(TSdata,2))));
            MotifsSections{MotifId}.cols = size(MotifsSections{MotifId}.data,2);
            MotifsSections{MotifId}.depd = DepdToInject(:,MotifId);
            LabelMotif=[LabelMotif,ones(1,motif_instances)*MotifId];
            SetOfVaraite=zeros(size(PossibleMotifs2rooms,1),motif_instances);
            
            %%Coherent or Random injection
            if coherentinjectionFlag == 1  %% coherent
                SetOfVaraite = PossibleMotifs2rooms(:,randi(size(PossibleMotifs2rooms,2),1,motif_instances));
            else  %% Random
                MoCap_avoidingflatvariate= [1:33,35:45,47:62];
                numofRandomVariateToInject = size (MotifsSections{MotifId}.depd(MotifsSections{MotifId}.depd(:,1)>0,1),1);
                for instanceMOTIFVariate =1: motif_instances
                    randomVariateSet= randperm(60);
                    SetOfVaraite(:,instanceMOTIFVariate) = MoCap_avoidingflatvariate(randomVariateSet(1:numofRandomVariateToInject))';
                end
            end
            MotifsVariateSet{MotifId}= SetOfVaraite;
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
            if mod (starterTime(i), 2) == 0
                starterTime(i)=starterTime(i)-1;
            end
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
                AllAVGDispM1=[];
                AllAVGDispRW0=[];
                AllFactors =[];
                AllAVGDispNEWRW=[];
                
                %% if Random Walk scale is different from 0 then  look to the average displacement
                if random_walk_scale(rwscale)~=0
                    for allVaraitesiter=1:size(TSdata,1);
                        AVGDISPLACEMENT_RW= mean(abs(randomwalkData(allVaraitesiter,1:end-1)-randomwalkData(allVaraitesiter,2:end)));
                        AllAVGDispRW0=[AllAVGDispRW0;AVGDISPLACEMENT_RW];
                        AVGDisplacement_Motif=0;
                        AVG_MotifAmplitude=0;
                        if pssMotID==1
                            AVGDisplacement_Motif_1= mean(abs(MotifsSections{1}.data(allVaraitesiter,1:end-1)-MotifsSections{1}.data(allVaraitesiter,2:end)));
                            AVGDisplacement_Motif=AVGDisplacement_Motif_1;
                            AVG_MotifAmplitude = mean(MotifsSections{1}.data(allVaraitesiter,:));
                        elseif pssMotID==2
                            AVGDisplacement_Motif_1= mean(abs(MotifsSections{1}.data(allVaraitesiter,1:end-1)-MotifsSections{1}.data(allVaraitesiter,2:end)));
                            AVGDisplacement_Motif_2= mean(abs(MotifsSections{2}.data(allVaraitesiter,1:end-1)-MotifsSections{2}.data(allVaraitesiter,2:end)));
                            AVGDisplacement_Motif=   max([AVGDisplacement_Motif_1,AVGDisplacement_Motif_2]);
                            AVG_MotifAmplitude = mean([MotifsSections{1}.data(allVaraitesiter,:),MotifsSections{2}.data(allVaraitesiter,:)]);
                        elseif pssMotID==3
                            AVGDisplacement_Motif_1= mean(abs(MotifsSections{1}.data(allVaraitesiter,1:end-1)-MotifsSections{1}.data(allVaraitesiter,2:end)));
                            AVGDisplacement_Motif_2= mean(abs(MotifsSections{2}.data(allVaraitesiter,1:end-1)-MotifsSections{2}.data(allVaraitesiter,2:end)));
                            AVGDisplacement_Motif_3= mean(abs(MotifsSections{3}.data(allVaraitesiter,1:end-1)-MotifsSections{3}.data(allVaraitesiter,2:end)));
                            AVGDisplacement_Motif=max([AVGDisplacement_Motif_1,AVGDisplacement_Motif_2,AVGDisplacement_Motif_3]);
                            AVG_MotifAmplitude = mean([MotifsSections{1}.data(allVaraitesiter,:),MotifsSections{2}.data(allVaraitesiter,:),MotifsSections{3}.data(allVaraitesiter,:)]);
                        elseif pssMotID==10
                            AVGDisplacementM10=[];
                            AVGM10=[];
                            for possmotiftoinject=1:10
                                AVGDisplacementM10=[AVGDisplacementM10,mean(abs(MotifsSections{possmotiftoinject}.data(allVaraitesiter,1:end-1)-MotifsSections{possmotiftoinject}.data(allVaraitesiter,2:end)));]
                                AVGM10=[AVGM10,MotifsSections{possmotiftoinject}.data(allVaraitesiter,:)];
                            end
                            AVGDisplacement_Motif=max(AVGDisplacementM10);
                            AVG_MotifAmplitude= mean(AVGM10);
                        end
                        AllAVGDispM1=[AllAVGDispM1;AVGDisplacement_Motif];
                        AVGDisplacement_TS= mean(abs((TSdata(allVaraitesiter,1:end-1)-min(TSdata(allVaraitesiter,1:end)))-(TSdata(allVaraitesiter,2:end)+min(TSdata(allVaraitesiter,1:end)))));
                        Bha = (AVGDisplacement_Motif/AVGDISPLACEMENT_RW)* random_walk_scale(rwscale);
                        if Bha==0
                            Bha=1;
                        end
                        AllFactors=[AllFactors;Bha];
                        %+ min(MotifsSections{1}.data(allVaraitesiter,1:end));
                        AVGDISPLACEMENT_RW1= mean(abs(randomwalkData(allVaraitesiter,1:end-1)-randomwalkData(allVaraitesiter,2:end)));
                        AllAVGDispNEWRW=[AllAVGDispNEWRW;AVGDISPLACEMENT_RW1];
                        
                        randomwalkData(allVaraitesiter,:)= randomwalkData(allVaraitesiter,:)*Bha - (randomwalkData(allVaraitesiter,1)*Bha - AVG_MotifAmplitude);
                    end
                    %% end of Random Walk AVG displacement computation
                else
                    AVG_MotifAmplitude = mean(MotifsSections{1}.data');
                    for allVaraitesiter=1:size(TSdata,1)
                        randomwalkData(allVaraitesiter,:)= randomwalkData(allVaraitesiter,:) -(randomwalkData(allVaraitesiter,1)- AVG_MotifAmplitude(allVaraitesiter));
                    end
                end
                Motif1RW=randomwalkData;
                
                %% Start Injection
                FeatPositions = zeros(motif_instances*num_of_motif,4);%NEW
                idxMotifID(:)=ones(3,1);%NEW
                StartPosition_RW=[];
                CountInjectedInstances=ones(1,NUM_VARIATE);
                RW_Start=[];
                RW_End=[];
                newEnd=[];
                
                for motifInstance = 1: motif_instances*num_of_motif
                    
                    MotifID=LabelMotif(motifInstance);
                    length_index = length_percentage(MotifID,idxMotifID(MotifID));
                    %% Variate in with we perform injection
                    actualVariateToinject= MotifsVariateSet{MotifID}(:,idxMotifID(MotifID));
                    actualVaraiteToinject= actualVariateToinject(actualVariateToinject>0);
                    idxMotifID(MotifID)=idxMotifID(MotifID)+1;
                    if(length_index == 0)
                        length_index = size(length_percentage, 2);
                    end
                    
                    M1 = imresize( MotifsSections{MotifID}.data,[size( MotifsSections{MotifID}.data,1), size( MotifsSections{MotifID}.data,2)*length_index]);%length_percentage(length_index)]);
                    scalingTime =size(M1,2);
                    %% Original Varaites
                    listvariates=DepdToInject; %MotifsSections{MotifID}.depd((MotifsSections{MotifID}.depd(:,1)>0),1);
                    NewRW=[];
                    for eachvaraitemotif= 1:size(listvariates,1)
                        if (CountInjectedInstances(1,actualVariateToinject(eachvaraitemotif))==1)
                            StartPosition_RW{actualVariateToinject(eachvaraitemotif)}=1;
                            RW_Start{actualVariateToinject(eachvaraitemotif)}{CountInjectedInstances(1,actualVariateToinject(eachvaraitemotif))} = Motif1RW(actualVariateToinject(eachvaraitemotif),StartPosition_RW{actualVariateToinject(eachvaraitemotif)});
                        else
                            RW_Start{actualVariateToinject(eachvaraitemotif)}{CountInjectedInstances(1,actualVariateToinject(eachvaraitemotif))} = Motif1RW(actualVariateToinject(eachvaraitemotif),StartPosition_RW{actualVariateToinject(eachvaraitemotif)});
                        end
                        RW_End{actualVariateToinject(eachvaraitemotif)}{CountInjectedInstances(1,actualVariateToinject(eachvaraitemotif))}  =  Motif1RW(actualVariateToinject(eachvaraitemotif),starterTime(motifInstance));
                        %newEnd{listvariates(eachvaraitemotif)}{CountInjectedInstances(1,listvariates(eachvaraitemotif))}= M1(listvariates(eachvaraitemotif),1);
                        
                        lengthofthispart= starterTime(motifInstance)-StartPosition_RW{actualVariateToinject(eachvaraitemotif)}+1;
                        RW_Bisection=zeros(1,lengthofthispart);
                        RW_Bisection(1,1)= RW_Start{actualVariateToinject(eachvaraitemotif)}{CountInjectedInstances(1,actualVariateToinject(eachvaraitemotif))};%(eachvaraitemotif);
                        RW_M_Bisection=zeros(1,lengthofthispart);
                        RW_M_Bisection(1,1)= RW_Start{actualVariateToinject(eachvaraitemotif)}{CountInjectedInstances(1,actualVariateToinject(eachvaraitemotif))};%(eachvaraitemotif);
                        Step_RWBisection= (RW_End{actualVariateToinject(eachvaraitemotif)}{CountInjectedInstances(1,actualVariateToinject(eachvaraitemotif))}-RW_Start{actualVariateToinject(eachvaraitemotif)}{CountInjectedInstances(1,actualVariateToinject(eachvaraitemotif))})/lengthofthispart;
                        Step_RW_M_Bisection= (M1(listvariates(eachvaraitemotif),1) - RW_Start{actualVariateToinject(eachvaraitemotif)}{CountInjectedInstances(1,actualVariateToinject(eachvaraitemotif))})/lengthofthispart;
                        for ti= 2: lengthofthispart
                            RW_Bisection(1,ti)=RW_Bisection(1,ti-1)+Step_RWBisection;
                            RW_M_Bisection(1,ti)=RW_M_Bisection(1,ti-1)+Step_RW_M_Bisection;
                        end
                        DistRW = Motif1RW(actualVariateToinject(eachvaraitemotif),StartPosition_RW{actualVariateToinject(eachvaraitemotif)}:starterTime(motifInstance)) - RW_Bisection;
                        %NewRW =[NewRW; (DistRW +RW_M_Bisection)];
                        
                        
                        %% adapted Random Walk to the motif start
                        Motif1RW(actualVariateToinject(eachvaraitemotif),StartPosition_RW{actualVariateToinject(eachvaraitemotif)}:starterTime(motifInstance))=   (DistRW +RW_M_Bisection);
                        
                        StartPosition_RW{actualVariateToinject(eachvaraitemotif)}=starterTime(motifInstance)+scalingTime-1;
                        CountInjectedInstances(1,actualVariateToinject(eachvaraitemotif))=CountInjectedInstances(1,actualVariateToinject(eachvaraitemotif))+1;
                    end
                        %% adapted Random Walk to the motif start
                        %% adapt the RW to the motif end
                        for eachvaraitemotif= 1:size(listvariates,1)
                            d= M1(listvariates(eachvaraitemotif),end)-Motif1RW(actualVariateToinject(eachvaraitemotif),starterTime(motifInstance)+scalingTime-1);
                            Motif1RW(actualVariateToinject(eachvaraitemotif),starterTime(motifInstance)+scalingTime-1 : end) =...
                            Motif1RW(actualVariateToinject(eachvaraitemotif),starterTime(motifInstance)+scalingTime-1 : end)+d;
                        end
                        %% motif injection
                        Motif1RW(actualVariateToinject,starterTime(motifInstance):starterTime(motifInstance)+scalingTime-1)=M1(listvariates,:);                    
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
        csvwrite([DestDataPath,'/FeaturesToInject/featureselectedinfiles.csv'],FeatureSelectionalID);
        
        
    end
    
end
fprintf('Feature Injection done .\n');
