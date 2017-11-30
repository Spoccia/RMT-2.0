close all;
clc;
clear;

SubDSPath='data\';%'FlatTS_MultiFeatureDiffClusters\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
datasetPath= 'D:\Motif_Results\Datasets\Mocap\';
subfolderPath= '';%'Z_A_Temp_C\';%
FeaturesRM ='RMT';%'RME';%

% Path Parameters
TEST ='1';%
typeofCluster='ClusterMatlab';
distanceUsed='Descriptor';%'Amplitude_Descriptor';%
SizeofK= 'Fixed';
TS_name=TEST;
imagename=TS_name;
        saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\'];
        
        savepath1 = [saveFeaturesPath,'feature_',TS_name,'.mat'];
        savepath2 = [saveFeaturesPath,'idm_',TS_name,'.mat'];
        savepath3 = [saveFeaturesPath,'MetaData_',TS_name,'.mat'];
        ClusterPath = [saveFeaturesPath,'DistancesDescriptors\Cluster_',SizeofK,'\',distanceUsed,'\',typeofCluster];
%         ImageSavingPath=[saveFeaturesPath,'DistancesDescriptors\Cluster_',K_valuesCalc,'\',distanceUsed,'\BP_Kmeans_CosineDescriptor'];%\imageMotifs\',imagename];
%         RebSeriesPath = [saveFeaturesPath,'DistancesDescriptors\Cluster_',K_valuesCalc,'\',distanceUsed,'\BP_Kmeans_CosineDescriptor\rebClusters\'];
        load(savepath1);
        load(savepath2);
        load(savepath3);
        THforDependency=0.5;
 for k=2:DeOctTime
    for j=2:DeOctDepd
        if(exist(strcat(ClusterPath,'\Cluster_IM_',imagename,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),'file')~=0)
            indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);
            X=frame1(:,indexfeatureGroup);
            dpscale = csvread(strcat(saveFeaturesPath,'DistancesDescriptors\DepdScale_IM_',imagename,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));
            C = csvread(strcat(ClusterPath,'\Cluster_IM_',imagename,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));
            mu = csvread(strcat(ClusterPath,'\Centroids_IM_',imagename,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));
            clusterLabel = unique(C);
            nCluster     = length(clusterLabel);
            for ii=1:nCluster
                    A = X(:, C == clusterLabel(ii));
                    B =dpscale(:,C == clusterLabel(ii));
                    timescope= A(4,:)*3;
                    Dep_Overlapping=zeros(size(A,2));
                    for iii=1:size(A,2)
                        for iiii =iii:size(A,2)
                            Dep_Overlapping(iii,iiii)= (size(intersect(B(:,iii),B(:,iiii)),1)-1)/(size(union(B(:,iii),B(:,iiii)),1)-1);
                            Dep_Overlapping(iiii,iii)=Dep_Overlapping(iii,iiii);
                        end
                    end
                    idx_dep_overlapping= Dep_Overlapping>THforDependency;
                    idxmax=max(sum(idx_dep_overlapping));
                    A1=A(:,idx_dep_overlapping(idxmax,:));
                    B1=B(:,idx_dep_overlapping(idxmax,:));
                    timescope1=A1(4,:)*3;
            end
        end
    end
 end