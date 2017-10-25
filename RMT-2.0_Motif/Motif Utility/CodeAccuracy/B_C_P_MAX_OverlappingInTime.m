%% Accuracy best timeoverlapping
clc; clear;
%% Analize Results
path='D:\Motif_Results\FeatureSyntDataset\';
kindofinj='FlatTS_MultiFeatureDiffClusters\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
TEST = 'FeatureTest24';
kindofCluster='Cluster_Fixed\';
measure='Descriptor';
ClusterAlg = 'ClusterMatlab';
subfolderClusterLabel='Clusterlabel\ClusterLabel_';
TS_name=num2str(1);
DepO=num2str(2);
DepT=num2str(2);
%% data injected and groundtruth
data = csvread([path,kindofinj,'Embeddedfeature_',TEST,'.csv']);%'Embeddedfeature.csv']);
% Position_F_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','FeaturePosition.csv']);
% Feature_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','FeaturesEmbedded.csv']);
% Dependency_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','dpscale.csv']);
Position_F_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','FeaturePosition_',TEST,'.csv']);
Feature_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','FeaturesEmbedded_',TEST,'.csv']);
Dependency_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','dpscale_',TEST,'.csv']);
%% read the clusters to check the motifs.
% load features
load([path,kindofinj,'Features\',TEST,'\feature_',TS_name,'.mat']);
indexfeatureGroup = (frame1(6,:)==str2num(DepT) & frame1(5,:)==str2num(DepO));
Featurepruned=frame1(:,indexfeatureGroup);
% csvread([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',...
%     ClusterAlg,'\PrunedFeatures_IM_1_DepO_',DepO,'_DepT_',DepT,'.csv']);

Dependencypruned= csvread([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',...%,kindofCluster,measure,'\afterPruning\',ClusterAlg,
    'DepdScale_IM_',TS_name,'_DepO_',DepO,'_TimeO_',DepT,'.csv']);%DepdScale_IM_1_DepO_2_TimeO_2
Clusterpruned = csvread([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\',...%'\afterPruning\',...
    ClusterAlg,'\Cluster_IM_',TS_name,'_DepO_',DepO,'_TimeO_',DepT,'.csv']);
Centroidpruned = csvread([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\',...%'\afterPruning\',...
    ClusterAlg,'\Centroids_IM_',TS_name,'_DepO_',DepO,'_TimeO_',DepT,'.csv']);
timescope= Featurepruned(4,:)*3;
ItervalFeatures=[];
for iii=1: size(Featurepruned,2)
    ItervalFeatures=[ItervalFeatures;[round(Featurepruned(2,iii)-timescope(iii)) , round(Featurepruned(2,iii)+timescope(iii))]];
end
%% To identify a feature at list 50% of th feature should be involved in the feature identified
%% Section to add the cluster of reference to a feature
Interv_Features_Cluster=[];
clusterLabel = unique(Clusterpruned);
nCluster     = length(clusterLabel);
FeatureSortedbyCluster=[];
DependencySortedbyCluster=[];
for i=1: nCluster
    F = Featurepruned(:, Clusterpruned == clusterLabel(i));
    D = Dependencypruned(:, Clusterpruned == clusterLabel(i));
    timescopeF= F(4,:)*3;
    for iii=1: size(F,2)
        Interv_Features_Cluster=[Interv_Features_Cluster;[round(F(2,iii)-timescopeF(iii)) , round(F(2,iii)+timescopeF(iii))],clusterLabel(i)];
    end 
    FeatureSortedbyCluster=[FeatureSortedbyCluster,F];
    DependencySortedbyCluster=[DependencySortedbyCluster,D];
end
ItervalFeatures=Interv_Features_Cluster;
%% Sort the Feature on the index of  the name of the specific feature.
[q,I] = sort(Position_F_Injected(:,2));

Position_F_Injected = Position_F_Injected(I,:);
%  Feature_Injected = Feature_Injected(:,I);
%  Dependency_Injected=Dependency_Injected(:,I);

[q1, I_IntervFeat]= sort(ItervalFeatures(:,1));

ItervalFeatures=ItervalFeatures(I_IntervFeat,:);
Dependencypruned=DependencySortedbyCluster(:,I_IntervFeat);
Featurepruned= FeatureSortedbyCluster(:,I_IntervFeat);


FeatureClassCount=[];
NotFoundPosition=[0,-1,-1,-1];
for i=1:size(Position_F_Injected,1)
FoundedFeatures= [];
    found=0;
    miss=0;
    ActualName = Position_F_Injected(i,:);
    
    InjectedTimePeriod= Position_F_Injected(i,3):Position_F_Injected(i,4);
    MAXOverlapping=-1;
    MAXVariateOverlapping=-1;
    MAXOverlappingIDX=-1;
    for j=1:size(ItervalFeatures,1);
        IdentifiedTimePeriod=ItervalFeatures(j,1): ItervalFeatures(j,2);
        newOverlapping= intersect(InjectedTimePeriod,IdentifiedTimePeriod);
        if((size(newOverlapping,2) > size(MAXOverlapping,2)) | (MAXOverlapping == -1))
                MAXOverlapping=newOverlapping;
                MAXOverlappingIDX=j;
%            if(size(MAXOverlapping,2))==(size(newOverlapping,2))
%              VariateOverlapping = intersect(Dependency_Injected(:,Position_F_Injected(i,2)),Dependencypruned(:,j))
%             if(size(VariateOverlapping>0,1)>size(MAXVariateOverlapping,1) | (MAXVariateOverlapping == -1))
%                 MAXOverlapping=newOverlapping;
%                 MAXVariateOverlapping=VariateOverlapping;
%                 MAXOverlappingIDX=j;
%             end
        end
    end
    CandidateFeaturePeriod= ItervalFeatures(MAXOverlappingIDX,1): ItervalFeatures(MAXOverlappingIDX,2);
    
    if(size(MAXOverlapping,2)/max(size(InjectedTimePeriod,2),size(CandidateFeaturePeriod,2))> 0)
        found=found+1;
        FoundedFeatures= [ItervalFeatures(MAXOverlappingIDX,3),...   % add the cluster label
                          MAXOverlappingIDX,...
                          ItervalFeatures(MAXOverlappingIDX,1),...
                          ItervalFeatures(MAXOverlappingIDX,2)];
    else
        miss= miss+1;
        FoundedFeatures=NotFoundPosition;
    end    

    ActualName= [ActualName,...
                 FoundedFeatures,...
                 found,miss];
    FeatureClassCount=[FeatureClassCount;ActualName];
end

csvwrite([path,kindofinj,'Accuracy\MAXOVERLAPPING\',subfolderClusterLabel,'BP_',TEST,'_MAXOverlappingFeaturesFounded_DepO',DepO,'_DepT_',DepT,'.csv'],FeatureClassCount);
csvwrite([path,kindofinj,'Accuracy\FeatureFoundAnalisys\BP_',TEST,'_FeaturesFounded_DepO',DepO,'_DepT_',DepT,'_biss.csv'],Featurepruned);
csvwrite([path,kindofinj,'Accuracy\FeatureFoundAnalisys\BP_',TEST,'_DependencyFounded_DepO',DepO,'_DepT_',DepT,'_biss.csv'],Dependencypruned);