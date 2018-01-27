%% Accuracy best timeoverlapping
% clc; clear;

function BP_allfeatures(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,DepO,DepT)
%% Analize Results
% path='D:\Motif_Results\Datasets\SynteticDataset\';
% kindofinj='data\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
% TEST = 'test1';
% 
% FeaturesRM ='RMT';%'RME';%
% kindofCluster='Cluster_AKmeans';%'ClusterMatlab';%'ClusterKmedoids';%
% measure='Descriptor';
% ClusterAlg = 'ClusterMatlab';
% subfolderClusterLabel='Clusterlabel\ClusterLabel_';
% DepO=num2str(2);
% DepT=num2str(2);

%% data injected and groundtruth
data = csvread([path,kindofinj,TEST,'.csv']);%csvread([path,kindofinj,'Embeddedfeature.csv']);
Position_F_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\',TEST,'\FeaturePosition_',TEST,'.csv']);
Feature_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\',TEST,'\FeaturesEmbedded_',TEST,'.csv']);
Dependency_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\',TEST,'\dpscale_',TEST,'.csv']);

%% read the clusters to check the motifs.
featurespath=[path,'Features_',FeaturesRM,'\',TEST,'\Distances',measure,'\',kindofCluster,'\'];%AP_VA\Cluster_AKmeans\'];
%load([featurespath,'datacluster_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.mat'])
% load([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',ClusterAlg,'\datacluster_1_DepO_',DepO,'_DepT_',DepT,'.mat']);

Dependencypruned = csvread([path,'Features_',FeaturesRM,'\',TEST,'\Distances',measure,'\DepdScale_IM_',TEST,'_DepO_',DepO,'_TimeO_',DepT,'.csv']);
load([path,'Features_',FeaturesRM,'\',TEST,'\feature_',TEST,'.mat']);%csvread([featurespath,'\Features_IM_',TEST,'_OT_',DepT,'_OD_',DepO,'.csv']);%,'_DepO_',DepO,'_DepT_',DepT,'.csv']);

indexfeatureGroup = (frame1(6,:)==str2num(DepT) & frame1(5,:)==str2num(DepO));
Featurepruned=frame1(:,indexfeatureGroup);

Clusterpruned = csvread([featurespath,'\Cluster_IM_',TEST,'_DepO_',DepO,'_TimeO_',DepT,'.csv']);%,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
Centroidpruned = csvread([featurespath,'\Centroids_IM_',TEST,'_DepO_',DepO,'_TimeO_',DepT,'.csv']);%,'_DepO_',DepO,'_DepT_',DepT,'.csv']);

%% Check to with cluster each feature refers
Interv_Features_Cluster=[];
clusterLabel = unique(Clusterpruned);
nCluster     = length(clusterLabel);
FeatureSortedbyCluster=[];
DescriptorSortedbyCluster=[];
for i=1: nCluster
    F = Featurepruned(:, Clusterpruned == clusterLabel(i));
    D = Dependencypruned(:, Clusterpruned == clusterLabel(i));
    timescopeF= F(4,:)*3;
    for iii=1: size(F,2)
        Interv_Features_Cluster=[Interv_Features_Cluster;[clusterLabel(i),round(F(2,iii)-timescopeF(iii)) , round(F(2,iii)+timescopeF(iii))]];
    end 
    FeatureSortedbyCluster=[FeatureSortedbyCluster,F];
    DescriptorSortedbyCluster=[DescriptorSortedbyCluster,D];
    
end


%% Sort the Feature on the index of  the name of the specific feature.
%   Position_F_Injected(:,2)=[];
% [q,I] = sort(Position_F_Injected(:,2));
% [q1, I_IntervFeat]= sort(ItervalFeatures(:,2));

% Position_F_Injected = Position_F_Injected(I,:);
% Interv_Features_Cluster=Interv_Features_Cluster(I_IntervFeat,:);



FeatureClassCount=[];
% ActualName=[];
% NotFoundPosition=[0,-1,-1];
for i=1: size(Interv_Features_Cluster,1)
    IdentifiedTimePeriod=Interv_Features_Cluster(i,2): Interv_Features_Cluster(i,3);
    IdentifiedTimePeriod = IdentifiedTimePeriod(IdentifiedTimePeriod>0 & IdentifiedTimePeriod<=size(data,2));
    
    MotifInstanceIdentification=[Interv_Features_Cluster(i,1),i,IdentifiedTimePeriod(1),IdentifiedTimePeriod(end)];
    
%     miss=0;
%     found=0;
%     MAXOverlapping=-1;
%     MAXVariateOverSimilarity=-1;
%     MAXVaraiteOverSim_MaximumDiv=-1;
%     MAXOverlappingIDX=-1;
%     
        TimeScore =0; 
        Varaitescore =-1; 
        InjectedIDentifcation=[0,0,0,0,TimeScore,Varaitescore];

    for j=1:size(Position_F_Injected,1)
%         InjectedTimePeriod = Position_F_Injected(j,2):Position_F_Injected(j,3);
%         InjectedTimePeriod =InjectedTimePeriod(InjectedTimePeriod>0 & InjectedTimePeriod<=size(data,2));        
%         newOverlapping= intersect(InjectedTimePeriod,IdentifiedTimePeriod);
         DI=Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,1))>0,Position_F_Injected(j,1));
         DC=DescriptorSortedbyCluster(DescriptorSortedbyCluster(:,i)>0,i);
         TimeOverlapping=computeTimeOverlap(IdentifiedTimePeriod(1),IdentifiedTimePeriod(end),Position_F_Injected(j,3),Position_F_Injected(j,4));
         variateOverlapping = size(intersect(DI,DC),1)/size(union(DI,DC),1);
         if(TimeOverlapping >0 & variateOverlapping >0)
              % condition to modify the score
              if (TimeOverlapping *variateOverlapping > TimeScore*Varaitescore)
                  TimeScore=TimeOverlapping;
                  Varaitescore= variateOverlapping;
                InjectedIDentifcation=[Position_F_Injected(j,1),Position_F_Injected(j,2),Position_F_Injected(j,3),Position_F_Injected(j,4),TimeScore,Varaitescore];
              end
          end 

%         if(size(newOverlapping,2) & (MAXOverlapping == -1))
%             MAXOverlapping=newOverlapping;
%             MAXOverlappingIDX=j;
%  
%             VariateOverSimilarity= size(intersect(DI,DC),1)/size(union(DI,DC),1);
% %             MAXVaraiteOverSim_MaximumDiv    = size(intersect(...
% %                 Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,1))>0,Position_F_Injected(j,1)),...
% %                 Dependencypruned(Dependencypruned(:,i)>0,i)),1)/...
% %                 size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,1))>0,Position_F_Injected(j,1)),1);
% %             
% %             VariateOverSimilarity= size(intersect(...
% %                 Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),...
% %                 Dependencypruned(Dependencypruned(:,i)>0,i)),1)/...
% %                 max(size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),1),...
% %                 size(Dependencypruned(Dependencypruned(:,i)>0,i),1)                                                       );
%              MAXVariateOverSimilarity = VariateOverSimilarity;
% %             %% ActualName= Position_F_Injected(j,:);
%         elseif((size(newOverlapping,2) >= size(MAXOverlapping,2)))
%             VariateOverSimilarity= size(intersect(DI,DC),1)/size(union(DI,DC),1);
% %                 VariateOverSimilarity    =  size(intersect(...
% %                 Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),...
% %                 Dependencypruned(Dependencypruned(:,i)>0,i)),1)/...
% %                 max(size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),1),...
% %                 size(Dependencypruned(Dependencypruned(:,i)>0,i),1)                                                       );
%             if(VariateOverSimilarity >= MAXVariateOverSimilarity)
%                 MAXOverlapping=newOverlapping;
%                 MAXOverlappingIDX=j;
%                 MAXVariateOverSimilarity = VariateOverSimilarity;
%                 
% %                 MAXVaraiteOverSim_MaximumDiv= size(intersect(...
% %                     Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),...
% %                     Dependencypruned(Dependencypruned(:,i)>0,i)),1)/...
% %                     size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),1);
%                 
%             end
%         end
    end
