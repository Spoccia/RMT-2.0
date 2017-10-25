

path = 'D:\MOTIF Discovery\Code\RMT_Sicong\Dataset\EnergyDataset\MultiStory\Aggregate\Features\FeatureTest2\DistancesDescriptors\Cluster_Fixed\Descriptor\afterPruning\ClusterMatlab\';
destPath='D:\Motif_Results\Dataset_Synt\SinlgeMotif\';
octaveD = 2;
octaveT = 2;
TS_name = 1;
load ([path,'datacluster_',num2str(TS_name),'_DepO_',num2str(octaveD),'_DepT_',num2str(octaveT),'.mat']);
TS_size = size(dataid(:,:,:));
 rndWalks = csvread([destPath,'test1_original.csv']);%=rndWalkGeneration(TS_size(1,1),TS_size(1,2)); %%geerate random walk z-normalized
 csvwrite([destPath,'test1_original.csv'],rndWalks);
  TS_Motif_Added_ALL=rndWalks;
for depT =1 : octaveT
    for depD = 1 : octaveD
        load ([path,'datacluster_',num2str(TS_name),'_DepO_',num2str(depD),'_DepT_',num2str(depT),'.mat']);
        TS_size = size(dataid(:,:,:));
        
       
        idx= zeros(size(dataid(:,:,:)));
        TS_Motif_Added=rndWalks;
        featuresPruned= csvread([path,'PrunedFeatures_IM_',num2str(TS_name),'_DepO_',num2str(depD),'_DepT_',num2str(depT),'.csv']);
        cluster = csvread([path,'PrunedCluster_IM_',num2str(TS_name),'_DepO_',num2str(depD),'_DepT_',num2str(depT),'.csv']);
        csvwrite([destPath,'FeaturesEmbedded_GT\EmbeddedFeatures_IM_',num2str(TS_name),'_DepO_',num2str(depD),'_DepT_',num2str(depT),'.csv'],featuresPruned);
        csvwrite([destPath,'FeaturesEmbedded_GT\ClusterLabel_',num2str(TS_name),'_DepO_',num2str(depD),'_DepT_',num2str(depT),'.csv'],cluster);
        i=1;
        %for i= 1: TS_size(1,3)
            localmotifs_data = dataid(:,:,i);
            idx(:,:,i) = (localmotifs_data ~= 0);
            
            %     %% znormalize  the  motifs
            %
            %     motif =zNormalizeMotif(localmotifs_data);
            %     localmotifs_data(localmotifs_data ~= 0)=motif;
            TS_Motif_Added (localmotifs_data ~= 0)= localmotifs_data(localmotifs_data ~= 0);
            TS_Motif_Added_ALL(localmotifs_data ~= 0)= localmotifs_data(localmotifs_data ~= 0);
        %end
        csvwrite([destPath,'test2_EmbedMotif','_DepO_',num2str(depD),'_DepT_',num2str(depT),'.csv'],TS_Motif_Added);
    end
end
csvwrite([destPath,'test2_EmbedMotif_ALL','.csv'],TS_Motif_Added_ALL);
% load([path,'Series_Feature_Pruned_',num2str(TS_name),'_DepO_',num2str(octaveD),'_DepT_',num2str(octaveT),'.mat']);
% cluster = csvread([path,'PrunedCluster_IM_',num2str(TS_name),'_DepO_',num2str(octaveD),'_DepT_',num2str(octaveT),'.csv']);
% featuresPruned= csvread([path,'PrunedFeatures_IM_',num2str(TS_name),'_DepO_',num2str(octaveD),'_DepT_',num2str(octaveT),'.csv']);
