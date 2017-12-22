%% Accuracy best timeoverlapping
clc; clear;

%% Analize Results
path='D:\Motif_Results\Datasets\SynteticDataset\';
kindofinj='data\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
TEST = 'test1';

FeaturesRM ='RMT';%'RME';%
kindofCluster='Cluster_AKmeans';%'ClusterMatlab';%'ClusterKmedoids';%
measure='Descriptor';
ClusterAlg = 'ClusterMatlab';
subfolderClusterLabel='Clusterlabel\ClusterLabel_';
DepO=num2str(2);
DepT=num2str(2);

%% data injected and groundtruth
data = csvread([path,kindofinj,TEST,'.csv']);%csvread([path,kindofinj,'Embeddedfeature.csv']);
Position_F_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\',TEST,'\FeaturePosition_',TEST,'.csv']);
Feature_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\',TEST,'\FeaturesEmbedded_',TEST,'.csv']);
Dependency_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\',TEST,'\dpscale_',TEST,'.csv']);

%% read the clusters to check the motifs.
featurespath=[path,'Features_',FeaturesRM,'\',TEST,'\Distances',measure,'\',kindofCluster,'\AP\Cluster_AKmeans\'];
load([featurespath,'datacluster_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.mat'])
% load([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',ClusterAlg,'\datacluster_1_DepO_',DepO,'_DepT_',DepT,'.mat']);

Dependencypruned = csvread([featurespath,'\PrunedDepScaleFeatures_IM_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
Featurepruned    = csvread([featurespath,'\PrunedFeatures_IM_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
Clusterpruned = csvread([featurespath,'\PrunedCluster_IM_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
Centroidpruned = csvread([featurespath,'\Centroids_IM_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.csv']);

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

[q1, I_IntervFeat]= sort(ItervalFeatures(:,1));

Position_F_Injected = Position_F_Injected(I,:);
ItervalFeatures=ItervalFeatures(I_IntervFeat,:);
 FeatureFoundedSorted = FeatureSortedbyCluster(:,I_IntervFeat);
 DependencyorFoundedSorted = DependencySortedbyCluster(:,I_IntervFeat);

FeatureClassCount=[];
NotFoundPosition=[0,-1,-1,-1];

for i=1:size(Position_F_Injected,1)

FoundedFeatures= [];
    found=0;
    miss=0;
    ActualName = Position_F_Injected(i,:);
    
    InjectedTimePeriod= Position_F_Injected(i,3):Position_F_Injected(i,4);
    MAXOverlapping=-1;
    MAXOverlappingIDX=-1;
    for j=1:size(ItervalFeatures,1);
        IdentifiedTimePeriod=ItervalFeatures(j,1): ItervalFeatures(j,2);
        newOverlapping= intersect(InjectedTimePeriod,IdentifiedTimePeriod);
        if((size(newOverlapping,2) > size(MAXOverlapping,2)) | (MAXOverlapping == -1))
            MAXOverlapping=newOverlapping;
            MAXOverlappingIDX=j;
        end
    end
%% This check is to  check for some anomay features    
% if(ItervalFeatures(MAXOverlappingIDX,1)==-1)
%     MAXOverlappingIDX
% end
    CandidateFeaturePeriod= ItervalFeatures(MAXOverlappingIDX,1): ItervalFeatures(MAXOverlappingIDX,2);
    if(size(MAXOverlapping,2)/max(size(InjectedTimePeriod,2),size(CandidateFeaturePeriod,2))> 0)
        found=found+1;
        FoundedFeatures= [ItervalFeatures(MAXOverlappingIDX,3),...   % add the cluster label
                          MAXOverlappingIDX,...
                          ItervalFeatures(MAXOverlappingIDX,1),...
                          ItervalFeatures(MAXOverlappingIDX,2)];
    else
        miss= miss+1;        
        FoundedFeatures=[NotFoundPosition];
    end

    ActualName= [ActualName,...
                 FoundedFeatures,...
                 found,miss];
    FeatureClassCount=[FeatureClassCount;ActualName];
end

if(exist(strcat(path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\'),'dir')==0)
    mkdir(strcat(path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\'));
end
xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\',TEST,'_AP_MAXOverlapping_DepO',DepO,'_DepT_',DepT,'.xls'],FeatureClassCount);
xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\',TEST,'_AP_FeaturesFounded_DepO',DepO,'_DepT_',DepT,'.xls'],FeatureFoundedSorted);
xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\',TEST,'_AP_DependencyFounded_DepO',DepO,'_DepT_',DepT,'.xls'],DependencyorFoundedSorted);