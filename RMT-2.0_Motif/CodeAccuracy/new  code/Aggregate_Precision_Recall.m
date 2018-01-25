clear;
clc;

% first determine how many motifs injected, starting from 1-motif
testCaseIndex =  10 : 33;

% 10 - 21: 1 motif results
% 22 - 33: 2 motif results
motif_range_1 = [10 : 21];
motif_range_2 = [22 : 33];
pivot = [10, 22, 34];
num_of_motif = 1;

RMTClustering = ['cleanmatlabentropy09']; % cleanmyentropy08 normalAVGAVG normalAVGSum normalSUM cleanmatlabentropy09
MatrixProfileFilePath = ['/Users/sliu104/Desktop/MoCapTestData_Motif/', RMTClustering, '/MatrixProfile'];
RMTFilePath = ['/Users/sliu104/Desktop/MoCapTestData_Motif/', RMTClustering, '/RMT'];

savePathRMT = ['/Users/sliu104/Desktop/MoCapTestData_Motif/', RMTClustering];
savePathMatrixProfile = ['/Users/sliu104/Desktop/MoCapTestData_Motif/', RMTClustering];

for i = 1 : size(pivot, 2) - 1
    mean_matrix_profile_precision = [];
    mean_matrix_profile_recall = [];
    mean_matrix_profile_FScore = [];
    
    mean_RMT_precision = [];
    mean_RMT_recall = [];
    mean_RMT_FScore = [];
    start_index = pivot(i);
    end_index = pivot(i + 1);
    for j = start_index : end_index - 1
        fprintf('Test case: %d .\n', j);
        
        MatrixProfilePrecisionFile = [MatrixProfileFilePath, 'precision_', num2str(j), '.csv'];
        MatrixProfileRecallFile = [MatrixProfileFilePath, 'recall_', num2str(j), '.csv'];
        MatrixProfileFScoreFile = [MatrixProfileFilePath, 'FScore_', num2str(j), '.csv'];
        
        % precision, recall, FScore
        matrix_profile_precision_matrix = csvread(MatrixProfilePrecisionFile);
        matrix_profile_recall_matrix = csvread(MatrixProfileRecallFile);
        matrix_profile_FScore_matrix = csvread(MatrixProfileFScoreFile);
        
        mean_matrix_profile_precision = [mean_matrix_profile_precision; mean(matrix_profile_precision_matrix)];
        mean_matrix_profile_recall = [mean_matrix_profile_recall; mean(matrix_profile_recall_matrix)];
        mean_matrix_profile_FScore = [mean_matrix_profile_FScore; mean(matrix_profile_FScore_matrix)];
        
        
        RMTPrecisionFile = [RMTFilePath, 'precision_', num2str(j), '.csv'];
        RMTRecallFile = [RMTFilePath, 'recall_', num2str(j), '.csv'];
        RMTFScoreFile = [RMTFilePath, 'FScore_', num2str(j), '.csv'];
        
        RMT_precision_matrix = csvread(RMTPrecisionFile);
        RMT_recall_matrix = csvread(RMTRecallFile);
        RMT_FScore_matrix = csvread(RMTFScoreFile);
        
        mean_RMT_precision = [mean_RMT_precision; mean(RMT_precision_matrix)];
        mean_RMT_recall = [mean_RMT_recall; mean(RMT_recall_matrix)];
        mean_RMT_FScore = [mean_RMT_FScore; mean(RMT_FScore_matrix)];
    end
    if(exist([savePathMatrixProfile, '/', num2str(i), '_motif'], 'dir')==0)
        mkdir([savePathMatrixProfile, '/', num2str(i), '_motif']);
    end
    if(exist([savePathRMT, '/', num2str(i), '_motif'], 'dir')==0)
        mkdir([savePathRMT, '/', num2str(i), '_motif']);
    end
    matrix_profile_mean_precision_save_path = [savePathMatrixProfile, '/', num2str(i), '_motif/matrix_profile_mean_precision.csv'];
    matrix_profile_mean_recall_save_path = [savePathMatrixProfile, '/', num2str(i), '_motif/matrix_profile_mean_recall.csv'];
    matrix_profile_mean_FScore_save_path = [savePathMatrixProfile, '/', num2str(i), '_motif/matrix_profile_mean_FScore.csv'];
    
    RMT_mean_precision_save_path = [savePathRMT, '/', num2str(i), '_motif/RMT_mean_precision.csv'];
    RMT_mean_recall_save_path = [savePathRMT, '/', num2str(i), '_motif/RMT_mean_reall.csv'];
    RMT_mean_FScore_save_path = [savePathRMT, '/', num2str(i), '_motif/RMT_mean_FScore.csv'];
    
    csvwrite(matrix_profile_mean_precision_save_path, mean_matrix_profile_precision);
    csvwrite(matrix_profile_mean_recall_save_path, mean_matrix_profile_recall);
    csvwrite(matrix_profile_mean_FScore_save_path, mean_matrix_profile_FScore);
    
    csvwrite(RMT_mean_precision_save_path, mean_RMT_precision);
    csvwrite(RMT_mean_recall_save_path, mean_RMT_recall);
    csvwrite(RMT_mean_FScore_save_path, mean_RMT_FScore);
    
    % clear storage structure
    mean_matrix_profile_precision = [];
    mean_matrix_profile_recall = [];
    mean_matrix_profile_FScore = [];
    
    mean_RMT_precision = [];
    mean_RMT_recall = [];
    mean_RMT_FScore = [];
    
end
fprintf('All done .\n');