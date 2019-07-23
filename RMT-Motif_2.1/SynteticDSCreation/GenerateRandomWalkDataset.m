clc;
clear;
RW_varaiteSize =13;%'BSONG' %27;%Energy %62; %ASL %62;%Mocap
RW_timelength  = 2500;
NormInterval=[zeros(RW_varaiteSize,1),ones(RW_varaiteSize,1)];
Dset='BirdSong';%'Energy';%'Mocap';%Bird Song %'ASL';%'data';%for Mocap
DatasetDataPath=['D:\Motif_Results\Datasets\',Dset,'\data\'];
sizeDS= 184;
Vnumber= 62;
if strcmp(Dset,'BirdSong')
sizeDS= 154;
Vnumber= 13;
elseif strcmp(Dset,'Energy')
    sizeDS=100;
    Vnumber= 27;
end
DS_Statistics=zeros(sizeDS,Vnumber,5);
for i=1:sizeDS
    data= csvread([DatasetDataPath,num2str(i),'.csv']);
    if strcmp(Dset,'Energy')
        data=data';
    end
    if isnan(sum(data(:)))==1
        'nan'
    else
    DS_Statistics(i,:,1)=min(data);
    DS_Statistics(i,:,2)=max(data);
    DS_Statistics(i,:,3)=std(data); 
    DS_Statistics(i,:,4)=mean((abs(data(1:end-1,:)-data(2:end,:)))); % AVG Displacement
    DS_Statistics(i,:,5)=(DS_Statistics(i,:,1)+DS_Statistics(i,:,2))/2;  % AVG timeseries
    end
end
%% this are the rules
DsAVG_statistics=zeros(5,Vnumber);
for i=1:5
    DsAVG_statistics (i,:)= mean(DS_Statistics(:,:,i));
end
DestDataPath = ['D:\Motif_Results\Datasets\SynteticDataset\',Dset,'\RW_0_1\'];
numInstances= 10;
if(exist(DestDataPath,'dir')==0)
    mkdir(DestDataPath);
end
for idRW= 1:numInstances
    RW= MV_random_walk_Mueen(RW_timelength,Vnumber,DsAVG_statistics);
    
end
% DestDataPath = ['D:\Motif_Results\Datasets\SynteticDataset\',Dset,'\RW_0_1\'];
% 
% numInstances= 10;
% znorm=0; % 0 not znormalization; 1 do a znormalization
% if(exist(DestDataPath,'dir')==0)
%     mkdir(DestDataPath);
% end
% 
% for idRW = 1:numInstances
%     RW= random_walk_Mueen(RW_timelength,RW_varaiteSize);
%     RW=NormalizeRandomWalk(RW,NormInterval,znorm);
%     
%     csvwrite([DestDataPath,'RW_',num2str(idRW),'.csv'],RW);
% end

