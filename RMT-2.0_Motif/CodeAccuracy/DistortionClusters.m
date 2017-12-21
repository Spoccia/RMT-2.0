clc; clear;
%% Analize Results
path='D:\Motif_ResultsCleaning\Datasets\Image\';%'D:\Motif_Results\FeatureSyntDataset\';
kindofinj='data\';%'FlatTS_MultiFeatureDiffClusters\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
testName=...
         '5_FeaturesPruned Time X Dep Size';%Entropy';%intrascore';%
        %'01_FeaturesPruned Time and Dep Size';%Entropy';%intrascore';%
        %'1_RME_1_newCorre_Ent4_Smooth_and_Filter_DoG_0Prune_nothrGraph';%'1_RME_2Corre_Ent1_and_Filter_DoG_0Prune';
        %'2_RMT_Silv_1correction';%'2_RMT_Sicong';%
        %'2_RME_2Corre_Ent1_Smooth_and_Filter_DoG_0Prune_no thrGraph';
        %'1_RME_1Corre_uint8_and_Filter_DoG_0Prune';
        %'2_RMT_Silv_2correction';'2_RME_Silv_1correction_uint8entropy_AND';%'FeatureTest23';
TEST = strcat('5_RME\',testName);%strcat('2_allPreprune_RME\',testName);
kindofCluster='Cluster_Fixed\';
measure='Descriptor';
ClusterAlg = 'ClusterMatlab';
DepO=num2str(2);
DepT=num2str(2);
TS_name=num2str(1);
%% data injected and groundtruth
data = double(imread([path,kindofinj,'1.jpg']));%csvread([path,kindofinj,'Embeddedfeature_',TEST,'.csv']);%csvread([path,kindofinj,'Embeddedfeature.csv']);
% Position_F_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','FeaturePosition_',TEST,'.csv']);
% Feature_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','FeaturesEmbedded_',TEST,'.csv']);
% Dependency_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','dpscale_',TEST,'.csv']);

%% read the clusters to check the motifs.
AfterPruning=0;
Dependencypruned=[];
Featurepruned=[];
Clusterpruned=[];
Centroidpruned=[];
if(AfterPruning==1)
    
load([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',ClusterAlg,'\datacluster_',TS_name,'_DepO_',DepO,'_DepT_',DepT,'.mat']);
Dependencypruned= csvread([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',...
    ClusterAlg,'\PrunedDepScaleFeatures_IM_1_DepO_',DepO,'_DepT_',DepT,'.csv']);
Featurepruned = csvread([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',...
    ClusterAlg,'\PrunedFeatures_IM_1_DepO_',DepO,'_DepT_',DepT,'.csv']);
Clusterpruned = csvread([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',...
    ClusterAlg,'\PrunedCluster_IM_1_DepO_',DepO,'_DepT_',DepT,'.csv']);
Centroidpruned = csvread([path,kindofinj,'Features\',TEST,'\DistancesDescriptors\',kindofCluster,measure,'\afterPruning\',...
    ClusterAlg,'\Centroids_IM_1_DepO_',DepO,'_DepT_',DepT,'.csv']);
else
%%
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
Centroidpruned=Centroidpruned';
end
% timescope= Featurepruned(4,:)*3;
% ItervalFeatures=[];
% for iii=1: size(Featurepruned,2)
%     ItervalFeatures=[ItervalFeatures;[round(Featurepruned(2,iii)-timescope(iii)) , round(Featurepruned(2,iii)+timescope(iii))]];
% end
%% Check to with cluster each feature refers
Interv_Features_Cluster=[];
clusterLabel = unique(Clusterpruned);
nCluster     = length(clusterLabel);
ClusterDistortion=[];
%% check Clusters
checkCluster = pdist2(Centroidpruned',Featurepruned(11:138,:)','cosine');
[~,checkClusterID] = min(checkCluster);
for i=1: nCluster
    F = Featurepruned(:, Clusterpruned == clusterLabel(i));
    D = Dependencypruned(:, Clusterpruned == clusterLabel(i));
%     timescopeF= F(4,:)*3;
%     for iii=1: size(F,2)
%         Interv_Features_Cluster=[Interv_Features_Cluster;[clusterLabel(i),round(F(2,iii)-timescopeF(iii)) , round(F(2,iii)+timescopeF(iii))]];
%     end 
%     FeatureSortedbyCluster=[FeatureSortedbyCluster,F];
%     DescriptorSortedbyCluster=[DescriptorSortedbyCluster,D];
Distortion = pdist2(F(11:138,:)',F(11:138,:)','cosine')/2;
DistortionCluster = pdist2(Centroidpruned(:,i)',F(11:138,:)','cosine')/2;%);%
AvgDescriptor = mean(F(11:138,:)');
Centroid_AVG_Distance = pdist2(AvgDescriptor,Centroidpruned(:,i)','cosine')/2;
DistortionAvgCentroid = pdist2(AvgDescriptor,F(11:138,:)','cosine')/2;
[d_row,d_col]= size(Distortion);%drow= ||M||
Diaginf= eye(size(Distortion))* (max(Distortion(:))+1);
minDist=Distortion+Diaginf;
MinDistortion=0;
MinDistortionCluster=0;
MaxDistortion=0;
MaxDistortionCluster=0;
MinDistortion= min(minDist(:));
MinDistortionCluster= min(DistortionCluster(:));
MinDistortionAvgCentroid= min(DistortionAvgCentroid(:));
MaxDistortion= max(Distortion(:));
MaxDistortionCluster= max(DistortionCluster(:));
MaxDistortionAvgCentroid= max(DistortionAvgCentroid(:));
ClusterDistortion=[ClusterDistortion;[d_row,Centroid_AVG_Distance,MinDistortion,MaxDistortion,MinDistortionCluster,MaxDistortionCluster,MinDistortionAvgCentroid,MaxDistortionAvgCentroid]];
end

if(AfterPruning==1)
    mkdir([path,kindofinj,'Accuracy\Distortion\']);
    csvwrite([path,kindofinj,'Accuracy\Distortion\','AP_',testName,'_Distortion_',DepO,'_DepT_',DepT,'.csv'],ClusterDistortion);
else
    mkdir([path,kindofinj,'Accuracy\Distortion\']);
    csvwrite([path,kindofinj,'Accuracy\Distortion\','BP_',testName,'_Distortion_',DepO,'_DepT_',DepT,'.csv'],ClusterDistortion);
end

