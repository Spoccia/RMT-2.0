%% Accuracy best timeoverlapping
clc; clear;
%% Analize Results
path='D:\Motif_Results\FeatureSyntDataset\';
kindofinj='FlatTS_MultiFeatureDiffClusters\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
TEST = 'FeatureTest23';
kindofCluster='Cluster_Fixed\';
measure='Descriptor';
ClusterAlg = 'ClusterMatlab';
subfolderClusterLabel='Time_Variate\';
DepO=num2str(2);
DepT=num2str(1);
%% data injected and groundtruth
data = csvread([path,kindofinj,'Embeddedfeature_',TEST,'.csv']);%csvread([path,kindofinj,'Embeddedfeature.csv']);
Position_F_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','FeaturePosition_',TEST,'.csv']);
Feature_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','FeaturesEmbedded_',TEST,'.csv']);
Dependency_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','dpscale_',TEST,'.csv']);

%% read the clusters to check the motifs.
load([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',ClusterAlg,'\datacluster_1_DepO_',DepO,'_DepT_',DepT,'.mat']);
Dependencypruned= csvread([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',...
    ClusterAlg,'\PrunedDepScaleFeatures_IM_1_DepO_',DepO,'_DepT_',DepT,'.csv']);
Featurepruned = csvread([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',...
    ClusterAlg,'\PrunedFeatures_IM_1_DepO_',DepO,'_DepT_',DepT,'.csv']);
Clusterpruned = csvread([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',...
    ClusterAlg,'\PrunedCluster_IM_1_DepO_',DepO,'_DepT_',DepT,'.csv']);
Centroidpruned = csvread([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',...
    ClusterAlg,'\Centroids_IM_1_DepO_',DepO,'_DepT_',DepT,'.csv']);
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
NotFoundPosition=[0,-1,-1,-1,-1,-1];
for i=1:size(Position_F_Injected,1)
FoundedFeatures= [];
    found=0;
    miss=0;
    ActualName = Position_F_Injected(i,:);
    
    InjectedTimePeriod= Position_F_Injected(i,3):Position_F_Injected(i,4);
    MAXOverlapping=-1;
    MAXVariateOverSimilarity=-1;
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
%             MAXOverlapping=newOverlapping;
%             MAXOverlappingIDX=j;
%             VariateOverSimilarity    = size(intersect(...
%                                                       Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),...
%                                                       Dependencypruned(Dependencypruned(:,j)>0,j)),1)/...
%                                        size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),1);
%             MAXVariateOverSimilarity = VariateOverSimilarity;
        elseif((size(newOverlapping,2) >= size(MAXOverlapping,2)))
             VariateOverSimilarity    =  size(intersect(...
                                                      Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),...
                                                      Dependencypruned(Dependencypruned(:,j)>0,j)),1)/...
                                                      max(size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),1),...
                                                      size(Dependencypruned(Dependencypruned(:,j)>0,j),1)                                                       );
%             VariateOverSimilarity    =  size(intersect(...
%                                                       Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),...
%                                                       Dependencypruned(Dependencypruned(:,j)>0,j)),1)/...
%                                        size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),1);%size(intersect(Dependency_Injected(:,Position_F_Injected(i,2)),Dependencypruned(:,j)),1)/size(Dependency_Injected(:,Position_F_Injected(i,2)),1);
            if(VariateOverSimilarity >= MAXVariateOverSimilarity)
                MAXOverlapping=newOverlapping;
               MAXOverlappingIDX=j;
               MAXVariateOverSimilarity = VariateOverSimilarity;
               
                MAXVaraiteOverSim_MaximumDiv= size(intersect(...
                                                      Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),...
                                                      Dependencypruned(Dependencypruned(:,j)>0,j)),1)/...
                                       size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),1);
