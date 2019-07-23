clc; clear;
warning off;
DS_List ={'Energy','Mocap','BirdSong'};
numInstancesinjected=10;
featurespath='FeaturesToInject\';
for DSIdx =3:3
    Ds_Name= DS_List{DSIdx};%
    path=['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\',Ds_Name,' Motifs 1 2 3 same variate multisize\'];
    
    dataLocation='data\';
    load([path,dataLocation,featurespath,'allTSid.mat']);
    Name_OriginalSeries = sort(AllTS(1:30));
    
    for AllseriesID=1:1%30
        AllRWstatistics=[];
        OrgDSpath=['D:\Motif_Results\Datasets\',Ds_Name,'\data\',num2str(Name_OriginalSeries(AllseriesID)),'.csv'];
        Num_SyntSeries=10;
        PossibleMotifInjected = [1,2,3,10];
        depd =csvread([path,dataLocation,featurespath,'Depd',num2str(Name_OriginalSeries(AllseriesID)),'.csv']);
        feature =csvread([path,dataLocation,featurespath,'Features',num2str(Name_OriginalSeries(AllseriesID)),'.csv']);
        orgData =csvread(OrgDSpath);
        if DSIdx==2 | DSIdx==3
            orgData =orgData';
        end
        RWscale=[0; 0.1;0.25;0.5;0.75;1;2];
        for RWscaleIDX=1:7
            for idmotInj =1: 1
                GBEntropy=[];
                GBEntropyInterest=[];
                depdM= depd(depd(:,1)>0,idmotInj);
                featureM= feature(:,idmotInj);
                timescope= featureM(4,idmotInj)*3; % 29
                intervaltime=(round((featureM(2,idmotInj)-timescope)) : (round((featureM(2,idmotInj)+timescope))));
                DataM= orgData(:,intervaltime((intervaltime>0 & intervaltime<=size(orgData,2))));
                minVaraites=min(DataM')';
                maxVaraites=max(DataM')';
                NormDataM=DataM ;
                Entropy=zeros(size(DataM,1),1);
                Deviation=zeros(size(DataM,1),1);
                for vari=1:size(DataM,1)
                    NormDataM(vari,:)= (DataM(vari,:)- min(DataM(vari,:)))/(max(DataM(vari,:)) - min(DataM(vari,:)));
                    Entropy(vari,1) = entropy(NormDataM(vari,:));
                    Deviation(vari,1)= std(DataM(vari,:));
                end
                Ndata=(DataM-min(DataM(:)))/(max(DataM(:))-min(DataM(:)));
                GBEntropy=[GBEntropy,[0,0,entropy(Ndata)]];%,0]];
                NdataVI= DataM(depdM,:);
                NdataVI=(NdataVI-min(NdataVI(:)))/(max(NdataVI(:))-min(NdataVI(:)));
                GBEntropyInterest=[GBEntropyInterest,[0,0,entropy(NdataVI)]];%,0]];
                
                ORGMotifStatistics= [minVaraites,maxVaraites,Entropy];%,Deviation];
                %% motif injected data statistics
                
                InjectedeStatistics= [];
                
                featuresPositions= csvread([path,dataLocation,'IndexEmbeddedFeatures\FeaturePosition_Motif',num2str(idmotInj),'_',num2str(Name_OriginalSeries(AllseriesID)),'_10_instance_1_',num2str(RWscale(RWscaleIDX)),'.csv']);
                featuresPositions = featuresPositions((featuresPositions(:,4)-featuresPositions(:,3)) == max(featuresPositions(:,4)-featuresPositions(:,3)),:);
                dataMInjected= csvread([path,dataLocation,'Motif',num2str(idmotInj),'_',num2str(Name_OriginalSeries(AllseriesID)),'_10_instance_1_',num2str(RWscale(RWscaleIDX)),'.csv']);
                D(:,:,1)= dataMInjected(:,featuresPositions(1,3):featuresPositions(1,4));
                D(:,:,2)= dataMInjected(:,featuresPositions(end,3):featuresPositions(end,4));
                for i =1:2
                    DataM=D(:,:,i);
                    NormDataM=DataM;
                    minVaraites=min(DataM')';
                    maxVaraites=max(DataM')';
                    Entropy=zeros(size(DataM,1),1);
                    Deviation=zeros(size(DataM,1),1);
                    for vari=1:size(DataM,1)
                        NormDataM(vari,:)= (DataM(vari,:)- min(DataM(vari,:)))/(max(DataM(vari,:)) - min(DataM(vari,:)));
                        Entropy(vari,1) = entropy(NormDataM(vari,:));
                        Deviation(vari,1)= std(DataM(vari,:));
                    end
                    InjectedeStatistics=[InjectedeStatistics,[minVaraites,maxVaraites,Entropy]];%,Deviation]];
                    Ndata=(DataM-min(DataM(:)))/(max(DataM(:))-min(DataM(:)));
                    GBEntropy=[GBEntropy,[0,0,entropy(Ndata)]];%,0]];
                    NdataVI= DataM(depdM,:);
                    NdataVI=(NdataVI-min(NdataVI(:)))/(max(NdataVI(:))-min(NdataVI(:)));
                    GBEntropyInterest=[GBEntropyInterest,[0,0,entropy(NdataVI)]];%,0]];
                end
                
            end
            %% varaite of interest statistics
            AllStatistics= [[1:size(DataM,1)]',ORGMotifStatistics,InjectedeStatistics];
            AllStatistics= [AllStatistics;[0,GBEntropy]];
            VariateofinterestStatistics= AllStatistics(depdM,:);
            VariateofinterestStatistics=[VariateofinterestStatistics;[0,GBEntropyInterest]];
            Alltogether=[AllStatistics;VariateofinterestStatistics];
            if (RWscaleIDX==1)
                AllRWstatistics= [AllRWstatistics,Alltogether];
            else
                AllRWstatistics= [AllRWstatistics,Alltogether(:,5:end)];
            end
        end
        Labels1 = {'Variates','Original', ' ', ' ','RW0I1',' ', ' ', ' RW0I2',' ', ' ','RW0.1_I1',' ', ' ','RW0.1_I2 ',' ', ' ', 'RW0.25_I1',' ',' ', ' RW0.25_I2',' ',' ', 'RW0.5_I1', ' ',' ', ' RW0.5_I2',' ',' ','RW0.75_I1',' ',' ', 'RW0.75_I2 ',' ', ' ', 'RW 100_I1', ' ',' ', 'RW 100_I2 ',' ', ' ','RW 200_I1',' ',' ', ' RW 200_I2',' ', ' '};
        Labels2 = {' ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy '};
        DestPath= ['D:\Motif_Results\Datasets\SynteticDataset\Results\MotifsAnalisis\',Ds_Name,'_TS_',num2str(Name_OriginalSeries(AllseriesID)),'_inst1.xls'];
        xlswrite(DestPath,Labels1,'Foglio1','A1');
        xlswrite(DestPath,Labels2,'Foglio1','A2');
        xlswrite(DestPath,AllRWstatistics,'Foglio1','A3');
    end
end