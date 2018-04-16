clear;
clc;

fprintf('Post procesing precision and recall files... \n');
testCaseIndex = 1 : 40;

% strategy = [1 : 6];
strategy = 6;
num_of_motif = [1 : 3];
algorithm_type = ['RMT']; % MatrixProfile RMT RME cleanmatlabentropy09
timeOverlapThresholds = [0.1, 0.25, 0.5, 0.75, 1];

% precision_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/Motif3/MatrixProfile_Motif3/', algorithm_type, 'Precision_'];
% recall_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/Motif3/MatrixProfile_Motif3/', algorithm_type, 'Recall_'];
% FScore_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/Motif3/MatrixProfile_Motif3/', algorithm_type, 'FScore_'];

% precision_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/Motif_Shifted/MatrixProfile_Motif1/', algorithm_type, 'Precision_'];
% recall_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/Motif_Shifted/MatrixProfile_Motif1/', algorithm_type, 'Recall_'];
% FScore_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/Motif_Shifted/MatrixProfile_Motif1/', algorithm_type, 'FScore_'];

% precision_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/Motif3/RMT_Motif3/', algorithm_type, 'Precision_'];
% recall_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/Motif3/RMT_Motif3/', algorithm_type, 'Recall_'];
% FScore_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/Motif3/RMT_Motif3/', algorithm_type, 'FScore_'];

% precision_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/RMT_Accuracy_Motif1_15_instances/', algorithm_type, 'Precision_'];
% recall_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/RMT_Accuracy_Motif1_15_instances/', algorithm_type, 'Recall_'];
% FScore_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/RMT_Accuracy_Motif1_15_instances/', algorithm_type, 'FScore_'];

% precision_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/MatrixProfile_Accuracy_size100_Motif_1/', algorithm_type, 'Precision_'];
% recall_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/MatrixProfile_Accuracy_size100_Motif_1/', algorithm_type, 'Recall_'];
% FScore_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/MatrixProfile_Accuracy_size100_Motif_1/', algorithm_type, 'FScore_'];

