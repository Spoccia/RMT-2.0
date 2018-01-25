clear;
clc;

fprintf('Post procesing precision and recall files... \n');
% iterate file to for upload
testCaseIndex = 34 : 45;

algorithm_type = ['MatrixProfile']; % MatrixProfile RMT
precision_file_path = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif2/', algorithm_type, 'Precision_'];
recall_file_path = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif2/', algorithm_type, 'Recall_'];
FScore_file_path = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif2/', algorithm_type, 'FScore_'];

for i = 1 : size(testCaseIndex, 2)
    fprintf('Test case: %d .\n', testCaseIndex(i));
    
    precision_file = [precision_file_path, num2str(testCaseIndex(i)), '.csv'];
    recall_file = [recall_file_path, num2str(testCaseIndex(i)), '.csv'];
    FScore_file = [FScore_file_path, num2str(testCaseIndex(i)), '.csv'];
    
    precision_matrix = csvread(precision_file);
    recall_matrix = csvread(recall_file);
    FScore_matrix = csvread(FScore_file);
    
    new_precision_matrix = zeros(size(precision_matrix, 1), size(precision_matrix, 2) + 1);
    new_recall_matrix = zeros(size(recall_matrix, 1), size(recall_matrix, 2) + 1);
    new_FScore_matrix = zeros(size(FScore_matrix, 1), size(FScore_matrix, 2) + 1);
    
    num_output_class = size(precision_matrix, 1);
    num_of_class = size(precision_matrix, 2);
    
    for j = 1 : num_output_class
        new_precision_matrix(j, 1 : size(precision_matrix, 2)) = precision_matrix(j, :);
        max_precision = max(precision_matrix(j, :));
        new_precision_matrix(j, size(new_precision_matrix, 2)) = max_precision;
        
        new_recall_matrix(j, 1 : size(recall_matrix, 2)) = recall_matrix(j, :);
        max_recall = max(recall_matrix(j, :));
        new_recall_matrix(j, size(new_recall_matrix, 2)) = max_recall;
        
        new_FScore_matrix(j, 1 : size(FScore_matrix, 2)) = FScore_matrix(j, :);
        max_FScore = max(FScore_matrix(j, :));
        new_FScore_matrix(j, size(new_FScore_matrix, 2)) = max_FScore;
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

fprintf('All done .\n');