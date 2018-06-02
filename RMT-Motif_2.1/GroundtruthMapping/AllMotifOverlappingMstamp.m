clear;
clc;

path='D:\Motif_Results\Datasets\SynteticDataset\BSONG\';
kindofinj='data\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';

%PathMP=[path,'\MStamp\'];
pippo = [64,70,80,147];%[24,35,85,127];
dataLocation='data\';

Num_SyntSeries=10; % num of instances of one motif
PossibleMotifInjected = [1,2,3];
for idmotInj =1: size(PossibleMotifInjected,2)
    motifinjected = num2str(PossibleMotifInjected(idmotInj));
    Name_OriginalSeries = [64,70,80,147];%[85,35,127,24]; % name of the original  series from with we  got the  motif instances to inject
    percent=[0; 0.1;0.5;0.75;1];
    for percentid=1:1%size(percent,1)
        percentagerandomwalk=percent(percentid);
        % percentagerandomwalk=0.75;%1;%0; %0.1;%0.5;%
        strategy=[1,2,3,4,5,6];
        DepO =2;
        DepT =2;
        for strID =3:3%1:size(strategy,2)
            StrategyClustering= strategy(strID);%3;%2;%
            
            for pip=1:size(Name_OriginalSeries,2)
                for NAME = 1:Num_SyntSeries
                    
                    TEST=['Motif',motifinjected,'_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME),'_',num2str(percentagerandomwalk)];
                    FeaturesRM ='MStampB\';%'RMT';%'RME';%
                    testname=TEST;
                    lenght=32;%29;%
                    len=['Lenght_',num2str(lenght)];
                    
                    
                    load([path,FeaturesRM,TEST,'\Motif_output_',TEST,len,'.mat']);
                    Feature_Pos_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\FeaturePosition_',testname,'.csv']);%\',testname,'
                    Dependency_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\dpscale_',testname,'.csv']);%\',testname,'
                    [fi_n,fi_m] = size(Feature_Pos_Injected);
                    
                    [n,m]= size(MotifBag_mstamp);
                    
                    ListofInstances=[];
                    for MID = 1:m
                        
                        motifsStart  = MotifBag_mstamp{MID}.startIdx;
                        motifvariate = MotifBag_mstamp{MID}.depd{1};
                        for instance =1: size(motifsStart,1)
                            MotifInstanceIdentification=[MID,instance,motifsStart(instance),motifsStart(instance)+lenght-1];
                            TimeScore =0;
                            Varaitescore =-1;
                            InjectedIDentifcation=[0,0,0,0,TimeScore,Varaitescore];
                            %         IdentifiedTimePeriod=motifsStart(instance): motifsStart(instance)+lenght-1;
                            
                            for injectedID =1:fi_n
                                %           InjectedTimePeriod = Position_F_Injected(injectedID,2):Position_F_Injected(injectedID,3);
                                DI=Dependency_Injected(Dependency_Injected(:,Feature_Pos_Injected(injectedID,2))>0,Feature_Pos_Injected(injectedID,2));
                                %           InjectedDependency = Dependency_Injected(injectedID,1);
                                TimeOverlapping    = computeTimeOverlap(motifsStart(instance),motifsStart(instance)+lenght-1,Feature_Pos_Injected(injectedID,3),Feature_Pos_Injected(injectedID,4));
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
                    end
                    if(exist(strcat(path,FeaturesRM,'\Accuracy\'),'dir')==0)
                        mkdir(strcat(path,FeaturesRM,'\Accuracy\'));
                    end
                    col_header={'Class','ID','Start','End','ClassInj','IDinj','StartInj','EndInj','Time_Score','dep_Overlapping'};
                    xlswrite([path,'',FeaturesRM,'\Accuracy\',testname,'.csv'],ListofInstances,len,'A2');
                    xlswrite([path,'',FeaturesRM,'\Accuracy\',testname,'.csv'],col_header,len,'A1');%'_MStamp',
                end
            end
        end
    end
end