%% Analize Results
path='D:\Motif_Results\FeatureSyntDataset\';
kindofinj='FlatTS_MultiFeatureDiffClusters\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
TEST = 'FeatureTest14';
kindofCluster='Cluster_Fixed\';
measure='Descriptor';
ClusterAlg = 'ClusterMatlab';
DepO=num2str(2);
DepT=num2str(2);
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
        Interv_Features_Cluster=[Interv_Features_Cluster;[round(F(2,iii)-timescopeF(iii)) , round(F(2,iii)+timescopeF(iii)),clusterLabel(i)]];
    end 
    FeatureSortedbyCluster=[FeatureSortedbyCluster,F];
    DescriptorSortedbyCluster=[DescriptorSortedbyCluster,D];
    
end

ItervalFeatures =Interv_Features_Cluster;

%% Sort the Feature on the index of  the name of the specific feature.
[q,I] = sort(Position_F_Injected(:,2));

[q1, I_IntervFeat]= sort(ItervalFeatures(:,1));

Position_F_Injected = Position_F_Injected(I,:);
ItervalFeatures=ItervalFeatures(I_IntervFeat,:);

FeatureClassCount=[];
for i=1:size(Position_F_Injected,1)
    found=0;
    miss=0;    
    ActualName = Position_F_Injected(i,:);
    
    StartI = Position_F_Injected(i,3);
    EndI   = Position_F_Injected(i,4);
    LoclIF_Start= ItervalFeatures(:,1)-StartI;
    LoclIF_End= ItervalFeatures(:,2)-EndI;
    [pos_S_F,idx_Start]= min(abs(LoclIF_Start));
    [pos_E_F,idx_End]= min(abs(LoclIF_End));
    
    if(idx_Start ~= idx_End)
        endneighboorstart= ItervalFeatures(idx_Start,2);
        starteighboorstart=ItervalFeatures(idx_End,1);
        %%  get the feature with max overlapping
        Local_I_Feature=[];
        Local_I_Feature_1= ItervalFeatures(idx_Start,1): ItervalFeatures(idx_Start,2);%190-204
        Local_I_Feature_2= ItervalFeatures(idx_End,1): ItervalFeatures(idx_End,2); %207-225
        I_Feature=StartI: EndI; %196-230
        IntersectionTime1 = intersect(Local_I_Feature_1,I_Feature);
        IntersectionTime2 = intersect(Local_I_Feature_2,I_Feature);
        [~,candidateItersect]= max([size(IntersectionTime1,2),size(IntersectionTime2,2)]);
        IDX_Identified_Feature=[];
        if candidateItersect == 1
            candidateIntersect=IntersectionTime1;
            Local_I_Feature=Local_I_Feature_1;
            IDX_Identified_Feature=[ItervalFeatures(idx_Start,3),ItervalFeatures(idx_Start,1), ItervalFeatures(idx_Start,2)];
        else
            candidateIntersect=IntersectionTime2;
            Local_I_Feature=Local_I_Feature_2;
            IDX_Identified_Feature=[ItervalFeatures(idx_Start,3),ItervalFeatures(idx_End,1),ItervalFeatures(idx_End,2)];
        end
        if(size(candidateIntersect,2)/max(size(I_Feature,2),size(Local_I_Feature,2))>= 0.5)
            found=found+1;
        else
            miss= miss+1;
        end
        ActualName= [ActualName,IDX_Identified_Feature,found,miss];

    else
        Local_I_Feature = ItervalFeatures(idx_Start,1):ItervalFeatures(idx_End,2);
        I_Feature=StartI: EndI;
        IntersectionTime = intersect(Local_I_Feature,I_Feature);
        if(size(IntersectionTime,2)/max(size(I_Feature,2),size(Local_I_Feature,2))>= 0.5)
            found=found+1;
        else
            miss= miss+1;
        end
        IDX_Identified_Feature=[ItervalFeatures(idx_Start,3),ItervalFeatures(idx_Start,1),ItervalFeatures(idx_End,2)];
        ActualName= [ActualName,IDX_Identified_Feature,found,miss];
    end
    FeatureClassCount=[FeatureClassCount;ActualName];
end

