
FeaturePath = 'D:\MOTIF Discovery\Code\RMT_Sicong\Dataset\EnergyDataset\MultiStory\Aggregate\Features\FeatureTest1\';
KindOfDataset = 'MultiFeatures\';%SyntDatasetFromSinglefeature\;
DestDataPath = ['D:\Motif_Results\FeatureSyntDataset\',KindOfDataset];
TS_name = num2str(1);

nummotifs = 5;
NumInstances=100;
savepath1 = [FeaturePath,'feature_',TS_name,'.mat'];
savepath2 = [FeaturePath,'idm_',TS_name,'.mat'];
savepath3 = [FeaturePath,'MetaData_',TS_name,'.mat'];
load(savepath1);
load(savepath2);
load(savepath3);
%% get some features k
indexfeatureGroup = (frame1(6,:)==2 & frame1(5,:)==2);
X=frame1(:,indexfeatureGroup);
[rows,colmn]= size(X);
random= randi([1,colmn],1,nummotifs);

MotifsFeatures = X(:,random);
dpscale = csvread(strcat(FeaturePath,'DistancesDescriptors\DepdScale_IM_',TS_name,'_DepO_',num2str(2),'_TimeO_',num2str(2),'.csv'));
motifdpscale= dpscale(:,random);

[datarows,datacoln]= size(data);
[rows,colmn]= size(MotifsFeatures);
A = MotifsFeatures;
B =motifdpscale;
timescope= A(4,:)*3;

% rndWalks = rndWalkGeneration(size(data,1),size(data,2)); %%geerate random walk z-normalized
rndWalks=csvread([DestDataPath,'rndData.csv']);
origRW=rndWalks;
% csvwrite([DestDataPath,'rndData.csv'],origRW);

FeatPositions=zeros(NumInstances,3);
% for i=1: size(A,2)
 Step= floor(datacoln /NumInstances);
 pStep=0;
for ii =1:NumInstances
    ii
    i= randi([1,size(A,2)],1,1);
    intervaltime=(round((A(2,i)-timescope(i))) : (round((A(2,i)+timescope(i)))));
    motifData = data(:,intervaltime((intervaltime>0 & intervaltime<=size(data,2))));%data(B(B(:,i)>0,i),intervaltime((intervaltime>0 & intervaltime<=size(data,2))));
    [~,motifclmn]=size(motifData);
   
   
    
    starter = randi([pStep,pStep+Step-motifclmn],1,1);
    FeatPositions(ii,:)=[i,starter,starter+motifclmn-1];
    rndWalks(B((B(:,i)>0),i),starter:starter+motifclmn-1) = data(B(B(:,i)>0,i),intervaltime((intervaltime>0 & intervaltime<=size(data,2))));
    pStep=pStep+Step;
end
% end
csvwrite([DestDataPath,'Embeddedfeature.csv'],rndWalks);

csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','FeaturePosition.csv'],FeatPositions);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','dpscale.csv'],B);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','FeaturesEmbedded.csv'],A);