FeatureClassCount=[FeatureClassCount;[MotifInstanceIdentification,InjectedIDentifcation]];    
%     NearInjectedFeaturePeriod= Position_F_Injected(MAXOverlappingIDX,3): Position_F_Injected(MAXOverlappingIDX,4);
%     CandidateFeaturePeriod= IdentifiedTimePeriod;%ItervalFeatures(MAXOverlappingIDX,1): ItervalFeatures(MAXOverlappingIDX,2);
%     Overlpping = intersect(CandidateFeaturePeriod,NearInjectedFeaturePeriod);
%     if(MAXOverlappingIDX~=-1)%if(size(MAXOverlapping,2)/max(size(InjectedTimePeriod,2),size(CandidateFeaturePeriod,2))> 0)
%         ActualName= Position_F_Injected(MAXOverlappingIDX,:);
%         found=found+1;
%     else
%         miss= miss+1;
%         ActualName=NotFoundPosition;
%     end    
% 
% 
%     ActualName= [
%                  Interv_Features_Cluster(i,1),...
%                  i,...
%                  Interv_Features_Cluster(i,2),...
%                  Interv_Features_Cluster(i,3),...
%                  ActualName,...
%                  MAXVariateOverSimilarity,...
%                  found];
%     FeatureClassCount=[FeatureClassCount;ActualName];
%     
%                  MAXVaraiteOverSim_MaximumDiv,...
end
if(exist(strcat(path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\'),'dir')==0)
    mkdir(strcat(path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\'));
end
col_header={'Class','ID','Start','End','ClassInj','IDinj','StartInj','EndInj','Time_Score','dep_Overlapping'}; 
xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\','BP_',TEST,'_AllFeatureFound_DepO_',DepO,'_DepT_',DepT,'.csv'],FeatureClassCount,'BP_al','A2');
xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\','BP_',TEST,'_AllFeatureFound_DepO_',DepO,'_DepT_',DepT,'.csv'],col_header,'BP_all','A1');
% csvwrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\','BP_all_',TEST,'_AllFeatureFound_DepO_',DepO,'_DepT_',DepT,'.csv'],FeatureClassCount);


