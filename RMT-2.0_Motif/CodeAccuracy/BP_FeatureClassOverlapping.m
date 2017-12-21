clc; clear;
%% Analize Results
path='D:\Motif_Results\FeatureSyntDataset\';
kindofinj='FlatTS_MultiFeatureDiffClusters\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
TEST = 'FeatureTest23';
kindofCluster='Cluster_Fixed\';
measure='Descriptor';
ClusterAlg = 'ClusterMatlab';
TS_name=num2str(1);
DepO=num2str(2);
DepT=num2str(1);
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
[q,I] = sort(Position_F_Injected(:,2));
% [q1, I_IntervFeat]= sort(ItervalFeatures(:,2));

% Position_F_Injected = Position_F_Injected(I,:);
% Interv_Features_Cluster=Interv_Features_Cluster(I_IntervFeat,:);

FeatureClassCount=[];
ActualName=[];
NotFoundPosition=[0,-1,-1,-1];
for i=1: size(Interv_Features_Cluster,1)
    IdentifiedTimePeriod=Interv_Features_Cluster(i,2): Interv_Features_Cluster(i,3);
    miss=0;
    found=0;
    MAXOverlapping=-1;
    MAXVariateOverSimilarity=-1;
    MAXVaraiteOverSim_MaximumDiv=-1;
    MAXOverlappingIDX=-1;
    
    for j=1:size(Position_F_Injected,1)
        InjectedTimePeriod= Position_F_Injected(j,3):Position_F_Injected(j,4);
        newOverlapping= intersect(InjectedTimePeriod,IdentifiedTimePeriod);
        if(size(newOverlapping,2) & (MAXOverlapping == -1))
            MAXOverlapping=newOverlapping;
            MAXOverlappingIDX=j;
            MAXVaraiteOverSim_MaximumDiv    = size(intersect(...
                Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),...
                Dependencypruned(Dependencypruned(:,i)>0,i)),1)/...
                size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),1);
            
            VariateOverSimilarity= size(intersect(...
                Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),...
                Dependencypruned(Dependencypruned(:,i)>0,i)),1)/...
                max(size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),1),...
                size(Dependencypruned(Dependencypruned(:,i)>0,i),1)                                                       );
            MAXVariateOverSimilarity = VariateOverSimilarity;
            %% ActualName= Position_F_Injected(j,:);
        elseif((size(newOverlapping,2) >= size(MAXOverlapping,2)))
                VariateOverSimilarity    =  size(intersect(...
                Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),...
                Dependencypruned(Dependencypruned(:,i)>0,i)),1)/...
                max(size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),1),...
                size(Dependencypruned(Dependencypruned(:,i)>0,i),1)                                                       );
            if(VariateOverSimilarity >= MAXVariateOverSimilarity)
                MAXOverlapping=newOverlapping;
                MAXOverlappingIDX=j;
                MAXVariateOverSimilarity = VariateOverSimilarity;
                
                MAXVaraiteOverSim_MaximumDiv= size(intersect(...
                    Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),...
                    Dependencypruned(Dependencypruned(:,i)>0,i)),1)/...
                    size(Dependency_Injected(Dependency_Injected(:,Position_F_Injected(j,2))>0,Position_F_Injected(j,2)),1);
                
            end
        end
    end
    
%     NearInjectedFeaturePeriod= Position_F_Injected(MAXOverlappingIDX,3): Position_F_Injected(MAXOverlappingIDX,4);
%     CandidateFeaturePeriod= IdentifiedTimePeriod;%ItervalFeatures(MAXOverlappingIDX,1): ItervalFeatures(MAXOverlappingIDX,2);
%     Overlpping = intersect(CandidateFeaturePeriod,NearInjectedFeaturePeriod);
    if(MAXOverlappingIDX~=-1)%if(size(MAXOverlapping,2)/max(size(InjectedTimePeriod,2),size(CandidateFeaturePeriod,2))> 0)
        ActualName= Position_F_Injected(MAXOverlappingIDX,:);
        found=found+1;
    else
        miss= miss+1;
        ActualName=NotFoundPosition;
    end    

    ActualName= [ActualName,...
                 Interv_Features_Cluster(i,1),...
                 i,...
                 Interv_Features_Cluster(i,2),...
                 Interv_Features_Cluster(i,3),...
                 MAXVariateOverSimilarity,...
                 MAXVaraiteOverSim_MaximumDiv,...
                 found,miss];
    FeatureClassCount=[FeatureClassCount;ActualName];
end
% for i=1: size(Interv_Features_Cluster,1)  
%     IdentifiedTimePeriod=Interv_Features_Cluster(i,2): Interv_Features_Cluster(i,3);
%     miss=0;
%     found=0;
%     MAXOverlapping=-1;
%     MAXOverlappingIDX=-1;
%     for j=1:size(Position_F_Injected,1)
%         InjectedTimePeriod= Position_F_Injected(j,3):Position_F_Injected(j,4);
%         newOverlapping= intersect(InjectedTimePeriod,IdentifiedTimePeriod);
%         if((size(newOverlapping,2) > size(MAXOverlapping,2)) | (MAXOverlapping == -1))
%             MAXOverlapping=newOverlapping;
%             MAXOverlappingIDX=j;
%             ActualName= Position_F_Injected(j,:);
%         end
%     end
%     NearInjectedFeaturePeriod= Position_F_Injected(MAXOverlappingIDX,3): Position_F_Injected(MAXOverlappingIDX,4);
%     CandidateFeaturePeriod= IdentifiedTimePeriod;%ItervalFeatures(MAXOverlappingIDX,1): ItervalFeatures(MAXOverlappingIDX,2);
%     Overlpping = intersect(CandidateFeaturePeriod,NearInjectedFeaturePeriod);
%     if(size(Overlpping,2)> 0)
%         found=found+1;
%     else
%         miss= miss+1;
%         ActualName=NotFoundPosition;
%     end
%     ActualName= [ActualName,...
%                  Interv_Features_Cluster(i,1),...
%                  Interv_Features_Cluster(i,2),...
%                  Interv_Features_Cluster(i,3),...
%                  found,miss];
%     FeatureClassCount=[FeatureClassCount;ActualName];
% end

% [q,I] = sort(FeatureClassCount(:,2));
csvwrite([path,kindofinj,'Accuracy\FeatureFound_FeatureInjected\','BP_',TEST,'_FeatureFound_FeatureInjected_DepO_bis',DepO,'_DepT_',DepT,'.csv'],FeatureClassCount);

