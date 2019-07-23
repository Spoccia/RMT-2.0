clc;
clear;
DS_List ={'Mocap','Energy','BirdSong'};
% Ds_Name= DS_List{1};%
for DSIdx =1:1%3%3
    DatasetTouse= DS_List{DSIdx};%'Mocap';%'Energy';%'BirdSong';%
    experimentFolder=' Motif 10 multilength';%' Motif 1 same length';%' Motifs 1 2 3 same variate multisize';%' Motif1 inst5-15';%' Motif 1 same length';%' Motifs 1 2 3 same variate multisize';%
    featuresToInjectPath=['D:\Motif_Results\Datasets\SynteticDataset\',DatasetTouse,'\',DatasetTouse,experimentFolder,'\data\FeaturesToInject\'];
    %['D:\Motif_Results\Datasets\SynteticDataset\BSONG\FeaturesToInject\'];
    %['D:\Motif_Results\Datasets\SynteticDataset\data\FeaturesToInject\'];%MOCAP
    randomWalkPath = ['D:\Motif_Results\Datasets\SynteticDataset\',DatasetTouse,'\',DatasetTouse,experimentFolder,'\data\RW_0_1\RW_'];
    %['D:\Motif_Results\Datasets\SynteticDataset\BSONG\RW_0_1\RW_'];
    % ['D:\Motif_Results\Datasets\SynteticDataset\data\RW_0_1\RW_'];
    TimeSeriesPath = ['D:\Motif_Results\Datasets\',DatasetTouse,'\data\'];
    %['D:\Motif_Results\Datasets\BirdSong\data\'];
    %['D:\Motif_Results\Datasets\Mocap\data\'];
    
    DestDataPath = ['D:\Motif_Results\Datasets\SynteticDataset\',DatasetTouse,'\',DatasetTouse,experimentFolder,'\data'];
    %\BSONG';
    NUM_VARIATE=0;
    if strcmp(DatasetTouse,'Mocap')==1
        NUM_VARIATE = 62;%MoCap;%27;%Energy;%13;%BirdSong  %
    elseif strcmp(DatasetTouse,'BirdSong')==1
        NUM_VARIATE = 13;
    elseif strcmp(DatasetTouse,'Energy')==1
        NUM_VARIATE = 27;
    end
    random_walk_instance = 10;
    motif_instances = 10;%10;%15;% % MotifInstances= 10;
    TotalRWlength =8000;%2500;
    RWlength = TotalRWlength-100;
    random_walk_scale = [0,0.1,0.25,0.5,0.75,1,2];%0.1;% randomWalkScale =
    possibleMotifNUM=[1,2,3,10];%AllTS;%
    
    % support= randi(3,1,motif_instances);
    % possMotifScaleTime= [1,0.75,0.5];
    % length_percentage = possMotifScaleTime(support);
    %
    length_percentage_1 =[1,0.75,0.5,1,0.75,0.5,1,0.75,0.5,1,0.75,0.5];%,1,0.75,0.5,1,0.75,0.5];%,1];%,0.75,0.5,1,0.75,0.5,1,0.75,0.5];%,1,0.75,0.5];%[1,0.75,0.5];%
    %     length_percentage_1 = [1 1 1 1 1 1 1 1 1 1];
    %                      0.75,0.5,1;
    %                      1,0.5,0.75];%0.5;% length_percentage =
    %originalTSIDArray=[23,35,86,111];%[1,3,6,7];%Energy %[64,70,80,147];%BirdSong; %[85,24,35,127];%Mocap
    load([featuresToInjectPath,'allTSid.mat']);
    originalTSIDArray=sort(AllTS(1:30));
    for orgID =1:30%length(originalTSIDArray)%2
        length_percentage=[];
        for pssMotID =1:10
            randid= randperm(size(length_percentage_1,2));
            randid=randid(:,1:motif_instances);
            length_percentage=[length_percentage;length_percentage_1(randid)];
        end
        originalTSID=originalTSIDArray(orgID)%85;%127;%[24,35,85,127];85;%24;%35;%
        %\data'; %for MOCAP
        
        for pssMotID = 1:1%3%length(possibleMotifNUM)-1%4:4
            num_of_motif = possibleMotifNUM(pssMotID);%3; % NumOfMotifs = 1;
            
            
            
            % descr_non_zero_entry =  10;% 10;% percentage 10, 50
            
            id_test_name='Motif';
            % testNAME = ['100_Motif_',num2str(motif_instances),'_',num2str(num_of_motif)];
            
            %testNAME = [id_test_name,num2str(num_of_motif)];%,'_',num2str(originalTSID)];%num2str(motif_instances),'_',num2str(num_of_motif)];
            testNAME = [id_test_name,num2str(num_of_motif)];%,'numInst_',num2str(motif_instances)];
            
            % load  the features and the data
            FeaturesToInject = csvread([featuresToInjectPath,'Features',num2str(originalTSID),'.csv']);%,'_',num2str(descr_non_zero_entry),'.csv']);
            DepdToInject = csvread([featuresToInjectPath,'depd',num2str(originalTSID),'.csv']);%,'_',num2str(descr_non_zero_entry),'.csv']);
            TSdata=[];
            if strcmp(DatasetTouse,'Mocap')==1
                TSdata = csvread([TimeSeriesPath,num2str(originalTSID),'.csv'])';
            elseif strcmp(DatasetTouse,'BirdSong')==1
                TSdata = csvread([TimeSeriesPath,num2str(originalTSID),'.csv'])';
            elseif strcmp(DatasetTouse,'Energy')==1
                TSdata = csvread([TimeSeriesPath,num2str(originalTSID),'.csv']);% remove ' for Energy;
            end
            %% MOCAP BirdSong
            %         TSdata = csvread([TimeSeriesPath,num2str(originalTSID),'.csv'])';
            %% Energy
            %           TSdata = csvread([TimeSeriesPath,num2str(originalTSID),'.csv']);% remove ' for Energy;
            
            FeatureToInject= FeaturesToInject(:,1:num_of_motif);
            DepdToInject = DepdToInject(:,1:num_of_motif);
            MotifsSections=[];
            offSpace=0;
            for MotifId =1: num_of_motif
                timescope= FeatureToInject(4,MotifId)*3; % 29
                intervaltime=(round((FeatureToInject(2,MotifId)-timescope)) : (round((FeatureToInject(2,MotifId)+timescope+offSpace))));
                if(size(intervaltime,2)<33)
                    ['Features',num2str(originalTSID),'.csv']
                    'check'
                end
                MotifsSections{MotifId}.data = TSdata(:,intervaltime((intervaltime>0 & intervaltime<=size(TSdata,2))));
                
                MotifsSections{MotifId}.depd = DepdToInject(:,MotifId);
                MotifsSections{MotifId}.cols = size(MotifsSections{MotifId}.data,2);
                
            end
            startInj=30;
            Step= floor( (RWlength-60)/(motif_instances*num_of_motif));
            startTime =zeros(1,motif_instances*num_of_motif);
            starterTime(1) = startInj ;
            LabelMotif = [];
            for i =1: num_of_motif
                LabelMotif=[LabelMotif,ones(1,motif_instances)*i];
            end
            LabelMotif = LabelMotif( randperm(length(LabelMotif))) ;
            pStep=0;
            for i=1:motif_instances*num_of_motif
                motifclmn = MotifsSections{LabelMotif(i)}.cols;
                starterTime (i)= randi([startInj+pStep,startInj+pStep+Step-motifclmn],1,1);
                if mod (starterTime(i), 2) == 0
                    starterTime(i)=starterTime(i)-1;
                end
                pStep=pStep+Step;
            end
            % Counter =1;
            TSNAMEFIX=testNAME;
            for rwscale = 1 : size(random_walk_scale,2)
                for i =1 : random_walk_instance
                    % read the 0-1 randomwalk
                    
                    testNAME = [TSNAMEFIX,'_',num2str(originalTSID),'_',num2str(motif_instances),'_instance_',num2str(i)];
                    
                    
                    EachInstanceDependency=[];
                    randomwalkData = csvread([randomWalkPath,num2str(i),'.csv']);
                    %%same random walk for all varaites and  computation
                    %%for shifting variates
