clear;
clc;
DS_List ={'Energy','Mocap','BirdSong'};
for DSIdx =2:2
    Ds_Name= DS_List{DSIdx};%'BirdSong';%'Energy';%'Mocap';%
%      path=['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\Coherent Shift Variate 1M ',Ds_Name,'\instancesmultisize\'];%Coherent Shift Variate 1M Energy\instancesmultisize\'];%'\Mocap M 1 2 3\'];%'\numInstances_5_15\'];
    path=['F:\syntethic motifs  good results\',Ds_Name,'\10_Motifs_MM_rebuttal\'];%'\numInstances_5_15\'];%'\samesize10inst\'];%random shift variates 1M ',Ds_Name ,'\instancesmultisize\']%
    %'\Coherent Shift Variate 1M ',Ds_Name,'\instancesmultisize\'];%,Ds_Name,' M 1 2 3\'];
    %'F:\syntethic motifs  good results\Mocap\Coherent Shift Variate 1M Mocap\instancessamesize\';%Energy\Energy M 1 2 3\';%BirdSong\
    %\10_Motifs_MM_rebuttal\';
    %'F:\syntethic motifs  good results\Energy\numInstances_5_15\';
    %'F:\syntethic motifs  good results\Mocap\random shift variates 1M Mocap\samesize\';
    %'F:\syntethic motifs  good results\BirdSong\numInstances_5_15\';%\Energy\RandomVariate\Multisize\';%Mocap\RandomVariate\';%BirdSong\';%Mocap\';%BSONG\';
    % path='D:\Motif_Results\Datasets\SynteticDataset\Mocap\numInstances_5_15\';
    kindofinj='data\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';

      instancesInjecte = [10,5,15];
%       for fivefifteen=2:3
%      BaseName=['Motif1numInst_', num2str(instancesInjecte(fivefifteen))];%
    BaseName='Motif10';%'MV_Sync_Motif1';%'MV_Sync_Motif1';%
    %1numInst_10';%'Motif1';%
    %PathMP=[path,'\MStamp\'];
    % pippo = [23,35,86,111];%[1,3,6,7];%ENERGY[64,70,80,147];%Bsong[24,35,85,127];Mocap
    dataLocation='data\';
    load([path,'data\FeaturesToInject\allTSid.mat']);
    Name_OriginalSeries = AllTS;
    
    lenght = 58; % Energy dataset configuration
    if strcmp(Ds_Name,'BirdSong')==1
        lenght = 32; % BirdSong configuration
    end
    
    Num_SyntSeries=10; % num of instances of one motif
    PossibleMotifInjected = [1,2,3,10];
    for idmotInj =4: 4%size(PossibleMotifInjected,2)-1
        motifinjected = num2str(PossibleMotifInjected(idmotInj));
        %  Name_OriginalSeries = [1,3,6,7];%ENERGY[23,35,86,111];%[64,70,80,147];%[85,35,127,24]; % name of the original  series from with we  got the  motif instances to inject
        percent=[0; 0.1;0.25;0.5;0.75;1;2];%;
        for percentid=1:1%7%size(percent,1)
            percentagerandomwalk=percent(percentid);
            % percentagerandomwalk=0.75;%1;%0; %0.1;%0.5;%
            %strategy=[1,2,3,4,5,6];
            DepO =2;
            DepT =2;
            %       for strID =3:3%1:size(strategy,2)
            %           StrategyClustering= strategy(strID);%3;%2;%
            
            for pip=1:30%size(Name_OriginalSeries,2)
                for NAME = 1:Num_SyntSeries
                    
%                     TEST=[BaseName,motifinjected,'_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME),'_',num2str(percentagerandomwalk)];
                    TEST=[BaseName,'_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME),'_',num2str(percentagerandomwalk)]
                    %old
%                         TEST=[BaseName,'_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME)];
                    
                    FeaturesRM ='MStamp\';%'RMT';%'RME';%
                    testname=TEST;
                    
                    len=['Lenght_',num2str(lenght)];
                    
                    try
                        load([path,FeaturesRM,TEST,'\Motif_output_',TEST,len,'.mat']);
                        Feature_Pos_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\FeaturePosition_',testname,'.csv']);%\',testname,'
                        Dependency_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\dpscale_',testname,'.csv']);%\',testname,'
                        [fi_n,fi_m] = size(Feature_Pos_Injected);
                        
                        [n,m]= size(MotifBag_mstamp);
                        
                        ListofInstances=[];
                        for MID = 1:m
                            
                            motifsStart  = MotifBag_mstamp{MID}.startIdx;
                            
                            if size(motifsStart,1)>0
                                for instance =1: size(motifsStart,1)
                                    MotifInstanceIdentification=[MID,instance,motifsStart(instance),motifsStart(instance)+lenght];
                                    motifvariate = MotifBag_mstamp{MID}.depd{instance};
                                    TimeScore =0;
                                    Varaitescore =-1;
                                    InjectedIDentifcation=[0,0,0,0,TimeScore,Varaitescore];
                                    %         IdentifiedTimePeriod=motifsStart(instance): motifsStart(instance)+lenght-1;
                                    
                                    for injectedID =1:fi_n
                                        %           InjectedTimePeriod = Position_F_Injected(injectedID,2):Position_F_Injected(injectedID,3);
                                        DI=Dependency_Injected(Dependency_Injected(:,Feature_Pos_Injected(injectedID,2))>0,Feature_Pos_Injected(injectedID,2));
                                        %           InjectedDependency = Dependency_Injected(injectedID,1);
                                        TimeOverlapping    = computeTimeOverlapMStamp(motifsStart(instance),motifsStart(instance)+lenght,Feature_Pos_Injected(injectedID,3),Feature_Pos_Injected(injectedID,4));
%                                         if TimeOverlapping==1
%                                             MotifInstanceIdentification(size(MotifInstanceIdentification,1),3)= Feature_Pos_Injected(injectedID,3);
%                                             MotifInstanceIdentification(size(MotifInstanceIdentification,1),4)=Feature_Pos_Injected(injectedID,4);
%                                         else
%                                             MotifInstanceIdentification(size(MotifInstanceIdentification,1),4)=Feature_Pos_Injected(injectedID,4)+1;
%                                         end
                                        variateOverlapping = size(intersect(DI,motifvariate),1)/size(DI,1);%union(DI,motifvariate),1);%computeVariateScore(motifvariate,DI);
                                        if(TimeOverlapping >0 & variateOverlapping >0)
                                            % condition to modify the score
                                            if (TimeOverlapping *variateOverlapping > TimeScore*Varaitescore)
                                                TimeScore=TimeOverlapping;
                                                Varaitescore= variateOverlapping;
                                                InjectedIDentifcation=[Feature_Pos_Injected(injectedID,1),Feature_Pos_Injected(injectedID,2),Feature_Pos_Injected(injectedID,3),Feature_Pos_Injected(injectedID,4),TimeScore,Varaitescore];
                                            end
                                        end
                                    end
                                    ListofInstances=[ListofInstances;[MotifInstanceIdentification,InjectedIDentifcation]];
                                end
                            else
                                'Non dovrei essere qui'
                            end
                        end
                        if(exist(strcat(path,FeaturesRM,'\Accuracy\'),'dir')==0)
                            mkdir(strcat(path,FeaturesRM,'\Accuracy\'));
                        end
                        col_header={'Class','ID','Start','End','ClassInj','IDinj','StartInj','EndInj','Time_Score','dep_Overlapping'};
                        
                        %                 try
                        csvwrite([path,'',FeaturesRM,'\Accuracy\',testname,'.csv'],ListofInstances);
                        %                     xlswrite([path,'',FeaturesRM,'\Accuracy\',testname,'.csv'],ListofInstances,len,'A2');
                        %                     xlswrite([path,'',FeaturesRM,'\Accuracy\',testname,'.csv'],col_header,len,'A1');%'_MStamp',
                    catch
                        'problem at'
                        TEST
                    end
                end
                   end
            end
%         end
    end
end