% %% Sort the Feature on the index of  the name of the specific feature.
% [q,I] = sort(Position_F_Injected(:,2));
% 
% [q1, I_IntervFeat]= sort(ItervalFeatures(:,1));
% 
% Position_F_Injected = Position_F_Injected(I,:);
% ItervalFeatures=ItervalFeatures(I_IntervFeat,:);
% 
% %% using the scope of the features get the  feature  near or overlapping a specifi interval
% F_name=Position_F_Injected(1,2);
% FeatureClassCount=[];
% found=0;
% miss=0;
% for i=1:size(Position_F_Injected,1)
%     new_F_name= Position_F_Injected(i,2);
%     if (i==size(Position_F_Injected,1))
%         if(new_F_name == F_name)
%             StartI = Position_F_Injected(i,3);
%             EndI   = Position_F_Injected(i,4);
%             LoclIF_Start= ItervalFeatures(:,1)-StartI;
%             LoclIF_End= ItervalFeatures(:,2)-EndI;
%             [pos_S_F,idx_Start]= min(abs(LoclIF_Start));
%             [pos_E_F,idx_End]= min(abs(LoclIF_End));
%             if(idx_Start ~= idx_End)
%                 endneighboorstart= ItervalFeatures(idx_Start,2);
%                 starteighboorstart=ItervalFeatures(idx_End,1);
%                 %%  get the feature with max overlapping
%                 Local_I_Feature;
%                 Local_I_Feature_1= ItervalFeatures(idx_Start,1): ItervalFeatures(idx_Start,2);
%                 Local_I_Feature_2= ItervalFeatures(idx_End,1): ItervalFeatures(idx_End,2);
%                 I_Feature=StartI: EndI;
%                 IntersectionTime1 = intersect(Local_I_Feature_1,I_Feature);
%                 IntersectionTime2 = intersect(Local_I_Feature_2,I_Feature);
%                 [~,candidateItersect]= max([size(IntersectionTime1,2),size(IntersectionTime2,2)]);
%                 if candidateItersect == 1
%                     candidateIntersect=IntersectionTime1;
%                     Local_I_Feature=Local_I_Feature_1;
%                 else
%                     candidateIntersect=IntersectionTime2;
%                     Local_I_Feature=Local_I_Feature_2;
%                 end
%                 if(size(candidateIntersect,2)/max(size(I_Feature,2),size(Local_I_Feature,2))>= 0.5)
%                     found=found+1;
%                 else
%                     miss= miss+1;
%                 end
%             else
%                 Local_I_Feature = ItervalFeatures(idx_Start,1):ItervalFeatures(idx_End,2);
%                 I_Feature=StartI: EndI;
%                 IntersectionTime = intersect(Local_I_Feature,I_Feature);
%                 if(size(IntersectionTime,2)/max(size(I_Feature,2),size(Local_I_Feature,2))>= 0.5)
%                     found=found+1;
%                 else
%                     miss= miss+1;
%                 end
%             end
%             FeatureClassCount=[FeatureClassCount;[new_F_name,miss,found]];
%         else
%             %% save in the structure the count
%             FeatureClassCount=[FeatureClassCount;[F_name,miss,found]];
%             found=0;
%             miss=0;
%             StartI = Position_F_Injected(i,3);
%             EndI   = Position_F_Injected(i,4);
%             LoclIF_Start= ItervalFeatures(:,1)-StartI;
%             LoclIF_End= ItervalFeatures(:,2)-EndI;
%             [pos_S_F,idx_Start]= min(abs(LoclIF_Start));
%             [pos_E_F,idx_End]= min(abs(LoclIF_End));
%             if(idx_Start ~= idx_End)
%                 endneighboorstart= ItervalFeatures(idx_Start,2);
%                 starteighboorstart=ItervalFeatures(idx_End,1);
%                 %%  get the feature with max overlapping
%                 Local_I_Feature;
%                 Local_I_Feature_1= ItervalFeatures(idx_Start,1): ItervalFeatures(idx_Start,2);
%                 Local_I_Feature_2= ItervalFeatures(idx_End,1): ItervalFeatures(idx_End,2);
%                 I_Feature=StartI: EndI;
%                 IntersectionTime1 = intersect(Local_I_Feature_1,I_Feature);
%                 IntersectionTime2 = intersect(Local_I_Feature_2,I_Feature);
%                 [~,candidateItersect]= max([size(IntersectionTime1,2),size(IntersectionTime2,2)]);
%                 if candidateItersect == 1
%                     candidateIntersect=IntersectionTime1;
%                     Local_I_Feature=Local_I_Feature_1;
%                 else
%                     candidateIntersect=IntersectionTime2;
%                     Local_I_Feature=Local_I_Feature_2;
%                 end
%                 if(size(candidateIntersect,2)/max(size(I_Feature,2),size(Local_I_Feature,2))>= 0.5)
%                     found=found+1;
%                 else
%                     miss= miss+1;
%                 end
%                 %             'some probems occur'
%                 %             miss= miss+1;
%             else
%                 Local_I_Feature = ItervalFeatures(idx_Start,1):ItervalFeatures(idx_End,2);
%                 I_Feature=StartI: EndI;
%                 IntersectionTime = intersect(Local_I_Feature,I_Feature);
%                 if(size(IntersectionTime,2)/max(size(I_Feature,2),size(Local_I_Feature,2))>= 0.5)
%                     found=found+1;
%                 else
%                     miss= miss+1;
%                 end
%             end
%             F_name=new_F_name;
%             FeatureClassCount=[FeatureClassCount;[F_name,miss,found]];
%         end
%     elseif(new_F_name == F_name)
%         StartI = Position_F_Injected(i,3);
%         EndI   = Position_F_Injected(i,4);
%         LoclIF_Start= ItervalFeatures(:,1)-StartI;
%         LoclIF_End= ItervalFeatures(:,2)-EndI;
%         [pos_S_F,idx_Start]= min(abs(LoclIF_Start));
%         [pos_E_F,idx_End]= min(abs(LoclIF_End));
%         if(idx_Start ~= idx_End)
%             endneighboorstart= ItervalFeatures(idx_Start,2);
%             starteighboorstart=ItervalFeatures(idx_End,1);
%             %%  get the feature with max overlapping
%             Local_I_Feature;
%             Local_I_Feature_1= ItervalFeatures(idx_Start,1): ItervalFeatures(idx_Start,2);
%             Local_I_Feature_2= ItervalFeatures(idx_End,1): ItervalFeatures(idx_End,2);
%             I_Feature=StartI: EndI;
%             IntersectionTime1 = intersect(Local_I_Feature_1,I_Feature);
%             IntersectionTime2 = intersect(Local_I_Feature_2,I_Feature);
%             [~,candidateItersect]= max([size(IntersectionTime1,2),size(IntersectionTime2,2)]);
%             if candidateItersect == 1
%                 candidateIntersect=IntersectionTime1;
%                 Local_I_Feature=Local_I_Feature_1;
%             else
%                 candidateIntersect=IntersectionTime2;
%                 Local_I_Feature=Local_I_Feature_2;
%             end
%             if(size(candidateIntersect,2)/max(size(I_Feature,2),size(Local_I_Feature,2))>= 0.5)
%                 found=found+1;
%             else
%                 miss= miss+1;
%             end
%         else
%             Local_I_Feature = ItervalFeatures(idx_Start,1):ItervalFeatures(idx_End,2);
%             I_Feature=StartI: EndI;
%             IntersectionTime = intersect(Local_I_Feature,I_Feature);
%             if(size(IntersectionTime,2)/max(size(I_Feature,2),size(Local_I_Feature,2))>= 0.5)
%                 found=found+1;
%             else
%                 miss= miss+1;
%             end
%         end
%         F_name=new_F_name;
%     else
%         %% save in the structure the count
%         FeatureClassCount=[FeatureClassCount;[F_name,miss,found]];
%         found=0;
%         miss=0;
%         StartI = Position_F_Injected(i,3);
%         EndI   = Position_F_Injected(i,4);
%         LoclIF_Start= ItervalFeatures(:,1)-StartI;
%         LoclIF_End= ItervalFeatures(:,2)-EndI;
%         [pos_S_F,idx_Start]= min(abs(LoclIF_Start));
%         [pos_E_F,idx_End]= min(abs(LoclIF_End));
%         if(idx_Start ~= idx_End)
%             endneighboorstart= ItervalFeatures(idx_Start,2);
%             starteighboorstart=ItervalFeatures(idx_End,1);
%             %%  get the feature with max overlapping
%             Local_I_Feature;
%             Local_I_Feature_1= ItervalFeatures(idx_Start,1): ItervalFeatures(idx_Start,2);
%             Local_I_Feature_2= ItervalFeatures(idx_End,1): ItervalFeatures(idx_End,2);
%             I_Feature=StartI: EndI;
%             IntersectionTime1 = intersect(Local_I_Feature_1,I_Feature);
%             IntersectionTime2 = intersect(Local_I_Feature_2,I_Feature);
%             [~,candidateItersect]= max([size(IntersectionTime1,2),size(IntersectionTime2,2)]);
%             if candidateItersect == 1
%                 candidateIntersect=IntersectionTime1;
%                 Local_I_Feature=Local_I_Feature_1;
%             else
%                 candidateIntersect=IntersectionTime2;
%                 Local_I_Feature=Local_I_Feature_2;
%             end
%             if(size(candidateIntersect,2)/max(size(I_Feature,2),size(Local_I_Feature,2))>= 0.5)
%                 found=found+1;
%             else
%                 miss= miss+1;
%             end
%             %             'some probems occur'
%             %             miss= miss+1;
%         else
%             Local_I_Feature = ItervalFeatures(idx_Start,1):ItervalFeatures(idx_End,2);
%             I_Feature=StartI: EndI;
%             IntersectionTime = intersect(Local_I_Feature,I_Feature);
%             if(size(IntersectionTime,2)/max(size(I_Feature,2),size(Local_I_Feature,2))>= 0.5)
%                 found=found+1;
%             else
%                 miss= miss+1;
%             end
%         end
%         F_name=new_F_name;
%         
%     end
% end

csvwrite([path,kindofinj,'Accuracy\AP_',TEST,'_FeaturesFounded_DepO',DepO,'_DepT_',DepT,'.csv'],FeatureClassCount);