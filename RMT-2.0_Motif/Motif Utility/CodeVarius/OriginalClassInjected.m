%% Original cluster class
path='D:\Motif_Results\FeatureSyntDataset\';
kindofinj='FlatTS_MultiFeatureDiffClusters\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
TEST = 'FeatureTest9';
kindofCluster='Cluster_Fixed\';
measure='Descriptor';
ClusterAlg = 'ClusterMatlab';

data = csvread([path,kindofinj,'Embeddedfeature_',TEST,'.csv']);
Position_F_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','FeaturePosition_',TEST,'.csv']);
Feature_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','FeaturesEmbedded_',TEST,'.csv']);
Dependency_Injected = csvread([path,kindofinj,'IndexEmbeddedFeatures\','dpscale_',TEST,'.csv']);

[q,I] = sort(Position_F_Injected(:,2));
Position_F_Injected = Position_F_Injected(I,:);
clusterLabel = unique(Position_F_Injected(:,1));
classnumber=length(clusterLabel);

actualClass=clusterLabel(1,1);
Globaldata=zeros(size(data,1),size(data,2),classnumber);
classfeatures=zeros(size(data,1),size(data,2));
for i=1:size(Position_F_Injected,1)
    checkclass=Position_F_Injected(i,1);
    if (checkclass==actualClass)
        %% add feature in the class 
        ActualFeatureID = Position_F_Injected(i,2);
        ActualVariates = Dependency_Injected(:,ActualFeatureID);
        classfeatures(Dependency_Injected((Dependency_Injected(:,ActualFeatureID)>0),ActualFeatureID),Position_F_Injected(i,3):Position_F_Injected(i,4))=...
                 data(Dependency_Injected((Dependency_Injected(:,ActualFeatureID)>0),ActualFeatureID),Position_F_Injected(i,3):Position_F_Injected(i,4));
    else    
         Globaldata(:,:,actualClass) =    classfeatures;
         classfeatures =zeros(size(data,1),size(data,2));
         actualClass =clusterLabel(actualClass+1,1);
         
         ActualFeatureID = Position_F_Injected(i,2);
         ActualVariates = Dependency_Injected(:,ActualFeatureID);
         classfeatures(Dependency_Injected((Dependency_Injected(:,ActualFeatureID)>0),ActualFeatureID),Position_F_Injected(i,3):Position_F_Injected(i,4))=...
                 data(Dependency_Injected((Dependency_Injected(:,ActualFeatureID)>0),ActualFeatureID),Position_F_Injected(i,3):Position_F_Injected(i,4));
    end
end
Globaldata(:,:,actualClass) =    classfeatures;
save ([path,kindofinj,'Embeddedfeature_',TEST,'.mat'],'Globaldata');