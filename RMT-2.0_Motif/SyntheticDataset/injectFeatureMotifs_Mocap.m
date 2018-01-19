clear;
clc;
for name =28 : 33
FeaturePath = 'D:\Motif_Results\Datasets\Mocap\Features_RMT\1\';
kindofBasicTS='randomWalk';%'Sinusoidal';%'flat';%
if(strcmp(kindofBasicTS,'flat')==1)
    KindOfDataset='FlatTS_MultiFeatureDiffClusters\';
elseif(strcmp(kindofBasicTS,'Sinusoidal')==1)
    KindOfDataset = 'CosineTS_MultiFeatureDiffClusters\';%
elseif(strcmp(kindofBasicTS,'randomWalk')==1)
    KindOfDataset = 'RandomWalkTS_MultiFeatureDiffClusters\';%
end
DestDataPath = 'D:\Motif_Results\Datasets\SynteticDataset\data';
DestLocationPath = 'D:\Motif_Results\Datasets\SynteticDataset\location';
sinFreq=1;
TEST = ['Mocap_test',num2str(name)];

TS_name = num2str(1);

DepO=2;
DepT=2;
offSpace=0;

nummotifs = 5;
% numfeaturestoInject = 1;
%numFeatureforClass=2;%1;
NumInstances=15;
dpscale=[];
frame1=[];


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

dpscale = csvread(strcat(FeaturePath,'DistancesDescriptor\DepdScale_IM_',TS_name,'_DepO_',num2str(DepO),'_TimeO_',num2str(DepT),'.csv'));

MotifsFeatures=[];
motifdpscale=[];

for ii=1:nummotifs
    A = X(:, random(ii));
    B =dpscale(:,random(ii));
    MotifsFeatures=[MotifsFeatures,A];
    motifdpscale= [motifdpscale,B];
end

[datarows,datacoln]= size(data);
[rows,colmn]= size(MotifsFeatures);
A = MotifsFeatures;
B = motifdpscale;
timescope= A(4,:)*3;%+offSpace;

if(strcmp(kindofBasicTS,'randomWalk')==1)
%      rndWalks= rndWalkGeneration(size(data,1),size(data,2)); %%geerate random walk z-normalized
    [rndWalks,rndWalks1] = rndWalkGenerationbigSize(size(data,1),1000,data);
end
rndWalks1([34,46],:) = rndWalks([34,46],:);

origRW   = rndWalks;
origRW1  = rndWalks1;



FeatPositions=zeros(NumInstances,4);
Step= floor(1000 /NumInstances);
pStep=0;
startInj=30;
% startInj=[30,35,40];
% percentage of scaling over time;

percentageTimeScaling = [0.5,0.75,1,0.5,0.75,1,0.5,0.75,1,1];

for ii =1:NumInstances
    
    i= randi([1,size(A,2)],1,1);
    intervaltime=(round((A(2,i)-timescope(i))) : (round((A(2,i)+timescope(i)))));
    motifData = data(:,intervaltime((intervaltime>0 & intervaltime<=size(data,2))));
    [~,motifclmn]=size(motifData);
    
    starter = pStep+startInj;%randi([pStep,pStep+Step-motifclmn],1,1);

    %FeatPositions(ii,:)=[];%[i,A(2,i),starter,starter+motifclmn-1];
    if (offSpace ~=0)
        intervaltime=(round((A(2,i)-timescope(i)-offSpace)) : (round((A(2,i)+timescope(i)+offSpace))));
        motifData = data(:,intervaltime((intervaltime>0 & intervaltime<=size(data,2))));       
        [~,motifclmn]=size(motifData);
        starter = randi([pStep,pStep+Step-motifclmn],1,1);
    end
    if(strcmp(kindofBasicTS,'randomWalk')==1 | strcmp(kindofBasicTS,'flat')==1)

        M=motifData;
%%                scale to random walk
%         valueRND  = rndWalks1(:,starter);
%         valueM = motifData(:,1);
%         
%         scaleValues = valueM - valueRND;
%         for variateiterate = 1: length(valueM);
%             M(variateiterate,:) = motifData(variateiterate,:)-scaleValues(variateiterate);
%         end
        %% resize the injected feature of time %
        [rows,cols]  = size(M);
        indexScaling = percentageTimeScaling(ii);%randi([1,3],1,1);
        scalingTime = round(size(M,2)*indexScaling);
        M1 = imresize(M,[size(M,1), scalingTime]);
        FeatPositions(ii,:)=[i,ii,starter,starter+scalingTime];
        
        rndWalks1(B((B(:,i)>0),i),starter:starter+scalingTime-1) = M1(B(B(:,i)>0,i),:);%motifData(B(B(:,i)>0,i),:);
    elseif(strcmp(kindofBasicTS,'Sinusoidal')==1)       
       rndWalks(B((B(:,i)>0),i),starter:starter+motifclmn-1)  = motifData(B(B(:,i)>0,i),:);       
    end
    pStep=pStep+Step;
end

for i=1:nummotifs
    rndWalks(B((B(:,i)>0),i),:) = rndWalks1(B((B(:,i)>0),i),:);
end


if(exist([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\'],'dir')==0)
    mkdir([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\']);
 end    
csvwrite([DestDataPath,'\',TEST,'.csv'],rndWalks);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','rndData_',TEST,'.csv'],origRW);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','FeaturePosition_',TEST,'.csv'],FeatPositions);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','dpscale_',TEST,'.csv'],B);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','FeaturesEmbedded_',TEST,'.csv'],A);
end