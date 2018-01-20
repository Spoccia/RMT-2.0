% clc; clear;
% AfterPruning=1;
% subcluster=1;
function Distortion_Clusters(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,DepO,DepT,AfterPruning,subcluster)
% %% Analize Results
% path='D:\Motif_Results\Datasets\SynteticDataset\';%'D:\Motif_Results\FeatureSyntDataset\';
% kindofinj='data\';%'FlatTS_MultiFeatureDiffClusters\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
% 
% TEST = 'test1';
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

Dependencypruned=[];
Featurepruned=[];
Clusterpruned=[];
Centroidpruned=[];
if(AfterPruning==1)
    if(subcluster==0)
        featurespath=[path,'Features_',FeaturesRM,'\',TEST,'\Distances',measure,'\',kindofCluster,'\AP\Cluster_AKmeans\'];
%          load([featurespath,'datacluster_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.mat']);
        Dependencypruned = csvread([featurespath,'\PrunedDepScaleFeatures_IM_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
        Featurepruned    = csvread([featurespath,'\PrunedFeatures_IM_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
        Clusterpruned = csvread([featurespath,'\PrunedCluster_IM_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
        Centroidpruned = csvread([featurespath,'\Centroids_IM_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
    else
        featurespath=[path,'Features_',FeaturesRM,'\',TEST,'\Distances',measure,'\',kindofCluster,'\SplitVariate\AP_VA\Cluster_AKmeans\'];
%         load([featurespath,'datacluster_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.mat'])
        Dependencypruned = csvread([featurespath,'\PrunedDepScaleFeatures_IM_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
        Featurepruned    = csvread([featurespath,'\PrunedFeatures_IM_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
        Clusterpruned = csvread([featurespath,'\PrunedCluster_IM_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
        Centroidpruned = csvread([featurespath,'\Centroids_IM_',TEST,'_DepO_',DepO,'_DepT_',DepT,'.csv']);       
    end
else
%%
%% read the clusters to check the motifs.
% load features
    if(subcluster==0)
        featurespath=[path,'Features_',FeaturesRM,'\',TEST,'\Distances',measure,'\',kindofCluster,'\'];%AP_VA\Cluster_AKmeans\'];
        Dependencypruned = csvread([path,'Features_',FeaturesRM,'\',TEST,'\Distances',measure,'\DepdScale_IM_',TEST,'_DepO_',DepO,'_TimeO_',DepT,'.csv']);
         load([path,'Features_',FeaturesRM,'\',TEST,'\feature_',TEST,'.mat']);%csvread([featurespath,'\Features_IM_',TEST,'_OT_',DepT,'_OD_',DepO,'.csv']);%,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
        indexfeatureGroup = (frame1(6,:)==str2num(DepT) & frame1(5,:)==str2num(DepO));
        Featurepruned=frame1(:,indexfeatureGroup);
        Clusterpruned = csvread([featurespath,'\Cluster_IM_',TEST,'_DepO_',DepO,'_TimeO_',DepT,'.csv']);%,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
        Centroidpruned = csvread([featurespath,'\Centroids_IM_',TEST,'_DepO_',DepO,'_TimeO_',DepT,'.csv']);%,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
        Centroidpruned =Centroidpruned';
    else 
        featurespath=[path,'Features_',FeaturesRM,'\',TEST,'\Distances',measure,'\',kindofCluster,'\SplitVariate\'];%AP_VA\Cluster_AKmeans\'];
        Dependencypruned = csvread([featurespath,'\DepdScale_IM_',TEST,'_OT_',DepT,'_OD_',DepO,'.csv']);%_DepO_',DepO,'_DepT_',DepT,'.csv']);
        Featurepruned    = csvread([featurespath,'\Features_IM_',TEST,'_OT_',DepT,'_OD_',DepO,'.csv']);%,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
        Clusterpruned = csvread([featurespath,'\Cluster_IM_',TEST,'_OT_',DepT,'_OD_',DepO,'.csv']);%,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
        Centroidpruned = csvread([featurespath,'\Centroids_IM_',TEST,'_OT_',DepT,'_OD_',DepO,'.csv']);%,'_DepO_',DepO,'_DepT_',DepT,'.csv']);
    end
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
checkCluster = pdist2(Centroidpruned',Featurepruned(11:138,:)');%,'cosine');
[~,checkClusterID] = min(checkCluster);
row_header =[];
    SpaceDistances= pdist2(Featurepruned(11:138,:)',Featurepruned(11:138,:)');
    maximumSpaceDistance= max(SpaceDistances(:));
for i=1: nCluster


    F = Featurepruned(:, Clusterpruned == clusterLabel(i));
    D = Dependencypruned(:, Clusterpruned == clusterLabel(i));
    row_header=[row_header,clusterLabel(i)];
%     timescopeF= F(4,:)*3;
%     for iii=1: size(F,2)
%         Interv_Features_Cluster=[Interv_Features_Cluster;[clusterLabel(i),round(F(2,iii)-timescopeF(iii)) , round(F(2,iii)+timescopeF(iii))]];
%     end 
%     FeatureSortedbyCluster=[FeatureSortedbyCluster,F];
%     DescriptorSortedbyCluster=[DescriptorSortedbyCluster,D];
Distortion = pdist2(F(11:138,:)',F(11:138,:)')/maximumSpaceDistance;%,'cosine')/2;
DistortionCluster = pdist2(Centroidpruned(:,i)',F(11:138,:)')/maximumSpaceDistance;%,'cosine')/2;%);%
AVGDtoCEntroid = mean2(DistortionCluster);

AVGbetweenCFeatures= mean2(Distortion);
AvgDescriptor = mean(F(11:138,:)');
% Centroid_AVG_Distance = pdist2(AvgDescriptor,Centroidpruned(:,i)','cosine')/2;
% DistortionAvgCentroid = pdist2(AvgDescriptor,F(11:138,:)','cosine')/2;
[d_row,d_col]= size(Distortion);%drow= ||M||
Diaginf= eye(size(Distortion))* (max(Distortion(:))+1);
minDist=Distortion+Diaginf;
MinDistortion=0;
MinDistortionCluster=0;
MaxDistortion=0;
MaxDistortionCluster=0;
MinDistortion= min(minDist(:));
MinDistortionCluster= min(DistortionCluster(:));
% MinDistortionAvgCentroid= min(DistortionAvgCentroid(:));
MaxDistortion= max(Distortion(:));
MaxDistortionCluster= max(DistortionCluster(:));
% MaxDistortionAvgCentroid= max(DistortionAvgCentroid(:));
% ClusterDistortion=[ClusterDistortion;[d_row,Centroid_AVG_Distance,MinDistortion,MaxDistortion,MinDistortionCluster,MaxDistortionCluster,MinDistortionAvgCentroid,MaxDistortionAvgCentroid]];
ClusterDistortion=[ClusterDistortion;[d_row,MinDistortion,MaxDistortion,MinDistortionCluster,MaxDistortionCluster,AVGDtoCEntroid,AVGbetweenCFeatures]];
end

col_header={'ClassID','Support','minD_Fi_Fj_in same C','maxD_Fi_Fj_in same C','minD_Ci_Fi_inCi','maxD_Ci_Fi_inCi','AVG Fi_Ci','AVG Fi_Fj_in_Ci'};

if(exist([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\'],'dir')==0)
   mkdir([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\']);
end


if(AfterPruning==1)
    if(subcluster==0) 
%         if(exist([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\'],'dir')==0)
%             mkdir([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\']);
%         end
%         xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\','AP_',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.csv'],ClusterDistortion);
        xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.xls'],col_header,'AP_Distorsion','A1');
        xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.xls'],row_header','AP_Distorsion','A2');
        xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.xls'],ClusterDistortion,'AP_Distorsion','B2');
    else
%         if(exist([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\subcluster\Distortion\'],'dir')==0)
%             mkdir([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\subcluster\Distortion\']);
%         end
%         xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\subcluster\Distortion\','AP_',TEST,'_Distortion_SubCluster_',DepO,'_DepT_',DepT,'.csv'],ClusterDistortion);
        xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.xls'],col_header,'AP_Distorsion_SubC','A1');
        xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.xls'],row_header','AP_Distorsion_SubC','A2');
        xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.xls'],ClusterDistortion,'AP_Distorsion_SubC','B2');
    end
else
    if(subcluster==0)
%         if(exist([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\'],'dir')==0)
%             mkdir([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\']);
%         end
%         xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\','BP_',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.csv'],ClusterDistortion);
        xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.xls'],col_header,'BP_Distorsion','A1');
        xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.xls'],row_header','BP_Distorsion','A2');
        xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.xls'],ClusterDistortion,'BP_Distorsion','B2');
    else
%         if(exist([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\subcluster\Distortion\'],'dir')==0)
%             mkdir([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\subcluster\Distortion\']);
%         end
%         xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\subcluster\Distortion\','BP_',TEST,'_Distortion_SubCluster_',DepO,'_DepT_',DepT,'.csv'],ClusterDistortion);
        xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.xls'],col_header,'BP_Distorsion_SubC','A1');
        xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.xls'],row_header','BP_Distorsion_SubC','A2');
        xlswrite([path,'Features_',FeaturesRM,'\',TEST,'\Accuracy\Distortion\',TEST,'_Distortion_',DepO,'_DepT_',DepT,'.xls'],ClusterDistortion,'BP_Distorsion_SubC','B2');
    end
end