%                     AVGAmplitudeORGMotif =[];
%                     for idVaraite=1:size(randomwalkData,1)
%                         randomwalkData (idVaraite,:)=randomwalkData (1,:);
%                         %% info to scale  the motif in the original motif range
%                         AVGAmplitudeMotif= (max(MotifsSections{1}.data(idVaraite,:))+min(MotifsSections{1}.data(idVaraite,:)))/2;
%                         AVGAmplitudeORGMotif=[AVGAmplitudeORGMotif;AVGAmplitudeMotif];
%                         %%
%                     end
                    NormInterval=[zeros(NUM_VARIATE,1),ones(NUM_VARIATE,1)];
                    AllAVGDispM1=[];
                    AllAVGDispRW0=[];
                    AllFactors =[];
                    AllAVGDispNEWRW=[];
                    if random_walk_scale(rwscale)~=0
                        for allVaraitesiter=1:size(TSdata,1);
                            AVGDISPLACEMENT_RW= mean(abs(randomwalkData(allVaraitesiter,1:end-1)-randomwalkData(allVaraitesiter,2:end)));
                            AllAVGDispRW0=[AllAVGDispRW0;AVGDISPLACEMENT_RW];
                            AVGDisplacement_Motif=0;
                            if pssMotID==1
                                AVGDisplacement_Motif_1= mean(abs(MotifsSections{1}.data(allVaraitesiter,1:end-1)-MotifsSections{1}.data(allVaraitesiter,2:end)));
                                
                                
                                AVGDisplacement_Motif=AVGDisplacement_Motif_1;
                            elseif pssMotID==2
                                AVGDisplacement_Motif_1= mean(abs(MotifsSections{1}.data(allVaraitesiter,1:end-1)-MotifsSections{1}.data(allVaraitesiter,2:end)));
                                AVGDisplacement_Motif_2= mean(abs(MotifsSections{2}.data(allVaraitesiter,1:end-1)-MotifsSections{2}.data(allVaraitesiter,2:end)));
                                AVGDisplacement_Motif=mean([AVGDisplacement_Motif_1,AVGDisplacement_Motif_2]);
                            elseif pssMotID==3
                                AVGDisplacement_Motif_1= mean(abs(MotifsSections{1}.data(allVaraitesiter,1:end-1)-MotifsSections{1}.data(allVaraitesiter,2:end)));
                                AVGDisplacement_Motif_2= mean(abs(MotifsSections{2}.data(allVaraitesiter,1:end-1)-MotifsSections{2}.data(allVaraitesiter,2:end)));
                                AVGDisplacement_Motif_3= mean(abs(MotifsSections{3}.data(allVaraitesiter,1:end-1)-MotifsSections{3}.data(allVaraitesiter,2:end)));
                                AVGDisplacement_Motif=max([AVGDisplacement_Motif_1,AVGDisplacement_Motif_2,AVGDisplacement_Motif_3]);
                            elseif pssMotID==10
                                AVGDisplacementM10=[];
                                for possmotiftoinject=1:10
                                    AVGDisplacementM10=[AVGDisplacementM10,mean(abs(MotifsSections{possmotiftoinject}.data(allVaraitesiter,1:end-1)-MotifsSections{possmotiftoinject}.data(allVaraitesiter,2:end)));]
                                end
                                AVGDisplacement_Motif=max(AVGDisplacementM10);
                            end
                            
                            
                            AllAVGDispM1=[AllAVGDispM1;AVGDisplacement_Motif];
                            AVGDisplacement_TS= mean(abs((TSdata(allVaraitesiter,1:end-1)-min(TSdata(allVaraitesiter,1:end)))-(TSdata(allVaraitesiter,2:end)+min(TSdata(allVaraitesiter,1:end)))));
                            Bha = (AVGDisplacement_Motif/AVGDISPLACEMENT_RW)* random_walk_scale(rwscale);
                            AllFactors=[AllFactors;Bha];
                            randomwalkData(allVaraitesiter,:)= randomwalkData(allVaraitesiter,:)*Bha;%+ min(MotifsSections{1}.data(allVaraitesiter,1:end));
                            AVGDISPLACEMENT_RW1= mean(abs(randomwalkData(allVaraitesiter,1:end-1)-randomwalkData(allVaraitesiter,2:end)));
                            AllAVGDispNEWRW=[AllAVGDispNEWRW;AVGDISPLACEMENT_RW1];
                        end
                    end
                    % AVGDisplacement_Motif_2= mean(MotifsSections{2}.data(1,1:end-1)-MotifsSections{2}.data(1,2:end-1));
                    % AVGDisplacement_Motif_3= mean(MotifsSections{3}.data(1,1:end-1)-MotifsSections{3}.data(1,2:end-1));
                    
                    %                          NormInterval(:,1)= (min(TSdata')*random_walk_scale(rwscale))';
                    %                          NormInterval(:,2)= (max(TSdata')*random_walk_scale(rwscale))';
                    %                          randomwalkData= NormalizeRandomWalk(randomwalkData,NormInterval,0);
                    %end
                    Motif1RW=randomwalkData;
                    %             minvalueTS = min(TSdata');
                    %             maxvalueTS = max(TSdata');
                    %         Motif1RW = scaleRW(randomwalkData,maxvalueTS,minvalueTS,random_walk_scale(rwscale));
                    
                    FeatPositions = zeros(motif_instances*num_of_motif,4);%NEW
                    idxMotifID=ones(num_of_motif,1)';%NEW
                    for motifInstance = 1: motif_instances*num_of_motif
                        MotifID=LabelMotif(motifInstance);
                        
                        
                        length_index = length_percentage(MotifID,idxMotifID(MotifID));
                        %  length_index =  mod(motifInstance, length(length_percentage));
                        idxMotifID(MotifID)=idxMotifID(MotifID)+1;
                        if(length_index == 0)
                            length_index = size(length_percentage, 2);
                        end
                        M1 = imresize( MotifsSections{MotifID}.data,[size( MotifsSections{MotifID}.data,1), size( MotifsSections{MotifID}.data,2)*length_index]);%length_percentage(length_index)]);
                        scalingTime =size(M1,2);
                        listvariates=MotifsSections{MotifID}.depd((MotifsSections{MotifID}.depd(:,1)>0),1);
                        MotifInstanceShifted=M1;
                        StartRWvalues=Motif1RW(:,starterTime(motifInstance));
                        RwtoShift= Motif1RW(:,starterTime(motifInstance)+scalingTime-1:end);
                        for varaitetouse=1:size(listvariates)
                            VariateShift= MotifInstanceShifted(listvariates(varaitetouse),1)-StartRWvalues(listvariates(varaitetouse));
                            MotifInstanceShifted(listvariates(varaitetouse),:)= MotifInstanceShifted(listvariates(varaitetouse),:)-VariateShift;
                            RWShiftedvalue = RwtoShift(listvariates(varaitetouse),1)- MotifInstanceShifted(listvariates(varaitetouse),end);
                            RwtoShift(listvariates(varaitetouse),:)= RwtoShift(listvariates(varaitetouse),1:end) - RWShiftedvalue;
                        end
                        Motif1RW(MotifsSections{MotifID}.depd((MotifsSections{MotifID}.depd(:,1)>0),1),starterTime(motifInstance):starterTime(motifInstance)+scalingTime-1) = ...
                            MotifInstanceShifted(MotifsSections{MotifID}.depd(MotifsSections{MotifID}.depd(:,1)>0,1),:);
                        Motif1RW(MotifsSections{MotifID}.depd((MotifsSections{MotifID}.depd(:,1)>0),1),starterTime(motifInstance)+scalingTime:TotalRWlength)= ...
                            RwtoShift(MotifsSections{MotifID}.depd((MotifsSections{MotifID}.depd(:,1)>0),1),2:end);
                        
                        FeatPositions(motifInstance,:)=[MotifID,motifInstance,starterTime(motifInstance),starterTime(motifInstance)+scalingTime-1];
                        EachInstanceDependency=[EachInstanceDependency, MotifsSections{MotifID}.depd ];
                        clear('MotifInstanceShifted');
                    end
%                     %% scale teh motifs to preserve the original  relation between variates
%                     motifnoshift= Motif1RW;
%                     for idVariates=1: size(Motif1RW,1)
%                         Motif1RW(idVariates,:)= Motif1RW(idVariates,:) -(Motif1RW(idVariates,1)-AVGAmplitudeORGMotif(idVariates,1));
%                     end
                    if(exist([DestDataPath,'\IndexEmbeddedFeatures\'],'dir')==0)
                        mkdir([DestDataPath,'\IndexEmbeddedFeatures\']);
                    end
                    csvwrite([DestDataPath,'\',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],Motif1RW);
%                     csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','MotifNoShift_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],motifnoshift);
                    csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','FeaturePosition_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],FeatPositions);%,testNAME,'\'
                    csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','dpscale_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],EachInstanceDependency);
                    %               csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','ORGRW',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],randomwalkData);
                    csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','Parameters_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],[originalTSID;num_of_motif;motif_instances;i;random_walk_scale(rwscale)]);
                    %         Counter=Counter+1;
                end
                
                %     mkdir([DestDataPath,'\IndexEmbeddedFeatures\Mocap_test',num2str(name+6),'\']);
            end
        end
    end
end