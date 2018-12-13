clear;
clc;
Ds_Name ='Mocap';%'Energy';%'BirdSong';%
Path=['F:\syntethic motifs  good results\',Ds_Name,'\Motif1RME'];%'\samesize10inst'];%'\10_Motifs_MM_rebuttal'];%'\ICMR RMT-Mstamp-RME'];%
% Path='D:\Motif_Results\Datasets\SynteticDataset\Energy\Coherent Shift Variate 1M Energy\instanceMultisize';
% Path=['F:\syntethic motifs  good results\',Ds_Name,'\random shift variates 1M ',Ds_Name,'\instancesmultisize'];%'\instancessamesize'];%

%Path = ['D:\Motif_Results\Datasets\SynteticDataset\',DS_Name,'\RandomVariate\instancesmultisize'];
overlapping='';%
% overlapping='Overlapping';%
fprintf('Post procesing precision and recall files... \n');
testCaseIndex = 1 : 300; % 30 time series used, 10 instances each
% strategy = [1:9];
% num_of_motif = [1:3];
num_of_motif = 1;%[1:3];
strategy = [1, 3, 4, 6, 7, 9];
%BaseName='MV_Sync_Motif';%'Motif1numInst_15';%
BaseName='Motif';
algorithm_type = {'RMT','RME' ,'MStamp'}; %% MStamp, MatrixProfile, RMT, RME, cleanmatlabentropy09
%  algorithm_type = {'RMT'}; % MStamp, MatrixProfile, RMT, RME, cleanmatlabentropy09
timeOverlapThresholds = [0.1, 0.25, 0.5, 0.75,0.90,0.95,0.98, 1];
amp_scale = [0, 0.1, 0.25, 0.5, 0.75, 1, 2];
col_header={'Class','ID','Start','End','ClassInj','IDinj','StartInj','EndInj','Time_Score','dep_Overlapping'}; 
Labels1 = {'Strategy','Time Overlapping', 'SMM_M1_RW0', 'MPC_M1_RW0','AvgSMM_RW0','AvgMPC_RW0','Time Overlapping', 'SMM_M1_RW0.1', 'MPC_M1_RW0.1','AvgSMM_RW0.1','AvgMPC_RW0.1','Time Overlapping', 'SMM_M1_RW0.25', 'MPC_M1_RW0.25','AvgSMM_RW0.25','AvgMPC_RW0.25','Time Overlapping', 'SMM_M1_RW0.5', 'MPC_M1_RW0.5','AvgSMM_RW0.5','AvgMPC_RW0.5','Time Overlapping', 'SMM_M1_RW0.75', 'MPC_M1_RW0.75','AvgSMM_RW0.75','AvgMPC_RW0.75','Time Overlapping', 'SMM_M1_RW1', 'MPC_M1_RW1','AvgSMM_RW1','AvgMPC_RW1','Time Overlapping', 'SMM_M1_RW2', 'MPC_M1_RW2','AvgSMM_RW2','AvgMPC_RW2'};
Labels2 = {'Strategy','Time Overlapping', 'SMM_M1_RW0','SMM_M2_RW0', 'MPC_M1_RW0','MPC_M2_RW0','AvgSMM_RW0','AvgMPC_RW0','Time Overlapping', 'SMM_M1_RW0.1','SMM_M2_RW0.1', 'MPC_M1_RW0.1','MPC_M2_RW0.1','AvgSMM_RW0.1','AvgMPC_RW0.1','Time Overlapping', 'SMM_M1_RW0.25','SMM_M2_RW0.25', 'MPC_M1_RW0.25','MPC_M2_RW0.25','AvgSMM_RW0.25','AvgMPC_RW0.25','Time Overlapping', 'SMM_M1_RW0.5','SMM_M2_RW0.5', 'MPC_M1_RW0.5','MPC_M2_RW0.5','AvgSMM_RW0.5','AvgMPC_RW0.5','Time Overlapping', 'SMM_M1_RW0.75','SMM_M2_RW0.75', 'MPC_M1_RW0.75','MPC_M2_RW0.75','AvgSMM_RW0.75','AvgMPC_RW0.75','Time Overlapping', 'SMM_M1_RW1','SMM_M2_RW1', 'MPC_M1_RW1','MPC_M2_RW1','AvgSMM_RW1','AvgMPC_RW1','Time Overlapping', 'SMM_M1_RW2','SMM_M2_RW2', 'MPC_M1_RW2','MPC_M2_RW2','AvgSMM_RW2','AvgMPC_RW2'};
Labels3 = {'Strategy','Time Overlapping', 'SMM_M1_RW0','SMM_M2_RW0','SMM_M3_RW0', 'MPC_M1_RW0','MPC_M2_RW0','MPC_M3_RW0','AvgSMM_RW0','AvgMPC_RW0','Time Overlapping', 'SMM_M1_RW0.1','SMM_M2_RW0.1','SMM_M3_RW0.1', 'MPC_M1_RW0.1','MPC_M2_RW0.1','MPC_M3_RW0.1','AvgSMM_RW0.1','AvgMPC_RW0.1','Time Overlapping', 'SMM_M1_RW0.25','SMM_M2_RW0.25','SMM_M3_RW0.25', 'MPC_M1_RW0.25','MPC_M2_RW0.25','MPC_M3_RW0.25','AvgSMM_RW0.25','AvgMPC_RW0.25','Time Overlapping', 'SMM_M1_RW0.5','SMM_M2_RW0.5','SMM_M3_RW0.5', 'MPC_M1_RW0.5','MPC_M2_RW0.5','MPC_M3_RW0.5','AvgSMM_RW0.5','AvgMPC_RW0.5','Time Overlapping', 'SMM_M1_RW0.75','SMM_M2_RW0.75','SMM_M3_RW0.75', 'MPC_M1_RW0.75','MPC_M2_RW0.75','MPC_M3_RW0.75','AvgSMM_RW0.75','AvgMPC_RW0.75','Time Overlapping', 'SMM_M1_RW1','SMM_M2_RW1','SMM_M3_RW1', 'MPC_M1_RW1','MPC_M2_RW1','MPC_M3_RW1','AvgSMM_RW1','AvgMPC_RW1','Time Overlapping', 'SMM_M1_RW2','SMM_M2_RW2','SMM_M3_RW2', 'MPC_M1_RW2','MPC_M2_RW2','MPC_M3_RW2','AvgSMM_RW2','AvgMPC_RW2'};
allresults=[];

for i = 1 : size(num_of_motif, 2)
    AllStrategy_Precision=[];
    AllStrategy_Recall=[];
    AllStrategy_Fscore=[];
    for j = 1: 2%size(strategy, 2)
        PrecisionRWScale=[];
        RecallRWScale=[];
        FscoreRWScale=[];
        for aa = 1 : size(amp_scale, 2)
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
                    if strcmp(cur_algorithm_type,'MStamp') == 1%kk==2
                        sharedFolder = [Path,'/Result/', cur_algorithm_type, '_',BaseName, num2str(cur_num_of_motif), '/Strategy_3','/amp_scale_', num2str(amp_scale(aa)), '_TO_', num2str(timeOverlapThreshold)];
                    end
                    
                    precision_file_path = [sharedFolder, '/', cur_algorithm_type, 'Precision_'];
                    recall_file_path = [sharedFolder, '/', cur_algorithm_type, 'Recall_'];
                    FScore_file_path = [sharedFolder, '/', cur_algorithm_type, 'FScore_'];
                    %                     for ii = 1 : size(testCaseIndex, 2)
                    %                         precision_file = [precision_file_path, num2str(testCaseIndex(ii)), '.csv'];
                    %                         recall_file = [recall_file_path, num2str(testCaseIndex(ii)), '.csv'];
                    %                         FScore_file = [FScore_file_path, num2str(testCaseIndex(ii)), '.csv'];
                    %
                    %                         precision_matrix = csvread(precision_file);
                    %                         recall_matrix = csvread(recall_file);
                    %                         FScore_matrix = csvread(FScore_file);
                    %
                    %                         new_precision_matrix = zeros(size(precision_matrix, 1) + 1, size(precision_matrix, 2) + 1);
                    %                         new_recall_matrix = zeros(size(recall_matrix, 1) + 1, size(recall_matrix, 2) + 1);
                    %                         new_FScore_matrix = zeros(size(FScore_matrix, 1) + 1, size(FScore_matrix, 2) + 1);
                    %
                    %                         num_output_class = size(precision_matrix, 1);
                    %                         num_of_class = size(precision_matrix, 2);
                    %
                    %                         for jj = 1 : num_output_class
                    %                             new_precision_matrix(jj, 1 : size(precision_matrix, 2)) = precision_matrix(jj, :);
                    %                             if(sum(isnan(precision_matrix(jj, :)) > 0))
                    %                                 my_precision = max(precision_matrix(jj, :));
                    %                             else
                    %                                 my_precision = mean(precision_matrix(jj, :));
                    %                             end
                    %                             new_precision_matrix(jj, size(new_precision_matrix, 2)) = my_precision;
                    %
                    %                             new_recall_matrix(jj, 1 : size(recall_matrix, 2)) = recall_matrix(jj, :);
                    %                             if(sum(isnan(recall_matrix(jj, :)) > 0))
                    %                                 my_recall = max(recall_matrix(jj, :));
                    %                             else
                    %                                 my_recall = mean(recall_matrix(jj, :));
                    %                             end
                    %                             new_recall_matrix(jj, size(new_recall_matrix, 2)) = my_recall;
                    %
                    %                             new_FScore_matrix(jj, 1 : size(FScore_matrix, 2)) = FScore_matrix(jj, :);
                    %                             if(sum(isnan(FScore_matrix(jj, :)) > 0))
                    %                                 my_FScore = max(FScore_matrix(jj, :));
                    %                             else
                    %                                 my_FScore = mean(FScore_matrix(jj, :));
                    %                             end
                    %                             new_FScore_matrix(jj, size(new_FScore_matrix, 2)) = my_FScore;
                    %                         end
                    %
                    %                         for jj = 1 : size(new_precision_matrix, 2)
                    %                             nan_index = isnan(new_precision_matrix(:, jj));
                    %                             number_index = find(nan_index ~= 1);
                    %                             new_precision_matrix(size(new_precision_matrix, 1), jj) = sum(new_precision_matrix(number_index, jj)) / (size(number_index, 1) - 1) ;
                    %                         end
                    %
                    %                         for jj = 1 : size(new_recall_matrix, 2)
                    %                             nan_index = isnan(new_recall_matrix(:, jj));
                    %                             number_index = find(nan_index ~= 1);
                    %                             new_recall_matrix(size(new_recall_matrix, 1), jj) = sum(new_recall_matrix(number_index, jj)) / (size(number_index, 1) - 1) ;
                    %                         end
                    %
                    %                         for jj = 1 : size(new_FScore_matrix, 2)
                    %                             nan_index = isnan(new_FScore_matrix(:, jj));
                    %                             number_index = find(nan_index ~= 1);
                    %                             new_FScore_matrix(size(new_FScore_matrix, 1), jj) = sum(new_FScore_matrix(number_index, jj)) / (size(number_index, 1) - 1);
                    %                         end
                    %
                    %                         %     save_precision_file = [savePathRMT, '/RMTPrecision_', num2str(testCaseIndex(ii)), '.csv'];
                    %                         %     save_recall_file = [savePathRMT, '/RMTRecall_', num2str(testCaseIndex(ii)), '.csv'];
                    %                         %     save_FScore_file = [savePathRMT, '/RMTFScore_', num2str(testCaseIndex(ii)), '.csv'];
                    %
                    %                         save_precision_file = precision_file;
                    %                         save_recall_file = recall_file;
                    %                         save_FScore_file = FScore_file;
                    %
                    %                         csvwrite(save_precision_file, new_precision_matrix);
                    %                         csvwrite(save_recall_file, new_recall_matrix);
                    %                         csvwrite(save_FScore_file, new_FScore_matrix);
                    %                     end
                    
                    aggregated_precision_file = csvread([precision_file_path, overlapping,'aggregated.csv']);
                    aggregated_recall_file = csvread([recall_file_path, overlapping,'aggregated.csv']);
                    aggregated_FScore_file = csvread([FScore_file_path, overlapping,'aggregated.csv']);
                    meantemp= mean(aggregated_precision_file);
                    PrecisionforPercentage = [PrecisionforPercentage,meantemp(:,2:end-1)];
                    meantemp= mean(aggregated_recall_file)
                    RecallforPercentage = [RecallforPercentage,meantemp(:,2:end-1)];
                    meantemp=mean(aggregated_FScore_file);
                    FscoreforPercentage = [FscoreforPercentage,meantemp(:,2:end-1)];
                    
                    
                    %                     aggregated_precision = zeros(size(testCaseIndex, 2), cur_num_of_motif+1+1);
                    %                     aggregated_recall = zeros(size(testCaseIndex, 2), cur_num_of_motif+1+1);
                    %                     aggregated_FScore = zeros(size(testCaseIndex, 2), cur_num_of_motif+1+1);
                    %                     for ii = 1 : size(testCaseIndex, 2)
                    %                         precision_file = [precision_file_path, num2str(testCaseIndex(ii)), '.csv'];
                    %                         recall_file = [recall_file_path, num2str(testCaseIndex(ii)), '.csv'];
                    %                         FScore_file = [FScore_file_path, num2str(testCaseIndex(ii)), '.csv'];
                    %
                    %                         precision_matrix = csvread(precision_file);
                    %                         recall_matrix = csvread(recall_file);
                    %                         FScore_matrix = csvread(FScore_file);
                    %
                    %                         aggregated_precision(ii, 1) = testCaseIndex(ii);
                    %                         aggregated_recall(ii, 1) = testCaseIndex(ii);
                    %                         aggregated_FScore(ii, 1) = testCaseIndex(ii);
                    %
                    %                         aggregated_precision(ii, 2 : end) = precision_matrix(size(precision_matrix, 1), :);
                    %                         aggregated_recall(ii, 2 : end) = recall_matrix(size(recall_matrix, 1), :);
                    %                         aggregated_FScore(ii, 2 : end) = FScore_matrix(size(FScore_matrix, 1), :);
                    %                     end
                    %
                    %                     csvwrite(aggregated_precision_file, aggregated_precision);
                    %                     csvwrite(aggregated_recall_file, aggregated_recall);
                    %                     csvwrite(aggregated_FScore_file, aggregated_FScore);
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

fprintf('All done .\n');