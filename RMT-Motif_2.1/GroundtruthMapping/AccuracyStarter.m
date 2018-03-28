clc; clear;

path='D:\Motif_Results\Datasets\SynteticDataset\';
dataLocation='data\';

Num_SyntSeries=1; % num of instances of one motif
Name_OriginalSeries = [35,85,127,24]; % name of the original  series from with we  got the  motif instances to inject
percentagerandomwalk=0.75;%1;%0; %0.1;%0.5;%
StrategyClustering= 1;%3;%2;%
DepO =2;
DepT =2;
for pip=2:2
    for NAME = 1:Num_SyntSeries
        
        TEST=['Motif1_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME),'_',num2str(percentagerandomwalk)];
%            ['Motif1_',num2str(pippo(pip)),'_instance_',num2str(NAME)]  %['MoCap',num2str(NAME)]

        FeaturesRM ='RMT';%'RMT';%
        kindOfClustring= 'AKmeans'; % the algorithm of clustering to use
        distanceUsed='Descriptor';% use just descriptors to  cluster
        ClusterAlg = ['ClusterStrategy_',num2str(StrategyClustering)];
        subfolderClusterLabel='Clusterlabel\ClusterLabel_';
        DepO=num2str(2);
        DepT=num2str(2);
        
%         for DepO =2:2
%             for DepT =2:2
                
                
                AP_allfeatures(path,dataLocation,TEST,FeaturesRM,kindOfClustring,distanceUsed,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT));
                if StrategyClustering==3
                    AP_allfeatures_subcluster(path,dataLocation,TEST,FeaturesRM,kindOfClustring,distanceUsed,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT));
                end
                %         for AfterPruning =0:1
                %             for subcluster=0:1
                %                 Distortion_Clusters(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT),AfterPruning,subcluster);
                %             end
                %         end
                
%             end
%         end
    end
end