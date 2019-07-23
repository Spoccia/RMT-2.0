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
        for idmotInj =1: 1
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
            EntropyComp=zeros(size(DataM,1),1);
            Deviation=zeros(size(DataM,1),1);
            for vari=1:size(DataM,1)
                NormDataM(vari,:)= (DataM(vari,:)- min(DataM(vari,:)))/(max(DataM(vari,:)) - min(DataM(vari,:)));
                EntropyComp(vari,1) = entropy(NormDataM(vari,:));
                Deviation(vari,1)= std(DataM(vari,:));
            end
%             Ndata=(DataM-min(DataM(:)))/(max(DataM(:))-min(DataM(:)));
            Ndata=NormDataM;
            GBEntropy=[GBEntropy,[0,0,entropy(Ndata)]];%,0]];
             NdataVI= DataM(depdM,:);
             NdataVI=(NdataVI-min(NdataVI(:)))/(max(NdataVI(:))-min(NdataVI(:)));
            NdataVI=Ndata(depdM,:);
%             mina      = min(NdataVI(:));
%             maxa      = max(NdataVI(:));
%             grayUINT8 = uint8((NdataVI - mina) * 255 / (maxa - mina));
            GBEntropyInterest=[GBEntropyInterest,[0,0,entropy(NdataVI)]];%grayUINT8)]];%,0]];rescale(A,-1,1)
%             imhist(grayUINT8);
            gbINTERESTDATA=GBEntropyInterest;
            ORGMotifStatistics= [minVaraites,maxVaraites,EntropyComp];%,Deviation];
            
            %% read Random walks
            RWstatistics=[];
            aLLINTERESTINGrw=[];
            for RWind=1:10
                random_walk_scale=[0; 0.1;0.25;0.5;0.75;1;2];
                RWstatistics=[];
                GBEntropyInterest=[];
                for scaleRW=1:7
                    RW = csvread([path,'data\RW_0_1\RW_',num2str(RWind),'.csv']);
                    AllAVGDispM1=[];
                    AllAVGDispRW0=[];
                    AllFactors =[];
                    AllAVGDispNEWRW=[];
                    if random_walk_scale(scaleRW)~=0
                        randomwalkData=RW;
                        for allVaraitesiter=1:size(randomwalkData,1);
                            AVGDISPLACEMENT_RW= mean(abs(randomwalkData(allVaraitesiter,1:end-1)-randomwalkData(allVaraitesiter,2:end)));
                            AllAVGDispRW0=[AllAVGDispRW0;AVGDISPLACEMENT_RW];
                            AVGDisplacement_Motif=0;
                            if idmotInj==1
                                AVGDisplacement_Motif_1= mean(abs(DataM(allVaraitesiter,1:end-1)-DataM(allVaraitesiter,2:end)));
                                AVGDisplacement_Motif=AVGDisplacement_Motif_1;
                            end
                            AllAVGDispM1=[AllAVGDispM1;AVGDisplacement_Motif];
                            % AVGDisplacement_TS= mean(abs((TSdata(allVaraitesiter,1:end-1)-min(TSdata(allVaraitesiter,1:end)))-(TSdata(allVaraitesiter,2:end)+min(TSdata(allVaraitesiter,1:end)))));
                            Bha = (AVGDisplacement_Motif/AVGDISPLACEMENT_RW)* random_walk_scale(scaleRW);
                            AllFactors=[AllFactors;Bha];
                            randomwalkData(allVaraitesiter,:)= randomwalkData(allVaraitesiter,:)*Bha;%+ min(MotifsSections{1}.data(allVaraitesiter,1:end));
                            AVGDISPLACEMENT_RW1= mean(abs(randomwalkData(allVaraitesiter,1:end-1)-randomwalkData(allVaraitesiter,2:end)));
                            AllAVGDispNEWRW=[AllAVGDispNEWRW;AVGDISPLACEMENT_RW1];
                        end
                        RW=randomwalkData;
                    end
                    minVaraites=min(RW')';
                    maxVaraites=max(RW')';
                    NormDataM=RW;
                    EntropyComp=zeros(size(RW,1),1);
                    Deviation=zeros(size(RW,1),1);
                    for vari=1:size(RW,1)
                        NormDataM(vari,:)= (RW(vari,:)- min(RW(vari,:)))/(max(RW(vari,:)) - min(RW(vari,:)));
                        EntropyComp(vari,1) = entropy(NormDataM(vari,:));
                        Deviation(vari,1)= std(RW(vari,:));
                    end
                    RWstatistics=[RWstatistics,[minVaraites,maxVaraites,EntropyComp]];
                    
%                     Ndata=(RW-min(RW(:)))/(max(RW(:))-min(RW(:)));
                    Ndata=NormDataM;
                    GBEntropy=[GBEntropy,[0,0,entropy(Ndata)]];%,0]];
