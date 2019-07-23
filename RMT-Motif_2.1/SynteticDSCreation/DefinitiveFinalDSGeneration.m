clc;
clear;
DS_List ={'Mocap','Energy','BirdSong'};

experimentFolder=' Motif 1 same length';%' Motif 10 multilength';%' Motifs 1 2 3 same variate multisize';%' Motif 10 multilength';' Motif1 inst5-15';%
% length_percentage_1 =[1,0.75,0.5,1,0.75,0.5,1,0.75,0.5,1,0.75,0.5];%,1,0.75,0.5,1,0.75,0.5];%,1];%,0.75,0.5,1,0.75,0.5,1,0.75,0.5];%,1,0.75,0.5];%[1,0.75,0.5];%
     length_percentage_1 = [1 1 1 1 1 1 1 1 1 1];

random_walk_instance = 10;
motif_instances = 10;%5;% %15 MotifInstances= 10;
TotalRWlength =2500;%8000;%
RWlength = TotalRWlength-100;
random_walk_scale = [0,0.1,0.25,0.5,0.75,1,2];%0.1;% randomWalkScale =
possibleMotifNUM=[1,2,3,10];
MaxNumMotifs=1;
length_percentage=[];

for DSIdx =1:3
    DatasetTouse= DS_List{DSIdx};
    featuresToInjectPath=['D:\Motif_Results\Datasets\SynteticDataset\',DatasetTouse,'\',DatasetTouse,experimentFolder,'\data\FeaturesToInject\'];
    randomWalkPath = ['D:\Motif_Results\Datasets\SynteticDataset\',DatasetTouse,'\',DatasetTouse,experimentFolder,'\data\RW_0_1\RW_'];
    TimeSeriesPath = ['D:\Motif_Results\Datasets\',DatasetTouse,'\data\'];
    DestDataPath = ['D:\Motif_Results\Datasets\SynteticDataset\',DatasetTouse,'\',DatasetTouse,experimentFolder,'\data'];
    NUM_VARIATE=0;
    motifclmn=0;
    if strcmp(DatasetTouse,'Mocap')==1
        NUM_VARIATE = 62;%MoCap;%27;%Energy;%13;%BirdSong  %
        motifclmn=59;
    elseif strcmp(DatasetTouse,'BirdSong')==1
        NUM_VARIATE = 13;
        motifclmn=33;
    elseif strcmp(DatasetTouse,'Energy')==1
        NUM_VARIATE = 27;
        motifclmn=59;
    end
    load([featuresToInjectPath,'allTSid.mat']);
    originalTSIDArray=sort(AllTS(1:30));
    
    
    %     %% Select the percentage of instances to inject
    %
    %     for pssMotID =1:MaxNumMotifs
    %         randid= randperm(size(length_percentage_1,2));
    %         randid=randid(:,1:motif_instances);
    %         length_percentage=[length_percentage;length_percentage_1(randid)];
    %     end
    
    
    for pssMotID = 1:MaxNumMotifs
        %% Injection  and scaling of Random Walks
        for orgID =1:30
            num_of_motif = possibleMotifNUM(pssMotID);
            length_percentage=[];
            %% Select the percentage of instances to inject
            for pssMotIDPercentage =1:num_of_motif
                randid= randperm(size(length_percentage_1,2));
                randid=randid(:,1:motif_instances);
                length_percentage=[length_percentage;length_percentage_1(randid)];
            end
            
            
            
            id_test_name='Motif';
            testNAME = [id_test_name,num2str(num_of_motif)];
            TSNAMEFIX=testNAME;
            %% Temporal position for each motif
            startInj=30;
            Step= floor( (RWlength-60)/(motif_instances*num_of_motif));
            startTime =zeros(1,motif_instances*num_of_motif);
            starterTime(1) = startInj ;
            LabelMotif = [];
            MotifsStartRW=[];
            MotifsEndRW=[];
            for i =1: num_of_motif
                LabelMotif=[LabelMotif,ones(1,motif_instances)*i];
                MotifsStartRW=[MotifsStartRW,1];
                MotifsEndRW=[MotifsEndRW,0];
            end
            LabelMotif = LabelMotif( randperm(length(LabelMotif))) ;
            pStep=0;
            for i=1:motif_instances*num_of_motif
                %         motifclmn = MotifsSections{LabelMotif(i)}.cols;
                starterTime (i)= randi([startInj+pStep,startInj+pStep+Step-motifclmn],1,1);
                if mod (starterTime(i), 2) == 0
                    starterTime(i)=starterTime(i)-1;
                end
                pStep=pStep+Step;
            end
            %         %% Injection  and scaling of Random Walks
            %         for orgID =1:30
            
            originalTSID=originalTSIDArray(orgID)
            %% load  the features and the data
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
                if(MotifsSections{MotifId}.cols~=motifclmn)
                    'look at this'
                end
            end
            
            
            for rwscale = 1 : size(random_walk_scale,2)
                for i =1 : random_walk_instance
                    testNAME = [TSNAMEFIX,'_',num2str(originalTSID),'_',num2str(motif_instances),'_instance_',num2str(i)];
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
                    idxMotifID=ones(num_of_motif,1)';%NEW
                    StartPosition_RW=[];
%                     CountInjectedInstances=ones(1,num_of_motif);
                    CountInjectedInstances=ones(1,NUM_VARIATE);
                    RW_Start=[];
                    RW_End=[];
                    newEnd=[];
                    for motifInstance = 1: motif_instances*num_of_motif
                        MotifID=LabelMotif(motifInstance);
                        length_index = length_percentage(MotifID,idxMotifID(MotifID));
                        idxMotifID(MotifID)=idxMotifID(MotifID)+1;
                        if(length_index == 0)
                            length_index = size(length_percentage, 2);
                        end
                        M1 = imresize( MotifsSections{MotifID}.data,[size( MotifsSections{MotifID}.data,1), size( MotifsSections{MotifID}.data,2)*length_index]);%length_percentage(length_index)]);
                        scalingTime =size(M1,2);
                        listvariates=MotifsSections{MotifID}.depd((MotifsSections{MotifID}.depd(:,1)>0),1);
%                         if (CountInjectedInstances(1,MotifID)==1)
%                             StartPosition_RW{MotifID}=1;
%                             RW_Start{MotifID}{CountInjectedInstances(1,MotifID)} = Motif1RW(listvariates,StartPosition_RW{MotifID});
%                         else
%                             RW_Start{MotifID}{CountInjectedInstances(1,MotifID)} = Motif1RW(listvariates,StartPosition_RW{MotifID});
%                         end
%                         RW_End{MotifID}{CountInjectedInstances(1,MotifID)}  =  Motif1RW(listvariates,starterTime(motifInstance));
%                         if (CountInjectedInstances(1,MotifID)==motif_instances)
%                             RW_End{MotifID}{CountInjectedInstances(1,MotifID)}   = Motif1RW(listvariates,TotalRWlength-scalingTime+1);
%                         end
%                         if (CountInjectedInstances(1,MotifID)<=motif_instances)
%                             newEnd{MotifID}{CountInjectedInstances(1,MotifID)}= M1(listvariates,1);
%                         end
                        NewRW=[];
                        for eachvaraitemotif= 1:size(listvariates,1)
                            if (CountInjectedInstances(1,listvariates(eachvaraitemotif))==1)
                                StartPosition_RW{listvariates(eachvaraitemotif)}=1;
                                RW_Start{listvariates(eachvaraitemotif)}{CountInjectedInstances(1,listvariates(eachvaraitemotif))} = Motif1RW(listvariates(eachvaraitemotif),StartPosition_RW{listvariates(eachvaraitemotif)});
                            else
                                RW_Start{listvariates(eachvaraitemotif)}{CountInjectedInstances(1,listvariates(eachvaraitemotif))} = Motif1RW(listvariates(eachvaraitemotif),StartPosition_RW{listvariates(eachvaraitemotif)});
                            end
                            RW_End{listvariates(eachvaraitemotif)}{CountInjectedInstances(1,listvariates(eachvaraitemotif))}  =  Motif1RW(listvariates(eachvaraitemotif),starterTime(motifInstance));
%                             if (CountInjectedInstances(1,MotifID)==motif_instances)
%                                RW_End{MotifID}{CountInjectedInstances(1,MotifID)}   = Motif1RW(listvariates,TotalRWlength-scalingTime+1);
%                             end
                            newEnd{listvariates(eachvaraitemotif)}{CountInjectedInstances(1,listvariates(eachvaraitemotif))}= M1(listvariates(eachvaraitemotif),1);
                            
                            lengthofthispart= starterTime(motifInstance)-StartPosition_RW{listvariates(eachvaraitemotif)}+1;
                            RW_Bisection=zeros(1,lengthofthispart);
                            RW_Bisection(1,1)= RW_Start{listvariates(eachvaraitemotif)}{CountInjectedInstances(1,listvariates(eachvaraitemotif))};%(eachvaraitemotif);
                            RW_M_Bisection=zeros(1,lengthofthispart);
                            RW_M_Bisection(1,1)= RW_Start{listvariates(eachvaraitemotif)}{CountInjectedInstances(1,listvariates(eachvaraitemotif))};%(eachvaraitemotif);
                            Step_RWBisection= (RW_End{listvariates(eachvaraitemotif)}{CountInjectedInstances(1,listvariates(eachvaraitemotif))}-RW_Start{listvariates(eachvaraitemotif)}{CountInjectedInstances(1,listvariates(eachvaraitemotif))})/lengthofthispart;
                            Step_RW_M_Bisection= (newEnd{listvariates(eachvaraitemotif)}{CountInjectedInstances(1,listvariates(eachvaraitemotif))} - RW_Start{listvariates(eachvaraitemotif)}{CountInjectedInstances(1,listvariates(eachvaraitemotif))})/lengthofthispart;
                            for ti= 2: lengthofthispart
                                RW_Bisection(1,ti)=RW_Bisection(1,ti-1)+Step_RWBisection;
                                RW_M_Bisection(1,ti)=RW_M_Bisection(1,ti-1)+Step_RW_M_Bisection;
                            end
                            DistRW = Motif1RW(listvariates(eachvaraitemotif),StartPosition_RW{listvariates(eachvaraitemotif)}:starterTime(motifInstance)) - RW_Bisection;
                            %NewRW =[NewRW; (DistRW +RW_M_Bisection)];
                            
%                             lengthofthispart= starterTime(motifInstance)-StartPosition_RW{MotifID}+1;
%                             RW_Bisection=zeros(1,lengthofthispart);
%                             RW_Bisection(1,1)= RW_Start{MotifID}{CountInjectedInstances(1,MotifID)}(eachvaraitemotif);
%                             RW_M_Bisection=zeros(1,lengthofthispart);
%                             RW_M_Bisection(1,1)= RW_Start{MotifID}{CountInjectedInstances(1,MotifID)}(eachvaraitemotif);
%                             Step_RWBisection= (RW_End{MotifID}{CountInjectedInstances(1,MotifID)}(eachvaraitemotif)-RW_Start{MotifID}{CountInjectedInstances(1,MotifID)}(eachvaraitemotif))/lengthofthispart;
%                             Step_RW_M_Bisection= (newEnd{MotifID}{CountInjectedInstances(1,MotifID)}(eachvaraitemotif) - RW_Start{MotifID}{CountInjectedInstances(1,MotifID)}(eachvaraitemotif))/lengthofthispart;
%                             for ti= 2: lengthofthispart
%                                 RW_Bisection(1,ti)=RW_Bisection(1,ti-1)+Step_RWBisection;
%                                 RW_M_Bisection(1,ti)=RW_M_Bisection(1,ti-1)+Step_RW_M_Bisection;
%                             end
%                             DistRW = Motif1RW(listvariates(eachvaraitemotif),StartPosition_RW{MotifID}:starterTime(motifInstance)) - RW_Bisection;
%                             NewRW =[NewRW; (DistRW +RW_M_Bisection)];

                        %% adapted Random Walk to the motif start
                        Motif1RW(listvariates(eachvaraitemotif),StartPosition_RW{listvariates(eachvaraitemotif)}:starterTime(motifInstance))=   (DistRW +RW_M_Bisection);

                            StartPosition_RW{listvariates(eachvaraitemotif)}=starterTime(motifInstance)+scalingTime-1;
                            CountInjectedInstances(1,listvariates(eachvaraitemotif))=CountInjectedInstances(1,listvariates(eachvaraitemotif))+1;
                        end
                        %% adapted Random Walk to the motif start
%                         Motif1RW(listvariates,StartPosition_RW{MotifID}:starterTime(motifInstance))=   NewRW;
                        %% adapt the RW to the motif end
                        for eachvaraitemotif= 1:size(listvariates,1)
                            d= M1(listvariates(eachvaraitemotif),end)-Motif1RW(listvariates(eachvaraitemotif),starterTime(motifInstance)+scalingTime-1);
                            Motif1RW(listvariates(eachvaraitemotif),starterTime(motifInstance)+scalingTime-1 : end) =...
                            Motif1RW(listvariates(eachvaraitemotif),starterTime(motifInstance)+scalingTime-1 : end)+d;
                        end
                        %% motif injection
                        Motif1RW(listvariates,starterTime(motifInstance):starterTime(motifInstance)+scalingTime-1)=M1(listvariates,:);
%                         StartPosition_RW{MotifID}=starterTime(motifInstance)+scalingTime-1;
%                         CountInjectedInstances(1,MotifID)=CountInjectedInstances(1,MotifID)+1;
                        %                         RW_Start{MotifID}{CountInjectedInstances(1,MotifID)} = M1(listvariates,end);
                                                
                        %% Record motif instances injected position
                        FeatPositions(motifInstance,:)=[MotifID,motifInstance,starterTime(motifInstance),starterTime(motifInstance)+scalingTime-1];
                        EachInstanceDependency=[EachInstanceDependency, MotifsSections{MotifID}.depd ];
                    end
                    if(exist([DestDataPath,'\IndexEmbeddedFeatures\'],'dir')==0)
                        mkdir([DestDataPath,'\IndexEmbeddedFeatures\']);
                    end
                    csvwrite([DestDataPath,'\',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],Motif1RW);
                    csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','FeaturePosition_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],FeatPositions);
                    csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','dpscale_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],EachInstanceDependency);
                    csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','Parameters_',testNAME,'_',num2str(random_walk_scale(rwscale)),'.csv'],[originalTSID;num_of_motif;motif_instances;i;random_walk_scale(rwscale)]);
                end
            end
        end
    end
end