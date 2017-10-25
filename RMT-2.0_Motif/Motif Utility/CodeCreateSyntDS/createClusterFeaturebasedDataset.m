
FeaturePath = 'D:\Motif_ResultsCleaning\Datasets\Energy\Energy_Aggregate\Features\FeatureTest1\';
kindofCluster='ClusterMatlab';
clusterAddPath=['DistancesDescriptors\Cluster_Fixed\Descriptor\'];
PrunedFeatureADDPAth=[FeaturePath,clusterAddPath,'afterPruning\',kindofCluster,'\'];
KindOfDataset = 'CosineTS_MultiFeatureDiffClusters\';%'FlatTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';%'MultiFeatures\';%SyntDatasetFromSinglefeature\;
ClusterPath=[FeaturePath,clusterAddPath,kindofCluster,'\'];
loadfromCluster='Pruned_Cluster';%'notPruned';
kindofBasicTS='randomWalk';%'Sinusoidal';%'flat';%
if(strcmp(kindofBasicTS,'flat')==1)
    KindOfDataset='FlatTS_MultiFeatureDiffClusters\';
elseif(strcmp(kindofBasicTS,'Sinusoidal')==1)
    KindOfDataset = 'CosineTS_MultiFeatureDiffClusters\';%
elseif(strcmp(kindofBasicTS,'randomWalk')==1)
    KindOfDataset = 'RandomWalkTS_MultiFeatureDiffClusters\';%
end
DestDataPath = ['D:\Motif_ResultsCleaning\Datasets\FeatureSyntDataset\',KindOfDataset];
sinFreq=1;
TEST = 'FeatureTest2';
TS_name = num2str(1);
DepO=2;
DepT=2;
offSpace=0;

nummotifs = 2;
numFeatureforClass=2;%1;
NumInstances=40;
dpscale=[];
frame1=[];
%if(strcmp(loadfromCluster,'notPruned')==1)
    savepath1 = [FeaturePath,'feature_',TS_name,'.mat'];
    savepath2 = [FeaturePath,'idm_',TS_name,'.mat'];
    savepath3 = [FeaturePath,'MetaData_',TS_name,'.mat'];
    load(savepath1);
    load(savepath2);
    load(savepath3);
    %else
if(strcmp(loadfromCluster,'Pruned_Cluster')==1)
    frame1=csvread([PrunedFeatureADDPAth,'PrunedFeatures_IM_',TS_name,'_DepO_',num2str(DepO),'_DepT_',num2str(DepT),'.csv']);
    dpscale=csvread([PrunedFeatureADDPAth,'PrunedDepScaleFeatures_IM_',TS_name,'_DepO_',num2str(DepO),'_DepT_',num2str(DepT),'.csv']);
end
%% get some features k
indexfeatureGroup = (frame1(6,:)==2 & frame1(5,:)==2);
X=frame1(:,indexfeatureGroup);
[rows,colmn]= size(X);
random= randi([1,colmn],1,nummotifs);
%% read Clusters
C=[];
m=[];
if(strcmp(loadfromCluster,'notPruned')==1)
    C = csvread(strcat(ClusterPath,'\Cluster_IM_',TS_name,'_DepO_',num2str(DepO),'_TimeO_',num2str(DepT),'.csv'));
    mu = csvread(strcat(ClusterPath,'\Centroids_IM_',TS_name,'_DepO_',num2str(DepO),'_TimeO_',num2str(DepT),'.csv'));
elseif(strcmp(loadfromCluster,'Pruned_Cluster')==1)
    C = csvread([PrunedFeatureADDPAth,'PrunedCluster_IM_',TS_name,'_DepO_',num2str(DepO),'_DepT_',num2str(DepT),'.csv']);
    mu = csvread([PrunedFeatureADDPAth,'Centroids_IM_',TS_name,'_DepO_',num2str(DepO),'_DepT_',num2str(DepT),'.csv']);
end
clusterLabel = unique(C);
nCluster     = length(clusterLabel);
%     dpscale = csvread(strcat(FeaturePath,'DistancesDescriptors\DepdScale_IM_',TS_name,'_DepO_',num2str(DepO),'_TimeO_',num2str(DepT),'.csv'));
MotifsFeatures=[];
motifdpscale=[];
if nummotifs > nCluster
    nummotifs=nCluster;
end
for ii=1:nummotifs
    A = X(:, C == clusterLabel(ii));
    B =dpscale(:,C == clusterLabel(ii));
    [rows,colmn]= size(A);
    random= randi([1,colmn],1,numFeatureforClass);
    MotifsFeatures=[MotifsFeatures,A(:,random)];
    motifdpscale= [motifdpscale,B(:,random)];
    
end
%MotifsFeatures = X(:,random);
%motifdpscale= dpscale(:,random);

[datarows,datacoln]= size(data);
[rows,colmn]= size(MotifsFeatures);
A = MotifsFeatures;
B =motifdpscale;
timescope= A(4,:)*3;%+offSpace;


if(strcmp(kindofBasicTS,'randomWalk')==1)
     rndWalks = rndWalkGeneration(size(data,1),size(data,2)); %%geerate random walk z-normalized
     for variateifdx=1: size(data,1)
        A_max = max(data(variateifdx,:));
        A_min = min(data(variateifdx,:));
        Rw_max=max(rndWalks(variateifdx,:));
        Rw_min=min(rndWalks(variateifdx,:));
        rndWalks(variateifdx,:)= (A_max-A_min)* ((rndWalks(variateifdx,:)-Rw_min)/(Rw_max-Rw_min))+A_min;
     end
    %rndWalks=csvread([DestDataPath,'rndData.csv']);
elseif(strcmp(kindofBasicTS,'Sinusoidal')==1)
    T_sin =size(data,2);
    f_sin=1/(sinFreq*T_sin);
    t_sin=1:size(data,2);
    rndWalks=zeros(size(data,1),size(data,2));
    for variateifdx=1: size(data,1)
      A_sin =max(data(variateifdx,:));
      SV_SinTS= A_sin*sin(2*pi*f_sin*t_sin);  
      rndWalks(variateifdx,:)= SV_SinTS(1,:);
      figure
      plot(SV_SinTS);
     
    end
%     A_sin =1;
%     SV_SinTS= A_sin*sin(2*pi*f_sin*t_sin);
%     plot(SV_SinTS);
%     rndWalks= repmat(SV_SinTS,[size(data,1),1]);
elseif(strcmp(kindofBasicTS,'flat')==1)
    
    rndWalks=zeros(size(data,1),size(data,2));
    for variateifdx=1: size(data,1) 
      A_max = max(data(variateifdx,:));
      A_min = min(data(variateifdx,:));
      A_avg = (A_max + A_min )/2; %A_sin*sin(2*pi*f_sin*t_sin);  
      rndWalks(variateifdx,:)= ones(1,size(data,2))* A_avg ;%SV_SinTS(1,:);     
    end
    %rndWalks = zeros(size(data,1),size(data,2));
end
origRW=rndWalks;


FeatPositions=zeros(NumInstances,4);
% for i=1: size(A,2)
Step= floor(datacoln /NumInstances);
pStep=0;
for ii =1:NumInstances
    
    i= randi([1,size(A,2)],1,1);
    intervaltime=(round((A(2,i)-timescope(i))) : (round((A(2,i)+timescope(i)))));
    motifData = data(:,intervaltime((intervaltime>0 & intervaltime<=size(data,2))));%data(B(B(:,i)>0,i),intervaltime((intervaltime>0 & intervaltime<=size(data,2))));
    [~,motifclmn]=size(motifData);
    
    starter = randi([pStep,pStep+Step-motifclmn],1,1);
    FeatPositions(ii,:)=[ceil(i/numFeatureforClass),i,starter,starter+motifclmn-1];
    if (offSpace ~=0)
        intervaltime=(round((A(2,i)-timescope(i)-offSpace)) : (round((A(2,i)+timescope(i)+offSpace))));
        motifData = data(:,intervaltime((intervaltime>0 & intervaltime<=size(data,2))));%data(B(B(:,i)>0,i),intervaltime((intervaltime>0 & intervaltime<=size(data,2))));        
        [~,motifclmn]=size(motifData);
        starter = randi([pStep,pStep+Step-motifclmn],1,1);
    end
    if(strcmp(kindofBasicTS,'randomWalk')==1 | strcmp(kindofBasicTS,'flat')==1)
        rndWalks(B((B(:,i)>0),i),starter:starter+motifclmn-1) = data(B(B(:,i)>0,i),intervaltime((intervaltime>0 & intervaltime<=size(data,2))));
    elseif(strcmp(kindofBasicTS,'Sinusoidal')==1)       
       rndWalks(B((B(:,i)>0),i),starter:starter+motifclmn-1)  = data(B(B(:,i)>0,i),intervaltime((intervaltime>0 & intervaltime<=size(data,2))));       %rndWalks(B((B(:,i)>0),i),starter:starter+motifclmn-1) + data(B(B(:,i)>0,i),intervaltime((intervaltime>0 & intervaltime<=size(data,2))));       
    end
    pStep=pStep+Step;
end
% end
 if(exist([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\'],'dir')==0)
    mkdir([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\']);
 end    
csvwrite([DestDataPath,'Embeddedfeature_',TEST,'.csv'],rndWalks);
csvwrite([DestDataPath,'rndData_',TEST,'.csv'],origRW);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','FeaturePosition_',TEST,'.csv'],FeatPositions);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','dpscale_',TEST,'.csv'],B);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','FeaturesEmbedded_',TEST,'.csv'],A);