%                     NdataVI= RW(depdM,:);
%                     NdataVI=(NdataVI-min(NdataVI(:)))/(max(NdataVI(:))-min(NdataVI(:)));
                    NdataVI= Ndata(depdM,:);
                    GBEntropyInterest=[GBEntropyInterest,[0,0,entropy(NdataVI)]];%,0]];
                end
            AllStatisticsAPPEND = [[1:size(DataM,1)]',ORGMotifStatistics,RWstatistics];    
            aLLINTERESTINGrw=[aLLINTERESTINGrw;AllStatisticsAPPEND(depdM,:);[0,gbINTERESTDATA,GBEntropyInterest]];
            end
            AllStatistics = [[1:size(DataM,1)]',ORGMotifStatistics,RWstatistics];
%             AllStatistics = [AllStatistics;[0,GBEntropy]];
            VariateIntereststatistics=AllStatistics(depdM,:);
            VariateIntereststatistics=[VariateIntereststatistics;[0,gbINTERESTDATA,GBEntropyInterest]];
            
            
            
            %% varaite of interest statistics
            %         AllStatistics= [[1:size(DataM,1)]',ORGMotifStatistics,InjectedeStatistics];
            %         AllStatistics= [AllStatistics;[0,GBEntropyComp]];
            %         VariateofinterestStatistics= AllStatistics(depdM,:);
            %         VariateofinterestStatistics=[VariateofinterestStatistics;[0,GBEntropyInterest]];
            %         Alltogether=[AllStatistics;VariateofinterestStatistics];
            %         if (RWscaleIDX==1)
            %             AllRWstatistics= [AllRWstatistics,Alltogether];
            %         else
            %             AllRWstatistics= [AllRWstatistics,Alltogether(:,5:end)];
            %         end
            %     end
            
%             Labels1 = {'Variates','Original', ' ', ' ','RW0I1',' ', ' ','RW0.1_I1',' ', ' ', 'RW0.25_I1',' ',' ', 'RW0.5_I1', ' ',' ','RW0.75_I1',' ',' ', 'RW 100_I1', ' ', ' ', ' RW 200_I2',' ', ' '};
%             Labels2 = {' ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy '};
%             DestPath= ['D:\Motif_Results\Datasets\SynteticDataset\Results\MotifsAnalisis\',Ds_Name,'_Motif_vs_RW_',num2str(Name_OriginalSeries(AllseriesID)),'_inst1.xls'];
%             xlswrite(DestPath,Labels1,'Foglio1','A1');
%             xlswrite(DestPath,Labels2,'Foglio1','A2');
%             xlswrite(DestPath,AllRWstatistics,'Foglio1','A3');
        end
            Labels1 = {'Variates','Original', ' ', ' ','RW0I1',' ', ' ','RW0.1_I1',' ', ' ', 'RW0.25_I1',' ',' ', 'RW0.5_I1', ' ',' ','RW0.75_I1',' ',' ', 'RW 100_I1', ' ', ' ', ' RW 200_I2',' ', ' '};
            Labels2 = {' ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy ','Min', 'Max ', 'Entropy '};
            DestPath= ['D:\Motif_Results\Datasets\SynteticDataset\Results\MotifsAnalisis\',Ds_Name,'_Motif_vs_aLL_RW_',num2str(Name_OriginalSeries(AllseriesID)),'_inst1.xls'];
            xlswrite(DestPath,Labels1,'Foglio1','A1');
            xlswrite(DestPath,Labels2,'Foglio1','A2');
            xlswrite(DestPath,aLLINTERESTINGrw,'Foglio1','A3');
    end
end