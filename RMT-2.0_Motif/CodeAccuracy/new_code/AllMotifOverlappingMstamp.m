clear;
clc;

path='D:\Motif_Results\Datasets\SynteticDataset\';
kindofinj='data\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
FeaturesRM ='Mstamp';%'RMT';%'RME';%
PathMP='D:\Motif_Results\Datasets\SynteticDataset\MStamp\';
for NAME =1:30%46:57%34:45
testname=['Motif2_35_instance_',num2str(NAME)]%'Mocap_test11';
lenght=58;%29;%
len=['Lenght_',num2str(lenght)];


load([PathMP,testname,'\Motif_output_',testname,len,'.mat']);
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
        DI=Dependency_Injected(Dependency_Injected(:,Feature_Pos_Injected(injectedID,1))>0,Feature_Pos_Injected(injectedID,1));        
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
