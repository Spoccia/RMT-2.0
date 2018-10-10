clear;
clc;
DS_Name ='Mocap';
Path = ['D:\Motif_Results\Datasets\SynteticDataset\',DS_Name];

fprintf('Post procesing precision and recall files... \n');
testCaseIndex = 1 : 300; % 30 time series used, 10 instances each
% strategy = [1:9];
% num_of_motif = [1:3];
num_of_motif = [1:3];
strategy = [1, 3, 4, 6, 7, 9];
algorithm_type = {'RMT', 'MStamp'}; % MStamp, MatrixProfile, RMT, RME, cleanmatlabentropy09
% algorithm_type = {'RMT'}; % MStamp, MatrixProfile, RMT, RME, cleanmatlabentropy09
timeOverlapThresholds = [0.1, 0.25, 0.5, 0.75, 1];
amp_scale = [0, 0.1, 0.25, 0.5, 0.75, 1, 2];

allresults=[];

for i = 1 : size(num_of_motif, 2)
    AllStrategy_Precision=[];
    AllStrategy_Recall=[];
    AllStrategy_Fscore=[];
    for j = 1 : size(strategy, 2)
        PrecisionRWScale=[];
        RecallRWScale=[];
        FscoreRWScale=[];
        for aa = 1 : size(amp_scale, 2)
            for tt = 1 : size(timeOverlapThresholds, 2)
                timeOverlapThreshold = timeOverlapThresholds(tt);
                PrecisionAggregatedMAtrix = [];
                RecallAggregatedMAtrix = [];
                FscoreAggregatedMAtrix = [];
                for kk = 1 : size(algorithm_type, 2)
                    
                    PrecisionforPercentage = [];
                    RecallforPercentage = [];
                    FscoreforPercentage = [];
                    
                    %dataAggregatedMAtrix (:,1)= timeOverlapThresholds';
                    
                    cur_algorithm_type = algorithm_type{kk};
                    cur_strategy = strategy(j);
                    cur_num_of_motif = num_of_motif(i);
                    
                    fprintf('num_of_motif: %d, strategy: %d, algorithm_type: %s, amplitude scale: %f, time overlap threshold: %f . \n', cur_num_of_motif, cur_strategy, cur_algorithm_type, amp_scale(aa), timeOverlapThreshold);
                    sharedFolder = [Path,'/Result/', cur_algorithm_type, '_Motif', num2str(cur_num_of_motif), '/Strategy_', num2str(cur_strategy), '/amp_scale_', num2str(amp_scale(aa)), '_TO_', num2str(timeOverlapThreshold)];
                    if kk==2
                        sharedFolder = [Path,'/Result/', cur_algorithm_type, '_Motif', num2str(cur_num_of_motif), '/Strategy_1','/amp_scale_', num2str(amp_scale(aa)), '_TO_', num2str(timeOverlapThreshold)];
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
                    
                    aggregated_precision_file = csvread([precision_file_path, 'aggregated.csv']);
                    aggregated_recall_file = csvread([recall_file_path, 'aggregated.csv']);
                    aggregated_FScore_file = csvread([FScore_file_path, 'aggregated.csv']);
                    PrecisionforPercentage = [PrecisionforPercentage,mean(aggregated_precision_file)];
                    RecallforPercentage = [RecallforPercentage,mean(aggregated_recall_file)];
                    FscoreforPercentage = [FscoreforPercentage,mean(aggregated_FScore_file)];
                    
                    
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
            
            PrecisionRWScale=[PrecisionRWScale,[PrecisionAggregatedMAtrix,zeros(size(PrecisionAggregatedMAtrix,1),i)]];
            RecallRWScale=[RecallRWScale,[RecallAggregatedMAtrix,zeros(size(RecallAggregatedMAtrix,1),i)]];
            FscoreRWScale=[FscoreRWScale,[FscoreAggregatedMAtrix,zeros(size(FscoreAggregatedMAtrix,1),i)]];
            
        end
        AllStrategy_Precision=[AllStrategy_Precision;[ones(size(PrecisionAggregatedMAtrix,1),1)*strategy(j),PrecisionRWScale]];
        AllStrategy_Recall=[AllStrategy_Recall;[ones(size(PrecisionAggregatedMAtrix,1),1)*strategy(j),RecallRWScale]];
        AllStrategy_Fscore=[AllStrategy_Fscore;[ones(size(PrecisionAggregatedMAtrix,1),1)*strategy(j),FscoreRWScale]];
        finalpath = [Path,'/Result/', '_Motif', num2str(cur_num_of_motif)];
        csvwrite([finalpath,'_Precision.csv'],[timeOverlapThresholds',AllStrategy_Precision])
        csvwrite([finalpath,'_Recall.csv'], [timeOverlapThresholds',AllStrategy_Recall]);
        csvwrite([finalpath,'_Fscore.csv'], [timeOverlapThresholds',AllStrategy_Fscore]);
    end
end

fprintf('All done .\n');