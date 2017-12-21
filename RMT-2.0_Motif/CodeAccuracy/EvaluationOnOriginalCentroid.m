%% Original centroid used to classify the feature founded
clc; clear;
%% Analize Results
path='D:\Motif_Results\FeatureSyntDataset\';
kindofinj='FlatTS_MultiFeatureDiffClusters\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
TEST = 'FeatureTest23';
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

%% read the centroids of the original cluster
ClusterCentroids = csvread(['D:\Motif_Results\FeatureSyntDataset\FlatTS_MultiFeatureDiffClusters\IndexEmbeddedFeatures\Centroids_IM_',TS_name,'_DepO_',DepO,'_TimeO_',DepT,'.csv']);

%% distance between  features descriptors and centroid

Dist = pdist2(Featurepruned(11:138,:)',ClusterCentroids,'cosine');
[val,Class_Label] = min(Dist');
newCentroids=[];
for i=1:5
    idx= Class_Label==i;
    localF = mean(Featurepruned(11:138,idx)');
    newCentroids=[newCentroids;localF];
end
for i=1:5
    distance = ((1-(pdist([ClusterCentroids(i,:);newCentroids(i,:)],'cosine')))+1)/2
end

FeatureClassCount=[];
NotFoundPosition=[0,-1,-1,-1,-1,-1];
for i=1:size(Position_F_Injected,1)
FoundedFeatures= [];
    found=0;
    miss=0;
    ActualName = Position_F_Injected(i,:);
    
    InjectedTimePeriod= Position_F_Injected(i,3):Position_F_Injected(i,4);
    MAXOverlapping=-1;
    MAXVariateOverSimilarity=-1;
    MAXVaraiteOverSim_MaximumDiv=-1;
    MAXOverlappingIDX=-1;
    for j=1:size(ItervalFeatures,1);
        IdentifiedTimePeriod=ItervalFeatures(j,1): ItervalFeatures(j,2);
        newOverlapping= intersect(InjectedTimePeriod,IdentifiedTimePeriod);
        if (size(newOverlapping,2) & (MAXOverlapping == -1))
            MAXOverlapping=newOverlapping;
            MAXOverlappingIDX=j;
            MAXVaraiteOverSim_MaximumDiv    = size(intersect(...
                                                      Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),...
                                                      Dependencypruned(Dependencypruned(:,j)>0,j)),1)/...
                                       size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),1);
            
            VariateOverSimilarity= size(intersect(...
                                                      Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),...
                                                      Dependencypruned(Dependencypruned(:,j)>0,j)),1)/...
                                                      max(size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),1),...
                                                      size(Dependencypruned(Dependencypruned(:,j)>0,j),1)                                                       );
            MAXVariateOverSimilarity = VariateOverSimilarity;
        elseif((size(newOverlapping,2) >= size(MAXOverlapping,2)))
            VariateOverSimilarity    =  size(intersect(...
                                                      Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),...
                                                      Dependencypruned(Dependencypruned(:,j)>0,j)),1)/...
                                                      max(size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),1),...
                                                      size(Dependencypruned(Dependencypruned(:,j)>0,j),1)                                                       );
            if(VariateOverSimilarity >= MAXVariateOverSimilarity)
               MAXOverlapping=newOverlapping;
               MAXOverlappingIDX=j;
               MAXVariateOverSimilarity = VariateOverSimilarity;
               
                MAXVaraiteOverSim_MaximumDiv= size(intersect(...
                                                      Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),...
                                                      Dependencypruned(Dependencypruned(:,j)>0,j)),1)/...
                                       size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),1);%size(intersect(Dependency_Injected(:,Position_F_Injected(i,2)),Dependencypruned(:,j)),1)/size(Dependency_Injected(:,Position_F_Injected(i,2)),1);
                
            end
        end
    end
    %CandidateFeaturePeriod= ItervalFeatures(MAXOverlappingIDX,1): ItervalFeatures(MAXOverlappingIDX,2);
    
    if(MAXOverlappingIDX~=-1)%if(size(MAXOverlapping,2)/max(size(InjectedTimePeriod,2),size(CandidateFeaturePeriod,2))> 0)
        found=found+1;
        FoundedFeatures= [Class_Label(MAXOverlappingIDX),...   % add the cluster label
                          MAXOverlappingIDX,...
                          ItervalFeatures(MAXOverlappingIDX,1),...
                          ItervalFeatures(MAXOverlappingIDX,2),...
                          MAXVariateOverSimilarity,...
                          MAXVaraiteOverSim_MaximumDiv];
    else
        miss= miss+1;
        FoundedFeatures=NotFoundPosition;
    end    

    ActualName= [ActualName,...
                 FoundedFeatures,...
                 found,miss];
    FeatureClassCount=[FeatureClassCount;ActualName];
end
