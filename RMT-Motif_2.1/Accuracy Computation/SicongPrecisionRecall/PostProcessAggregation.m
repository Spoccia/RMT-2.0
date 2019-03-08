clear;
clc;
DS_List ={'Energy','Mocap','BirdSong'};
for DSIdx =3:3
    Ds_Name= DS_List{DSIdx};%
    % Ds_Name ='BirdSong';%'Energy';%'Mocap';%
%     Path=['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\RandomVariate\instancessamesize\'];%'\Coherent Shift Variate 1M ',Ds_Name,'\instancesmultisize'];
%     Path=['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\',Ds_Name,' Motifs 1 2 3 same variate multisize\'];
%     Path=['F:\syntethic motifs  good results\',Ds_Name,'\',Ds_Name,' M 1 2 3\'];
%    Path=['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\Coherent Shift Variate 1M ',Ds_Name,'\instancesmultisize\'];%'\',Ds_Name,' Motifs 1 2 3 same variate multisize\'];

%       Path=['F:\syntethic motifs  good results\',Ds_Name,'\numInstances_5_15'];%'\10_Motifs_MM_rebuttal\'];%'\ICMR RMT-Mstamp-RME\'];%'\samesize10inst\'];%'\random shift variates 1M ',Ds_Name ,'\instancessamesize\'];%
     %'\',Ds_Name,' M 1 2 3\']%
%       Path='G:\syntethic motifs  good results\Mocap\Coherent Shift Variate 1M Mocap\instancessamesize\';%['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\',Ds_Name,' Motifs 1 2 3 same variate multisize\'];
 Path =['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\',Ds_Name,' Motifs 1 2 3 same variate multisize\'];%Ds_Name,'\Coherent Shift Variate 1M ',Ds_Name,'\instancesmultisize'];%
     %Path=['F:\syntethic motifs  good results\',Ds_Name,'\Coherent Shift Variate 1M ',Ds_Name,'\instancesmultisize'];
    %,'\samesize10inst\'];
    %'\samesize10inst'];%'\Mocap M 1 2 3'];%'\numInstances_5_15'];
    %['F:\syntethic motifs  good results\',Ds_Name,'\numInstances_5_15'];
    %samesize10inst'];%'\Motif1RME'];%'\10_Motifs_MM_rebuttal'];%'\ICMR RMT-Mstamp-RME'];%
    % Path='D:\Motif_Results\Datasets\SynteticDataset\Energy\Coherent Shift Variate 1M Energy\instanceMultisize';
    % Path=['F:\syntethic motifs  good results\',Ds_Name,'\random shift variates 1M ',Ds_Name,'\instancesmultisize'];%'\instancessamesize'];%
    
    %Path = ['D:\Motif_Results\Datasets\SynteticDataset\',DS_Name,'\RandomVariate\instancesmultisize'];
    for overlapid=1:1
        overlapping='';%
        if overlapid==2
            overlapping='Overlapping';%
        end
        %     overlapping='';%
        %     overlapping='Overlapping';%
        fprintf('Post procesing precision and recall files... \n');
        testCaseIndex = 1 : 300; % 30 time series used, 10 instances each
        
%         instancesInjecte = [10,5,15];
%         for fivefifteen=2:3
            % strategy = [1:9];
            % num_of_motif = [1:3];
            num_of_motif = [1:3];%
            strategy = [1, 3, 4, 6, 7, 9];%[3,6,9];%
            % BaseName='MV_Sync_Motif';%'Motif1numInst_15';%
            BaseName='Motif';
            algorithm_type = {'RMT'};%,'MStamp'};%'RME' , %% MStamp, MatrixProfile, RMT, RME, cleanmatlabentropy09
            %  algorithm_type = {'RMT'}; % MStamp, MatrixProfile, RMT, RME, cleanmatlabentropy09
            timeOverlapThresholds = [0.1, 0.25, 0.5, 0.75,0.90,0.95,0.98, 1];
            amp_scale = [0, 0.1, 0.25, 0.5, 0.75, 1, 2];
            col_header={'Class','ID','Start','End','ClassInj','IDinj','StartInj','EndInj','Time_Score','dep_Overlapping'};
            Labels1 = {'Strategy','Time Overlapping', 'SMM_M1_RW0', 'MPC_M1_RW0','AvgSMM_RW0','AvgMPC_RW0','Time Overlapping', 'SMM_M1_RW0.1', 'MPC_M1_RW0.1','AvgSMM_RW0.1','AvgMPC_RW0.1','Time Overlapping', 'SMM_M1_RW0.25', 'MPC_M1_RW0.25','AvgSMM_RW0.25','AvgMPC_RW0.25','Time Overlapping', 'SMM_M1_RW0.5', 'MPC_M1_RW0.5','AvgSMM_RW0.5','AvgMPC_RW0.5','Time Overlapping', 'SMM_M1_RW0.75', 'MPC_M1_RW0.75','AvgSMM_RW0.75','AvgMPC_RW0.75','Time Overlapping', 'SMM_M1_RW1', 'MPC_M1_RW1','AvgSMM_RW1','AvgMPC_RW1','Time Overlapping', 'SMM_M1_RW2', 'MPC_M1_RW2','AvgSMM_RW2','AvgMPC_RW2'};
            Labels2 = {'Strategy','Time Overlapping', 'SMM_M1_RW0','SMM_M2_RW0', 'MPC_M1_RW0','MPC_M2_RW0','AvgSMM_RW0','AvgMPC_RW0','Time Overlapping', 'SMM_M1_RW0.1','SMM_M2_RW0.1', 'MPC_M1_RW0.1','MPC_M2_RW0.1','AvgSMM_RW0.1','AvgMPC_RW0.1','Time Overlapping', 'SMM_M1_RW0.25','SMM_M2_RW0.25', 'MPC_M1_RW0.25','MPC_M2_RW0.25','AvgSMM_RW0.25','AvgMPC_RW0.25','Time Overlapping', 'SMM_M1_RW0.5','SMM_M2_RW0.5', 'MPC_M1_RW0.5','MPC_M2_RW0.5','AvgSMM_RW0.5','AvgMPC_RW0.5','Time Overlapping', 'SMM_M1_RW0.75','SMM_M2_RW0.75', 'MPC_M1_RW0.75','MPC_M2_RW0.75','AvgSMM_RW0.75','AvgMPC_RW0.75','Time Overlapping', 'SMM_M1_RW1','SMM_M2_RW1', 'MPC_M1_RW1','MPC_M2_RW1','AvgSMM_RW1','AvgMPC_RW1','Time Overlapping', 'SMM_M1_RW2','SMM_M2_RW2', 'MPC_M1_RW2','MPC_M2_RW2','AvgSMM_RW2','AvgMPC_RW2'};
            Labels3 = {'Strategy','Time Overlapping', 'SMM_M1_RW0','SMM_M2_RW0','SMM_M3_RW0', 'MPC_M1_RW0','MPC_M2_RW0','MPC_M3_RW0','AvgSMM_RW0','AvgMPC_RW0','Time Overlapping', 'SMM_M1_RW0.1','SMM_M2_RW0.1','SMM_M3_RW0.1', 'MPC_M1_RW0.1','MPC_M2_RW0.1','MPC_M3_RW0.1','AvgSMM_RW0.1','AvgMPC_RW0.1','Time Overlapping', 'SMM_M1_RW0.25','SMM_M2_RW0.25','SMM_M3_RW0.25', 'MPC_M1_RW0.25','MPC_M2_RW0.25','MPC_M3_RW0.25','AvgSMM_RW0.25','AvgMPC_RW0.25','Time Overlapping', 'SMM_M1_RW0.5','SMM_M2_RW0.5','SMM_M3_RW0.5', 'MPC_M1_RW0.5','MPC_M2_RW0.5','MPC_M3_RW0.5','AvgSMM_RW0.5','AvgMPC_RW0.5','Time Overlapping', 'SMM_M1_RW0.75','SMM_M2_RW0.75','SMM_M3_RW0.75', 'MPC_M1_RW0.75','MPC_M2_RW0.75','MPC_M3_RW0.75','AvgSMM_RW0.75','AvgMPC_RW0.75','Time Overlapping', 'SMM_M1_RW1','SMM_M2_RW1','SMM_M3_RW1', 'MPC_M1_RW1','MPC_M2_RW1','MPC_M3_RW1','AvgSMM_RW1','AvgMPC_RW1','Time Overlapping', 'SMM_M1_RW2','SMM_M2_RW2','SMM_M3_RW2', 'MPC_M1_RW2','MPC_M2_RW2','MPC_M3_RW2','AvgSMM_RW2','AvgMPC_RW2'};
            
            if overlapid==2
                Labels1 = {'Strategy','Overlapping %V*T', 'SMM_M1_RW0', 'MPC_M1_RW0','AvgSMM_RW0','AvgMPC_RW0','Overlapping %V*T', 'SMM_M1_RW0.1', 'MPC_M1_RW0.1','AvgSMM_RW0.1','AvgMPC_RW0.1','Overlapping %V*T', 'SMM_M1_RW0.25', 'MPC_M1_RW0.25','AvgSMM_RW0.25','AvgMPC_RW0.25','Overlapping %V*T', 'SMM_M1_RW0.5', 'MPC_M1_RW0.5','AvgSMM_RW0.5','AvgMPC_RW0.5','Overlapping %V*T', 'SMM_M1_RW0.75', 'MPC_M1_RW0.75','AvgSMM_RW0.75','AvgMPC_RW0.75','Overlapping %V*T', 'SMM_M1_RW1', 'MPC_M1_RW1','AvgSMM_RW1','AvgMPC_RW1','Overlapping %V*T', 'SMM_M1_RW2', 'MPC_M1_RW2','AvgSMM_RW2','AvgMPC_RW2'};
                Labels2 = {'Strategy','Overlapping %V*T', 'SMM_M1_RW0','SMM_M2_RW0', 'MPC_M1_RW0','MPC_M2_RW0','AvgSMM_RW0','AvgMPC_RW0','Overlapping %V*T', 'SMM_M1_RW0.1','SMM_M2_RW0.1', 'MPC_M1_RW0.1','MPC_M2_RW0.1','AvgSMM_RW0.1','AvgMPC_RW0.1','Overlapping %V*T', 'SMM_M1_RW0.25','SMM_M2_RW0.25', 'MPC_M1_RW0.25','MPC_M2_RW0.25','AvgSMM_RW0.25','AvgMPC_RW0.25','Overlapping %V*T', 'SMM_M1_RW0.5','SMM_M2_RW0.5', 'MPC_M1_RW0.5','MPC_M2_RW0.5','AvgSMM_RW0.5','AvgMPC_RW0.5','Overlapping %V*T', 'SMM_M1_RW0.75','SMM_M2_RW0.75', 'MPC_M1_RW0.75','MPC_M2_RW0.75','AvgSMM_RW0.75','AvgMPC_RW0.75','Overlapping %V*T', 'SMM_M1_RW1','SMM_M2_RW1', 'MPC_M1_RW1','MPC_M2_RW1','AvgSMM_RW1','AvgMPC_RW1','Overlapping %V*T', 'SMM_M1_RW2','SMM_M2_RW2', 'MPC_M1_RW2','MPC_M2_RW2','AvgSMM_RW2','AvgMPC_RW2'};
                Labels3 = {'Strategy','Overlapping %V*T', 'SMM_M1_RW0','SMM_M2_RW0','SMM_M3_RW0', 'MPC_M1_RW0','MPC_M2_RW0','MPC_M3_RW0','AvgSMM_RW0','AvgMPC_RW0','Overlapping %V*T', 'SMM_M1_RW0.1','SMM_M2_RW0.1','SMM_M3_RW0.1', 'MPC_M1_RW0.1','MPC_M2_RW0.1','MPC_M3_RW0.1','AvgSMM_RW0.1','AvgMPC_RW0.1','Overlapping %V*T', 'SMM_M1_RW0.25','SMM_M2_RW0.25','SMM_M3_RW0.25', 'MPC_M1_RW0.25','MPC_M2_RW0.25','MPC_M3_RW0.25','AvgSMM_RW0.25','AvgMPC_RW0.25','Overlapping %V*T', 'SMM_M1_RW0.5','SMM_M2_RW0.5','SMM_M3_RW0.5', 'MPC_M1_RW0.5','MPC_M2_RW0.5','MPC_M3_RW0.5','AvgSMM_RW0.5','AvgMPC_RW0.5','Overlapping %V*T', 'SMM_M1_RW0.75','SMM_M2_RW0.75','SMM_M3_RW0.75', 'MPC_M1_RW0.75','MPC_M2_RW0.75','MPC_M3_RW0.75','AvgSMM_RW0.75','AvgMPC_RW0.75','Overlapping %V*T', 'SMM_M1_RW1','SMM_M2_RW1','SMM_M3_RW1', 'MPC_M1_RW1','MPC_M2_RW1','MPC_M3_RW1','AvgSMM_RW1','AvgMPC_RW1','Overlapping %V*T', 'SMM_M1_RW2','SMM_M2_RW2','SMM_M3_RW2', 'MPC_M1_RW2','MPC_M2_RW2','MPC_M3_RW2','AvgSMM_RW2','AvgMPC_RW2'};
            end
            allresults=[];
            
            for i = 1 : size(num_of_motif, 2)
                AllStrategy_Precision=[];
                AllStrategy_Recall=[];
                AllStrategy_Fscore=[];
                for j = 1:2% size(strategy, 2)
                    PrecisionRWScale=[];
                    RecallRWScale=[];
                    FscoreRWScale=[];
                    for aa = 4 : size(amp_scale, 2)
                        PrecisionAggregatedMAtrix = [];
                        RecallAggregatedMAtrix = [];
                        FscoreAggregatedMAtrix = [];
                        for tt = 1 : size(timeOverlapThresholds, 2)
                            timeOverlapThreshold = timeOverlapThresholds(tt);
                            
                            PrecisionforPercentage = [];
                            RecallforPercentage = [];
                            FscoreforPercentage = [];
                            for kk = 1 : size(algorithm_type, 2)
                                
                                
                                
                                %dataAggregatedMAtrix (:,1)= timeOverlapThresholds';
                                
                                cur_algorithm_type = algorithm_type{kk};
                                cur_strategy = strategy(j);
                                cur_num_of_motif = num_of_motif(i);
                                
                                fprintf('num_of_motif: %d, strategy: %d, algorithm_type: %s, amplitude scale: %f, time overlap threshold: %f . \n', cur_num_of_motif, cur_strategy, cur_algorithm_type, amp_scale(aa), timeOverlapThreshold);
                                sharedFolder = [Path,'/Result/', cur_algorithm_type, '_',BaseName, num2str(cur_num_of_motif), '/Strategy_', num2str(cur_strategy), '/amp_scale_', num2str(amp_scale(aa)), '_TO_', num2str(timeOverlapThreshold)];
%                                 sharedFolder = [Path,'/Result',num2str(instancesInjecte(fivefifteen)),'/', cur_algorithm_type, '_',BaseName, num2str(cur_num_of_motif), '/Strategy_', num2str(cur_strategy), '/amp_scale_', num2str(amp_scale(aa)), '_TO_', num2str(timeOverlapThreshold)];
                                if strcmp(cur_algorithm_type,'MStamp') == 1%kk==2
                                    sharedFolder = [Path,'/Result/', cur_algorithm_type, '_',BaseName, num2str(cur_num_of_motif), '/Strategy_3','/amp_scale_', num2str(amp_scale(aa)), '_TO_', num2str(timeOverlapThreshold)];
%                                     sharedFolder = [Path,'/Result',num2str(instancesInjecte(fivefifteen)),'/', cur_algorithm_type, '_',BaseName, num2str(cur_num_of_motif), '/Strategy_3','/amp_scale_', num2str(amp_scale(aa)), '_TO_', num2str(timeOverlapThreshold)];
                                end
                                
                                precision_file_path = [sharedFolder, '/', cur_algorithm_type, 'Precision_'];
                                recall_file_path = [sharedFolder, '/', cur_algorithm_type, 'Recall_'];
                                FScore_file_path = [sharedFolder, '/', cur_algorithm_type, 'FScore_'];
                                
                                aggregated_precision_file = csvread([precision_file_path, overlapping,'aggregated.csv']);
                                aggregated_recall_file = csvread([recall_file_path, overlapping,'aggregated.csv']);
                                aggregated_FScore_file = csvread([FScore_file_path, overlapping,'aggregated.csv']);
                                meantemp= mean(aggregated_precision_file);
                                PrecisionforPercentage = [PrecisionforPercentage,meantemp(:,2:end-1)];
                                meantemp= mean(aggregated_recall_file)
                                RecallforPercentage = [RecallforPercentage,meantemp(:,2:end-1)];
                                meantemp=mean(aggregated_FScore_file);
                                FscoreforPercentage = [FscoreforPercentage,meantemp(:,2:end-1)];
                                
                                
                            end
                            PrecisionAggregatedMAtrix = [PrecisionAggregatedMAtrix;PrecisionforPercentage];
                            RecallAggregatedMAtrix = [RecallAggregatedMAtrix;RecallforPercentage];
                            FscoreAggregatedMAtrix = [FscoreAggregatedMAtrix;FscoreforPercentage];
                        end
                        
                        PrecisionRWScale=[PrecisionRWScale,[timeOverlapThresholds',PrecisionAggregatedMAtrix,zeros(size(PrecisionAggregatedMAtrix,1),2)]];
                        RecallRWScale=[RecallRWScale,[timeOverlapThresholds',RecallAggregatedMAtrix,zeros(size(RecallAggregatedMAtrix,1),2)]];
                        FscoreRWScale=[FscoreRWScale,[timeOverlapThresholds',FscoreAggregatedMAtrix,zeros(size(FscoreAggregatedMAtrix,1),2)]];
                        
                    end
                    AllStrategy_Precision=[AllStrategy_Precision;[ones(size(PrecisionAggregatedMAtrix,1),1)*strategy(j),PrecisionRWScale]];
                    AllStrategy_Recall=[AllStrategy_Recall;[ones(size(PrecisionAggregatedMAtrix,1),1)*strategy(j),RecallRWScale]];
                    AllStrategy_Fscore=[AllStrategy_Fscore;[ones(size(PrecisionAggregatedMAtrix,1),1)*strategy(j),FscoreRWScale]];
                end
                finalpath = [Path,'/Result/', 'Motif', num2str(cur_num_of_motif)];
%                 finalpath = [Path,'/Result',num2str(instancesInjecte(fivefifteen)),'/', 'Motif', num2str(cur_num_of_motif)];
                label = Labels1;
                if (i==2)
                    label = Labels2;
                end
                if (i==3)
                    label = Labels3;
                end
                xlswrite([finalpath,'_Results',overlapping,'.xls'],label,'Precision','A1');
                xlswrite([finalpath,'_Results',overlapping,'.xls'],AllStrategy_Precision,'Precision','A2');
                xlswrite([finalpath,'_Results',overlapping,'.xls'],label,'Recall','A1');
                xlswrite([finalpath,'_Results',overlapping,'.xls'],AllStrategy_Recall,'Recall','A2');
                xlswrite([finalpath,'_Results',overlapping,'.xls'],label,'Fscore','A1');
                xlswrite([finalpath,'_Results',overlapping,'.xls'],AllStrategy_Fscore,'Fscore','A2');
                %     csvwrite([finalpath,'_Precision.csv'],[AllStrategy_Precision])
                %     csvwrite([finalpath,'_Recall.csv'], [AllStrategy_Recall]);
                %     csvwrite([finalpath,'_Fscore.csv'], [AllStrategy_Fscore]);
            end
        end
    end
% end
fprintf('All done .\n');