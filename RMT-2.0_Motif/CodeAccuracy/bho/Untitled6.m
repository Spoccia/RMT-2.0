clc; clear;

path='D:\Motif_Results\Datasets\SynteticDataset\';
kindofinj='data\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
pippo = [24,35,85,127];
for pip=1:4
for NAME = 1:10%40%100:105%46:57%61:72%46:46%57%1:33%22:33%16:21%:21
% TEST = ['Mocap_test',num2str(NAME)]%'Mocap_test11';
 TEST=['Motif2_',num2str(pippo(pip)),'_instance_',num2str(NAME)]  %['MoCap',num2str(NAME)]
FeaturesRM ='RMT';%'RME';%
kindofCluster='Cluster_AKmeans';%'ClusterMatlab';%'ClusterKmedoids';%
measure='Descriptor';
ClusterAlg = 'ClusterMatlab';
subfolderClusterLabel='Clusterlabel\ClusterLabel_';
DepO=num2str(2);
DepT=num2str(2);

for DepO =2:2
    for DepT =2:2
        %% BP All Featrures
%         BP_allfeatures(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT));
%         BP_allfeatures_subcluster(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT));

%         BP_MAX_OverlappingInTime(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT));
%         BP_MAX_OverlappingInTime_subcluster(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT));
   
        AP_allfeatures(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT));
        AP_allfeatures_subcluster(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT));

%         AP_MAX_OverlappingInTime(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT));
%         AP_MAX_OverlappingInTime_subcluster(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT));
        
        for AfterPruning =0:1
            for subcluster=0:1
                Distortion_Clusters(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT),AfterPruning,subcluster);
            end
        end
        
    end
end
end
end