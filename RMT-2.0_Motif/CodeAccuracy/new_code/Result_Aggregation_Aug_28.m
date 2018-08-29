clear;
clc;

% Aggregate RMT & MStamp in one sheet
fprintf('Aggregating precision and recall files... \n');
testCaseIndex = 1 : 100; % 30 time series used, 10 instances each
strategy = [1:9];
num_of_motif = [1:3];
algorithm_type = {'RMT', 'MStamp'}; % MStamp, MatrixProfile, RMT, RME, cleanmatlabentropy09
timeOverlapThresholds = [0.1, 0.25, 0.5, 0.75, 1];
amp_scale = [0, 0.1, 0.25, 0.5, 0.75, 1];

for i = 1 : size(num_of_motif, 2)
    cur_num_of_motif = num_of_motif(i);
    for j = 1 : size(strategy, 2)
        % create a new file for each number of motif and each strategy
        % file_name = ['motif_', num2str(cur_num_of_motif), '_strategy_', num2str(cur_strategy), '.xlsx'];
        
        cur_strategy = strategy(j);
        for aa = 1 : size(amp_scale, 2)
            cur_amp_scale = amp_scale(aa);
            precision_file_name = ['motif_', num2str(cur_num_of_motif), '_strategy_', num2str(cur_strategy), '_amp_', num2str(cur_amp_scale), '_precision.txt'];
            recall_file_name = ['motif_', num2str(cur_num_of_motif), '_strategy_', num2str(cur_strategy), '_amp_', num2str(cur_amp_scale), '_recall.txt'];
            FScore_file_name = ['motif_', num2str(cur_num_of_motif), '_strategy_', num2str(cur_strategy), '_amp_', num2str(cur_amp_scale), '_FScore.txt'];
            % define a sheet/table name -- write both RMT and MStamp
            
            % sheet_name = ['amp_', num2str(cur_amp_scale), '_TO_', num2str(cur_strategy)];
            clusterID = testCaseIndex';
            precision_table_column = [];
            precision_table_column{1} = [];
            precision_table_column{2} = [];
            
            recall_table_column = [];
            recall_table_column{1} = [];
            recall_table_column{2} = [];
            
            FScore_table_column = [];
            FScore_table_column{1} = [];
            FScore_table_column{2} = [];
            
            for kk = 1 : size(algorithm_type, 2)
                cur_algorithm_type = algorithm_type{kk};
                
                % table_column{kk}
                for tt = 1 : size(timeOverlapThresholds, 2)
                    timeOverlapThreshold = timeOverlapThresholds(tt);
                    
                    
                    fprintf('num_of_motif: %d, strategy: %d, algorithm_type: %s, amplitude scale: %f, time overlap threshold: %f . \n', cur_num_of_motif, cur_strategy, cur_algorithm_type, amp_scale(aa), timeOverlapThreshold);
                    sharedFolder = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Aug_20/First_10_Result_Backup/Result_', cur_algorithm_type, '_Motif', num2str(cur_num_of_motif), '/Strategy_', num2str(cur_strategy), '/amp_scale_', num2str(amp_scale(aa)), '_TO_', num2str(timeOverlapThreshold)];
                    aggregated_precision_file = [sharedFolder, '/', cur_algorithm_type, 'Precision_aggregated.csv'];
                    aggregated_recall_file = [sharedFolder, '/', cur_algorithm_type, 'Recall_aggregated.csv'];
                    aggregated_FScore_file = [sharedFolder, '/', cur_algorithm_type, 'FScore_aggregated.csv'];
                    aggregated_precision = csvread(aggregated_precision_file);
                    aggregated_recall = csvread(aggregated_recall_file);
                    aggregated_FScore = csvread(aggregated_FScore_file);
                    
                    precision = aggregated_precision(:, 2 : end - 1);
                    recall = aggregated_recall(:, 2 : end - 1);
                    FScore = aggregated_FScore(:, 2 : end - 1);
                    % seprate values from different algorithm type
                    precision_table_column{kk} = [precision_table_column{kk} precision];
                    recall_table_column{kk} = [recall_table_column{kk} recall];
                    FScore_table_column{kk} = [FScore_table_column{kk} FScore];
                end
            end
            % put together as a table
            precison_Table = table(clusterID, precision_table_column{1}, precision_table_column{2});
            precison_Table
        end
    end
end

fprintf('All done .\n');