clear;
clc;
for name =60 : 66%10:15%

TS = randi([1,184],1,1);
 FeaturePath = ['D:\Motif_Results\Datasets\Mocap\Features_RMT\',num2str(TS),'\'];
% FeaturePath = ['D:\Motif_Results\Datasets\Building_MultiStory\Features_RMT\',num2str(TS),'\'];

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
% TEST = ['Energy_test',num2str(name)];

TS_name = num2str(TS);

TimeL =1500;

DepO=2;
DepT=2;
offSpace=0;

nummotifs = 3;
% numfeaturestoInject = 1;
%numFeatureforClass=2;%1;
NumInstances=20;
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
IndexBadFeatures = sum(X(11:end,:)>0)>=65 & sum(X(11:end,:)>0)<=98;
X= X(:,IndexBadFeatures);
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
    [rndWalks,rndWalks1] = rndWalkGenerationbigSize(size(data,1),TimeL,data);
end
% rndWalks1([34,46],:) = rndWalks([34,46],:);

origRW   = rndWalks;
origRW1  = rndWalks1;
IDMotifInject=[1,2,1,2,2,1,1,2,1,1,2,2,2,1,2,1,2,1,2,1];


FeatPositions=zeros(NumInstances,4);
Step= floor( TimeL/NumInstances);
pStep=0;
startInj=15;
% startInj=[30,35,40];
% percentage of scaling over time;

percentageTimeScaling = [0.5,0.75,1,0.5,0.75,1,0.5,0.75,1,1,0.5,0.75,1,0.5,0.75,1,0.5,0.75,1,1];
EachInstanceDependency=[];
for ii =1:NumInstances
    
    i= IDMotifInject(ii);%randi([1,size(A,2)],1,1);%
    intervaltime=(round((A(2,i)-timescope(i))) : (round((A(2,i)+timescope(i)))));
    motifData = data(:,intervaltime((intervaltime>0 & intervaltime<=size(data,2))));
    [~,motifclmn]=size(motifData);
    EachInstanceDependency= [EachInstanceDependency,B(:,i)];
    
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
        indexScaling = percentageTimeScaling(ii);%randi([1,3],1,1);
        scalingTime = round(size(M,2)*indexScaling);
%%                scale to random walk
        valueRND  = rndWalks1(:,starter);
        valueM = motifData(:,1);
        ScaledM1=M;
        scaleValues = valueM - valueRND;
        for variateiterate = 1: length(valueM);
            ScaledM1(variateiterate,:) = motifData(variateiterate,:)-scaleValues(variateiterate);
        end
        ScaledM1 = imresize(ScaledM1,[size(ScaledM1,1), scalingTime]);
        
        %% resize the injected feature of time %
        [rows,cols]  = size(M);
        
        M1 = imresize(M,[size(M,1), scalingTime]);
        
        FeatPositions(ii,:)=[i,ii,starter,starter+scalingTime];
        
        rndWalks(B((B(:,i)>0),i),starter:starter+scalingTime-1) = M1(B(B(:,i)>0,i),:);%motifData(B(B(:,i)>0,i),:);
        rndWalks1(B((B(:,i)>0),i),starter:starter+scalingTime-1) = ScaledM1(B(B(:,i)>0,i),:);%motifData(B(B(:,i)>0,i),:);
    elseif(strcmp(kindofBasicTS,'Sinusoidal')==1)       
       rndWalks(B((B(:,i)>0),i),starter:starter+motifclmn-1)  = motifData(B(B(:,i)>0,i),:);       
    end
    pStep=pStep+Step;
end

randomwalklottlabig = rndWalks;
for i=1:nummotifs
    randomwalklottlabig(B((B(:,i)>0),i),:) = rndWalks1(B((B(:,i)>0),i),:);
end


if(exist([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\'],'dir')==0)
    mkdir([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\']);
    mkdir([DestDataPath,'\IndexEmbeddedFeatures\Energy_test',num2str(name+6),'\']);
%     mkdir([DestDataPath,'\IndexEmbeddedFeatures\Mocap_test',num2str(name+6),'\']);
 end    
csvwrite([DestDataPath,'\',TEST,'.csv'],rndWalks);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','rndData_',TEST,'.csv'],origRW);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','FeaturePosition_',TEST,'.csv'],FeatPositions);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','dpscale_',TEST,'.csv'],EachInstanceDependency);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\',TEST,'\','FeaturesEmbedded_',TEST,'.csv'],A);

% csvwrite([DestDataPath,'\Mocap_test',num2str(name+6),'.csv'],randomwalklottlabig);
% csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','rndData_Mocap_test',num2str(name+6),'.csv'],origRW1);
% csvwrite([DestDataPath,'\IndexEmbeddedFeatures\Mocap_test',num2str(name+6),'\','FeaturePosition_Mocap_test',num2str(name+6),'.csv'],FeatPositions);
% csvwrite([DestDataPath,'\IndexEmbeddedFeatures\Mocap_test',num2str(name+6),'\','dpscale_Mocap_test',num2str(name+6),'.csv'],EachInstanceDependency);
% csvwrite([DestDataPath,'\IndexEmbeddedFeatures\Mocap_test',num2str(name+6),'\','FeaturesEmbedded_Mocap_test',num2str(name+6),'.csv'],A);

csvwrite([DestDataPath,'\Energy_test',num2str(name+6),'.csv'],randomwalklottlabig);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\','rndData_Energy_test',num2str(name+6),'.csv'],origRW1);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\Energy_test',num2str(name+6),'\','FeaturePosition_Energy_test',num2str(name+6),'.csv'],FeatPositions);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\Energy_test',num2str(name+6),'\','dpscale_Energy_test',num2str(name+6),'.csv'],EachInstanceDependency);
csvwrite([DestDataPath,'\IndexEmbeddedFeatures\Energy_test',num2str(name+6),'\','FeaturesEmbedded_Energy_test',num2str(name+6),'.csv'],A);

end




