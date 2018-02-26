clc;
clear;
RW_varaiteSize = 62;
RW_timelength  = 2500;
NormInterval=[zeros(62,1),ones(62,1)];

DestDataPath = 'D:\Motif_Results\Datasets\SynteticDataset\data\RW_0_1\';

numInstances= 20;
znorm=0; % 0 not znormalization; 1 do a znormalization
if(exist(DestDataPath,'dir')==0)
    mkdir(DestDataPath);
end
for idRW = 1:numInstances
    RW= random_walk_Mueen(RW_timelength,RW_varaiteSize);
    RW=NormalizeRandomWalk(RW,NormInterval,znorm);
    
    csvwrite([DestDataPath,'RW_',num2str(idRW),'.csv'],RW);
end