%                MAXOverlapping=newOverlapping;
%                MAXOverlappingIDX=j;
%                MAXVariateOverSimilarity = VariateOverSimilarity;
            end
        end
    end
    %CandidateFeaturePeriod= ItervalFeatures(MAXOverlappingIDX,1): ItervalFeatures(MAXOverlappingIDX,2);
    
    if(MAXOverlappingIDX~=-1)%if(size(MAXOverlapping,2)/max(size(InjectedTimePeriod,2),size(CandidateFeaturePeriod,2))> 0)
        found=found+1;
        FoundedFeatures= [ItervalFeatures(MAXOverlappingIDX,3),...   % add the cluster label
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

% FeatureClassCount=[];
% NotFoundPosition=[0,-1,-1,-1,-1];
% for i=1:size(Position_F_Injected,1)
% FoundedFeatures= [];
%     found=0;
%     miss=0;
%     ActualName = Position_F_Injected(i,:);
%     
%     InjectedTimePeriod= Position_F_Injected(i,3):Position_F_Injected(i,4);
%     MAXOverlapping=-1;
%     MAXVariateOverSimilarity=-1;
%     MAXOverlappingIDX=-1;
%     for j=1:size(ItervalFeatures,1);
%         IdentifiedTimePeriod=ItervalFeatures(j,1): ItervalFeatures(j,2);
%         newOverlapping= intersect(InjectedTimePeriod,IdentifiedTimePeriod);
%         if (size(newOverlapping,2) & (MAXOverlapping == -1))
%             MAXOverlapping=newOverlapping;
%             MAXOverlappingIDX=j;
%             VariateOverSimilarity    = size(intersect(...
%                                                       Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),...
%                                                       Dependencypruned(Dependencypruned(:,j)>0,j)),1)/...
%                                        size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),1);
%             MAXVariateOverSimilarity = VariateOverSimilarity;
%         elseif((size(newOverlapping,2) >= size(MAXOverlapping,2)))
%             VariateOverSimilarity    =  size(intersect(...
%                                                       Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),...
%                                                       Dependencypruned(Dependencypruned(:,j)>0,j)),1)/...
%                                        size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(i,2))>0,Position_F_Injected(i,2)),1);
%             if(VariateOverSimilarity >= MAXVariateOverSimilarity)
%                MAXOverlapping=newOverlapping;
%                MAXOverlappingIDX=j;
%                MAXVariateOverSimilarity = VariateOverSimilarity;
%             end
%         end
%     end
%  %   CandidateFeaturePeriod= ItervalFeatures(MAXOverlappingIDX,1): ItervalFeatures(MAXOverlappingIDX,2);
%     
%     if(MAXOverlappingIDX~=-1)%size(MAXOverlapping,2)/max(size(InjectedTimePeriod,2),size(CandidateFeaturePeriod,2))> 0)
%         found=found+1;
%         FoundedFeatures= [ItervalFeatures(MAXOverlappingIDX,3),...   % add the cluster label
%                           MAXOverlappingIDX,...
%                           ItervalFeatures(MAXOverlappingIDX,1),...
%                           ItervalFeatures(MAXOverlappingIDX,2),...
%                           MAXVariateOverSimilarity];
%     else
%         miss= miss+1;
%         FoundedFeatures=NotFoundPosition;
%     end    
% 
%     ActualName= [ActualName,...
%                  FoundedFeatures,...
%                  found,miss];
%     FeatureClassCount=[FeatureClassCount;ActualName];
% end

csvwrite([path,kindofinj,'Accuracy\MAXOVERLAPPING\',subfolderClusterLabel,'AP_',TEST,'_MAXOverlappingFeaturesFounded_DepO',DepO,'_DepT_',DepT,'_biss.csv'],FeatureClassCount);
csvwrite([path,kindofinj,'Accuracy\FeatureFoundAnalisys\AP_',TEST,'_FeaturesFounded_DepO',DepO,'_DepT_',DepT,'_biss.csv'],FeatureFoundedSorted);
csvwrite([path,kindofinj,'Accuracy\FeatureFoundAnalisys\AP_',TEST,'_DependencyFounded_DepO',DepO,'_DepT_',DepT,'_biss.csv'],DependencyorFoundedSorted);