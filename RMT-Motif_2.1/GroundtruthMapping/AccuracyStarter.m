clc; clear;
warning off;
DS_List ={'Energy','Mocap','BirdSong'};
for DSIdx =3:3
    Ds_Name= DS_List{DSIdx};%
    % Ds_Name= 'Energy';%'Mocap';%'BirdSong';%
    
    path=['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\',Ds_Name,' Motifs 1 2 3 same variate multisize\'];%Ds_Name,'\Coherent Shift Variate 1M ',Ds_Name,'\instancessamesize\'];%RandomVariate\instancessamesize\'];%BirdSong\samesize10inst\';%Coherent Shift Variate 1M Energy\instancessamesize\';%
   %   path=['F:\syntethic motifs  good results\',Ds_Name,'\samesize10inst\'];%'\numInstances_5_15\'];%'\',Ds_Name,' M 1 2 3\'];%
    %Mocap\numInstances_5_15\';%10_Motifs_MM_rebuttal\';%Motif1RME\';%ICMR RMT-Mstamp-RME\';%
    % path='D:\Motif_Results\Datasets\SynteticDataset\Energy\Coherent Shift Variate 1M Energy\instanceMultisize\';
    %'D:\Motif_Results\Datasets\SynteticDataset\Energy\RandomVariate\Same_length\';
    % path='D:\Motif_Results\Datasets\SynteticDataset\Mocap\numInstances_5_15\';%RandomVariate\';
    %path='D:\Motif_Results\Datasets\SynteticDataset\Energy\numInstances_5_15\';%RandomVariate\Same_length\';%
    %path ='D:\Motif_Results\Datasets\SynteticDataset\BirdSong\numInstances_5_15\';%
%     possnuminst=[5,15,10];
%     for indpossnuminst=3:3
%     BaseName=['Motif1numInst_',num2str(possnuminst(indpossnuminst))]; %'MV_Sync_Motif1';%'MV_Sync_Motif1';%
    NO_V_subcluster=0;
    dataLocation='data\';
    load([path,dataLocation,'FeaturesToInject\allTSid.mat']);
    Num_SyntSeries=10; % num of instances of one motif
    FeaturesRM ='RMT';%'RME';%
    PossibleMotifInjected = [1,2,3,10];
    for idmotInj =1: size(PossibleMotifInjected,2)-1
        motifinjected = num2str(PossibleMotifInjected(idmotInj));
        BaseName=['Motif', num2str(motifinjected)];%['MV_Sync_Motif',num2str(motifinjected)];%
        %     Name_OriginalSeries = [23,35,86,111];% MOCap Motif10%
        Name_OriginalSeries = sort(AllTS(1:30));%[1,3,6,7];%ENERGY [64,70,80,147];Bsong%[85,35,127,24];Mocap % name of the original  series from with we  got the  motif instances to inject
        percent=[0; 0.1;0.25;0.5;0.75;1;2];
        for percentid=1:size(percent,1)
            percentagerandomwalk=percent(percentid);
            % percentagerandomwalk=0.75;%1;%0; %0.1;%0.5;%
            strategy=[1,3,4,6,7,9];%[1,2,3,4,5,6,7,8,9];
            DepO =2;
            DepT =2;
            for strID =1:2%size(strategy,2)%1:size(strategy,2)%1:size(strategy,2)%9%5:6%4:6%4:6%1:size(strategy,2)
                StrategyClustering= strategy(strID);%3;%2;%
                
                for pip=1:30%size(Name_OriginalSeries,2)
                    for NAME = 1:Num_SyntSeries
                        
%                         TEST=[BaseName,motifinjected,'_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME),'_',num2str(percentagerandomwalk)];
                        TEST=[BaseName,'_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME),'_',num2str(percentagerandomwalk)];
                        %old
                        %                      TEST=[BaseName,'_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME)];
                        
                        
                        kindOfClustring= 'AKmeans'; % the algorithm of clustering to use
                        if StrategyClustering >3
                            kindOfClustring= 'DBScan';%
                        end
                        distanceUsed='Descriptor';% use just descriptors to  cluster
                        ClusterAlg = ['ClusterStrategy_',num2str(StrategyClustering)];
                        subfolderClusterLabel='Clusterlabel\ClusterLabel_';
                        
                        %
                        if (StrategyClustering==3 | StrategyClustering==6| StrategyClustering==9)
                            if NO_V_subcluster == 1
                                AP_allfeatures(path,dataLocation,TEST,FeaturesRM,kindOfClustring,distanceUsed,ClusterAlg,StrategyClustering,num2str(DepO),num2str(DepT));
                            else
                                AP_allfeatures_subcluster(path,dataLocation,TEST,FeaturesRM,kindOfClustring,distanceUsed,ClusterAlg,StrategyClustering,num2str(DepO),num2str(DepT));
                            end
                            %
                        else
                            AP_allfeatures(path,dataLocation,TEST,FeaturesRM,kindOfClustring,distanceUsed,ClusterAlg,StrategyClustering,num2str(DepO),num2str(DepT));
                        end
                        %         for AfterPruning =0:1
                        %             for subcluster=0:1
                        %                 Distortion_Clusters(path,kindofinj,TEST,FeaturesRM,kindofCluster,measure,ClusterAlg,subfolderClusterLabel,num2str(DepO),num2str(DepT),AfterPruning,subcluster);
                        %             end
                        %         end
                        
                        %             end
                        %         end
                    end
                end
            end
            end
        end
    end
% end