% precision_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/RMT_Accuracy_size100_Motif_1/', algorithm_type, 'Precision_'];
% recall_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/RMT_Accuracy_size100_Motif_1/', algorithm_type, 'Recall_'];
% FScore_file_path = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/RMT_Accuracy_size100_Motif_1/', algorithm_type, 'FScore_'];
for tt = 1 : size(timeOverlapThresholds, 2)
    timeOverlapThreshold = timeOverlapThresholds(tt);
    for i = 1 : size(num_of_motif, 2)
        for j = 1 : size(strategy, 2)
            
            % cur_algorithm_type = algorithm_type(k);
            cur_algorithm_type = algorithm_type;
            cur_strategy = strategy(j);
            cur_num_of_motif = num_of_motif(i);
            
            fprintf('num_of_motif: %d, strategy: %d, algorithm_type: %s, time overlap threshold: %f . \n', cur_num_of_motif, cur_strategy, cur_algorithm_type, timeOverlapThreshold);
            
            sharedFolder = ['/Users/sliu104/Desktop/Results_Motif_Save/Motif', num2str(cur_num_of_motif), '/Strategy_', num2str(cur_strategy), '/TO_', num2str(timeOverlapThreshold)];
            precision_file_path = [sharedFolder, '/', algorithm_type, 'Precision_'];
            recall_file_path = [sharedFolder, '/', algorithm_type, 'Recall_'];
            FScore_file_path = [sharedFolder, '/', algorithm_type, 'FScore_'];
            for ii = 1 : size(testCaseIndex, 2)
                % fprintf('Test case: %d .\n', testCaseIndex(ii));
                
                precision_file = [precision_file_path, num2str(testCaseIndex(ii)), '.csv'];
                recall_file = [recall_file_path, num2str(testCaseIndex(ii)), '.csv'];
                FScore_file = [FScore_file_path, num2str(testCaseIndex(ii)), '.csv'];
                
                precision_matrix = csvread(precision_file);
                recall_matrix = csvread(recall_file);
                FScore_matrix = csvread(FScore_file);
                
                new_precision_matrix = zeros(size(precision_matrix, 1) + 1, size(precision_matrix, 2) + 1);
                new_recall_matrix = zeros(size(recall_matrix, 1) + 1, size(recall_matrix, 2) + 1);
                new_FScore_matrix = zeros(size(FScore_matrix, 1) + 1, size(FScore_matrix, 2) + 1);
                
                num_output_class = size(precision_matrix, 1);
                num_of_class = size(precision_matrix, 2);
                
                for jj = 1 : num_output_class
                    new_precision_matrix(jj, 1 : size(precision_matrix, 2)) = precision_matrix(jj, :);
                    if(sum(isnan(precision_matrix(jj, :)) > 0))
                        my_precision = max(precision_matrix(jj, :));
                    else
                        my_precision = mean(precision_matrix(jj, :));
                    end
                    new_precision_matrix(jj, size(new_precision_matrix, 2)) = my_precision;
                    
                    new_recall_matrix(jj, 1 : size(recall_matrix, 2)) = recall_matrix(jj, :);
                    if(sum(isnan(recall_matrix(jj, :)) > 0))
                        my_recall = max(recall_matrix(jj, :));
                    else
                        my_recall = mean(recall_matrix(jj, :));
                    end
                    new_recall_matrix(jj, size(new_recall_matrix, 2)) = my_recall;
                    
                    new_FScore_matrix(jj, 1 : size(FScore_matrix, 2)) = FScore_matrix(jj, :);
                    if(sum(isnan(FScore_matrix(jj, :)) > 0))
                        my_FScore = max(FScore_matrix(jj, :));
                    else
                        my_FScore = mean(FScore_matrix(jj, :));
                    end
                    new_FScore_matrix(jj, size(new_FScore_matrix, 2)) = my_FScore;
                end
                
                for jj = 1 : size(new_precision_matrix, 2)
                    nan_index = isnan(new_precision_matrix(:, jj));
                    number_index = find(nan_index ~= 1);
                    new_precision_matrix(size(new_precision_matrix, 1), jj) = sum(new_precision_matrix(number_index, jj)) / (size(number_index, 1) - 1) ;
                end
                
                for jj = 1 : size(new_recall_matrix, 2)
                    nan_index = isnan(new_recall_matrix(:, jj));
                    number_index = find(nan_index ~= 1);
                    new_recall_matrix(size(new_recall_matrix, 1), jj) = sum(new_recall_matrix(number_index, jj)) / (size(number_index, 1) - 1) ;
                end
                
                for jj = 1 : size(new_FScore_matrix, 2)
                    nan_index = isnan(new_FScore_matrix(:, jj));
                    number_index = find(nan_index ~= 1);
                    new_FScore_matrix(size(new_FScore_matrix, 1), jj) = sum(new_FScore_matrix(number_index, jj)) / (size(number_index, 1) - 1);
                end
                
                %     save_precision_file = [savePathRMT, '/RMTPrecision_', num2str(testCaseIndex(ii)), '.csv'];
                %     save_recall_file = [savePathRMT, '/RMTRecall_', num2str(testCaseIndex(ii)), '.csv'];
                %     save_FScore_file = [savePathRMT, '/RMTFScore_', num2str(testCaseIndex(ii)), '.csv'];
                
                save_precision_file = precision_file;
                save_recall_file = recall_file;
                save_FScore_file = FScore_file;
                
                csvwrite(save_precision_file, new_precision_matrix);
                csvwrite(save_recall_file, new_recall_matrix);
                csvwrite(save_FScore_file, new_FScore_matrix);
            end
            
            aggregated_precision_file = [precision_file_path, 'aggregated.csv'];
            aggregated_recall_file = [recall_file_path, 'aggregated.csv'];
            aggregated_FScore_file = [FScore_file_path, 'aggregated.csv'];
            
            aggregated_precision = zeros(size(testCaseIndex, 2), cur_num_of_motif+1+1);
            aggregated_recall = zeros(size(testCaseIndex, 2), cur_num_of_motif+1+1);
            aggregated_FScore = zeros(size(testCaseIndex, 2), cur_num_of_motif+1+1);
            for ii = 1 : size(testCaseIndex, 2)
                precision_file = [precision_file_path, num2str(testCaseIndex(ii)), '.csv'];
                recall_file = [recall_file_path, num2str(testCaseIndex(ii)), '.csv'];
                FScore_file = [FScore_file_path, num2str(testCaseIndex(ii)), '.csv'];
                
                precision_matrix = csvread(precision_file);
                recall_matrix = csvread(recall_file);
                FScore_matrix = csvread(FScore_file);
                
                aggregated_precision(ii, 1) = testCaseIndex(ii);
                aggregated_recall(ii, 1) = testCaseIndex(ii);
                aggregated_FScore(ii, 1) = testCaseIndex(ii);
                
                aggregated_precision(ii, 2 : end) = precision_matrix(size(precision_matrix, 1), :);
                aggregated_recall(ii, 2 : end) = recall_matrix(size(recall_matrix, 1), :);
                aggregated_FScore(ii, 2 : end) = FScore_matrix(size(FScore_matrix, 1), :);
            end
            
            csvwrite(aggregated_precision_file, aggregated_precision);
            csvwrite(aggregated_recall_file, aggregated_recall);
            csvwrite(aggregated_FScore_file, aggregated_FScore);
        end
    end
end
fprintf('All done .\n');