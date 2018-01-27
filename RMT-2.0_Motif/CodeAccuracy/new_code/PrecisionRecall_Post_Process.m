clear;
clc;

fprintf('Post procesing precision and recall files... \n');
% iterate file to for upload
testCaseIndex = 22 : 33;

algorithm_type = ['MatrixProfile']; % MatrixProfile RMT RME cleanmatlabentropy09

% precision_file_path = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif2/', algorithm_type, 'Precision_'];
% recall_file_path = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif2/', algorithm_type, 'Recall_'];
% FScore_file_path = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif2/', algorithm_type, 'FScore_'];

precision_file_path = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif/cleanmatlabentropy09/', algorithm_type, 'Precision_'];
recall_file_path = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif/cleanmatlabentropy09/', algorithm_type, 'Recall_'];
FScore_file_path = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif/cleanmatlabentropy09/', algorithm_type, 'FScore_'];


for i = 1 : size(testCaseIndex, 2)
    fprintf('Test case: %d .\n', testCaseIndex(i));
    
    precision_file = [precision_file_path, num2str(testCaseIndex(i)), '.csv'];
    recall_file = [recall_file_path, num2str(testCaseIndex(i)), '.csv'];
    FScore_file = [FScore_file_path, num2str(testCaseIndex(i)), '.csv'];
    
    precision_matrix = csvread(precision_file);
    recall_matrix = csvread(recall_file);
    FScore_matrix = csvread(FScore_file);
    
    new_precision_matrix = zeros(size(precision_matrix, 1) + 1, size(precision_matrix, 2) + 1);
    new_recall_matrix = zeros(size(recall_matrix, 1) + 1, size(recall_matrix, 2) + 1);
    new_FScore_matrix = zeros(size(FScore_matrix, 1) + 1, size(FScore_matrix, 2) + 1);
    
    num_output_class = size(precision_matrix, 1);
    num_of_class = size(precision_matrix, 2);
    
    for j = 1 : num_output_class
        new_precision_matrix(j, 1 : size(precision_matrix, 2)) = precision_matrix(j, :);
        if(sum(isnan(precision_matrix(j, :)) > 0))
            my_precision = max(precision_matrix(j, :));
        else
            my_precision = mean(precision_matrix(j, :));
        end
        new_precision_matrix(j, size(new_precision_matrix, 2)) = my_precision;
        
        new_recall_matrix(j, 1 : size(recall_matrix, 2)) = recall_matrix(j, :);
        if(sum(isnan(recall_matrix(j, :)) > 0))
            my_recall = max(recall_matrix(j, :));
        else
            my_recall = mean(recall_matrix(j, :));
        end
        new_recall_matrix(j, size(new_recall_matrix, 2)) = my_recall;
        
        new_FScore_matrix(j, 1 : size(FScore_matrix, 2)) = FScore_matrix(j, :);
        if(sum(isnan(FScore_matrix(j, :)) > 0))
            my_FScore = max(FScore_matrix(j, :));
        else
            my_FScore = mean(FScore_matrix(j, :));
        end
        new_FScore_matrix(j, size(new_FScore_matrix, 2)) = my_FScore;
    end
    
    for j = 1 : size(new_precision_matrix, 2)
       nan_index = isnan(new_precision_matrix(:, j));
       number_index = find(nan_index ~= 1);
       new_precision_matrix(size(new_precision_matrix, 1), j) = sum(new_precision_matrix(number_index, j)) / (size(number_index, 1) - 1) ;
    end
    
    for j = 1 : size(new_recall_matrix, 2)
       nan_index = isnan(new_recall_matrix(:, j));
       number_index = find(nan_index ~= 1);
       new_recall_matrix(size(new_recall_matrix, 1), j) = sum(new_recall_matrix(number_index, j)) / (size(number_index, 1) - 1) ;
    end
    
    for j = 1 : size(new_FScore_matrix, 2)
       nan_index = isnan(new_FScore_matrix(:, j));
       number_index = find(nan_index ~= 1);
       new_FScore_matrix(size(new_FScore_matrix, 1), j) = sum(new_FScore_matrix(number_index, j)) / (size(number_index, 1) - 1);
    end
    
    % save_precision_file = [savePathRMT, '/RMTPrecision_', num2str(testCaseIndex(ii)), '.csv'];
    % save_recall_file = [savePathRMT, '/RMTRecall_', num2str(testCaseIndex(ii)), '.csv'];
    % save_FScore_file = [savePathRMT, '/RMTFScore_', num2str(testCaseIndex(ii)), '.csv'];
    
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

aggregated_precision = zeros(size(testCaseIndex, 2), 3+1);
aggregated_recall = zeros(size(testCaseIndex, 2), 3+1);
aggregated_FScore = zeros(size(testCaseIndex, 2), 3+1);
for i = 1 : size(testCaseIndex, 2)
    precision_file = [precision_file_path, num2str(testCaseIndex(i)), '.csv'];
    recall_file = [recall_file_path, num2str(testCaseIndex(i)), '.csv'];
    FScore_file = [FScore_file_path, num2str(testCaseIndex(i)), '.csv'];
    
    precision_matrix = csvread(precision_file);
    recall_matrix = csvread(recall_file);
    FScore_matrix = csvread(FScore_file);
    
    aggregated_precision(i, 1) = testCaseIndex(i);
    aggregated_recall(i, 1) = testCaseIndex(i);
    aggregated_FScore(i, 1) = testCaseIndex(i);
    
    aggregated_precision(i, 2 : end) = precision_matrix(size(precision_matrix, 1), :);
    aggregated_recall(i, 2 : end) = recall_matrix(size(recall_matrix, 1), :);
    aggregated_FScore(i, 2 : end) = FScore_matrix(size(FScore_matrix, 1), :);
end

csvwrite(aggregated_precision_file, aggregated_precision);
csvwrite(aggregated_recall_file, aggregated_recall);
csvwrite(aggregated_FScore_file, aggregated_FScore);
fprintf('All done .\n');