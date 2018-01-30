clear;
clc;

% iterate file to for upload
% testCaseIndex = 34 : 45;
testCaseIndex =  34 : 45;
weighted = 0;

RMTClustering = ['clean_adaptive_kmeans_siluhette_best']; % cleanmyentropy08 normalAVGAVG normalAVGSum normalSUM cleanmatlabentropy09 avgsum_GlobQuant_64 sumsum_GlobQuant_255
% clean_adaptive_kmeans_siluhette_best clean_adaptive_kmeans_siluhette_80

GroundTruthFilePath = ['/Users/sliu104/Desktop/motif2/Groundtruth/IndexEmbeddedFeatures/FeaturePosition_Mocap_test'];

% MatrixProfileFilePath = ['/Users/sliu104/Desktop/motif2/Mstamp/Mocap_test'];
MatrixProfileFilePath = ['/Users/sliu104/Desktop/motif/Mstamp/candanDistance/Mocap_test'];
RMEMotifFilePath = ['/Users/sliu104/Desktop/motif2/RME/AP_DepO_2_DepT_2_Mocap_test'];

RMTMotifFilePath = ['/Users/sliu104/Desktop/syntRST/motif2/RMT/AP_DepO_2_DepT_2_Mocap_test'];
% RMTMotifFilePath = ['/Users/sliu104/Desktop/syntRST/motif2/RMT/clean_siluhette/clean_adaptive_kmeans_siluhette_80/AP_DepO_2_DepT_2_Mocap_test'];

% clean_cluster_file_path = ['/Users/sliu104/Desktop/syntRST/motif2/RMT/Clean_average_adaptive_0.3'];
clean_cluster_file_path = ['/Users/sliu104/Desktop/syntRST/motif2/RMT/clean_siluhette/clean_adaptive_kmeans_siluhette_80'];


savePathRME = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif2', RMTClustering];
savePathRMT = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif2'];
savePathMatrixProfile = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif/', RMTClustering];

MatrixProfileEntropy = [];
RMTMotifEntropy = [];
RMEMotifEntropy = [];

for ii = 1 : size(testCaseIndex, 2)
    fprintf('Test case: %d .\n', testCaseIndex(ii));
    GroundTruthFile = [GroundTruthFilePath, num2str(testCaseIndex(ii)), '.csv'];
    MatrixProfileFile = [MatrixProfileFilePath, num2str(testCaseIndex(ii)), '.csv'];
    RMTMotifFile = [RMTMotifFilePath, num2str(testCaseIndex(ii)), '.csv'];
    RMEMotifFile = [RMEMotifFilePath, num2str(testCaseIndex(ii)), '.csv'];
    
    % clean_cluster_file = [clean_cluster_file_path, '/Cluster_AKmeansClusterCleanMocap_test', num2str(testCaseIndex(ii)), '_DepO_2_DepT_2.csv'];
    clean_cluster_file = [clean_cluster_file_path, '/ClusterClean_Mocap_test', num2str(testCaseIndex(ii)), '_DepO_2_DepT_2.csv'];
    
    
    threshold = eps; % if it is non-zero
    
    windowSize = 58;
    if(weighted == 1)
        % algorithmType = 'MatrixProfile';
        % [currentMatrixProfileEntropy, precisionMatrixMatrixProfile, recallMatrixMatrixProfile, FScoreMatrixMatrixProfile] = motifEvaluationWeighted(GroundTruthFile, MatrixProfileFile, algorithmType, windowSize);
        % algorithmType = 'RMT';
        % [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT] = motifEvaluationWeighted(GroundTruthFile, RMTMotifFile, algorithmType, windowSize);
        
        % algorithmType = 'RME';
        % [currentRMEMotifEntropy, precisionMatrixRME, recallMatrixRME, FScoreMatrixRME] = motifEvaluationWeighted(GroundTruthFile, RMEMotifFile, algorithmType, windowSize);
    else
        algorithmType = 'RMT';
        [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT] = motifEvaluation_clean_cluster_format(GroundTruthFile, RMTMotifFile, clean_cluster_file, algorithmType, windowSize, threshold);
        
        
    end
    
    % MatrixProfileEntropy = [MatrixProfileEntropy ; currentMatrixProfileEntropy];
    RMTMotifEntropy = [RMTMotifEntropy ; currentRMTMotifEntropy];
    % RMEMotifEntropy = [RMEMotifEntropy; currentRMEMotifEntropy];
    
%     % save current Matrix to files
%     savePathMatrixProfilePrecision = [savePathMatrixProfile, '/MatrixProfilePrecision_', num2str(testCaseIndex(ii)), '.csv'];
%     savePathMatrixProfileRecall = [savePathMatrixProfile, '/MatrixProfileRecall_', num2str(testCaseIndex(ii)), '.csv'];
%     savePathMatrixProfileFScore = [savePathMatrixProfile, '/MatrixProfileFScore_', num2str(testCaseIndex(ii)), '.csv'];
%     csvwrite(savePathMatrixProfilePrecision, precisionMatrixMatrixProfile);
%     csvwrite(savePathMatrixProfileRecall, recallMatrixMatrixProfile);
%     csvwrite(savePathMatrixProfileFScore, FScoreMatrixMatrixProfile)

    savePathRMTPrecision = [savePathRMT, '/RMTPrecision_', num2str(testCaseIndex(ii)), '.csv'];
    savePathRMTRecall = [savePathRMT, '/RMTRecall_', num2str(testCaseIndex(ii)), '.csv'];
    savePathRMTFScore = [savePathRMT, '/RMTFScore_', num2str(testCaseIndex(ii)), '.csv'];
    csvwrite(savePathRMTPrecision, precisionMatrixRMT);
    csvwrite(savePathRMTRecall, recallMatrixRMT);
    csvwrite(savePathRMTFScore, FScoreMatrixRMT);
    
%     savePathRMEPrecision = [savePathRME, '/RMEPrecision_', num2str(testCaseIndex(ii)), '.csv'];
%     savePathRMERecall = [savePathRME, '/RMERecall_', num2str(testCaseIndex(ii)), '.csv'];
%     savePathRMEFScore = [savePathRME, '/RMEFScore_', num2str(testCaseIndex(ii)), '.csv'];
%     csvwrite(savePathRMEPrecision, precisionMatrixRME);
%     csvwrite(savePathRMERecall, recallMatrixRME);
%     csvwrite(savePathRMEFScore, FScoreMatrixRME);
    
end
% entropy: precision entropy, recall entropy, FScore entropy
% RME_Entropy_Ouput_Path = [savePathRME, '/RMEMotifEntropy.csv'];
RMT_Entropy_Ouput_Path = [savePathRMT, '/RMTMotifEntropy.csv'];
% MatrixProfile_Entropy_Ouput_Path = [savePathMatrixProfile, '/MatrixProfileEntropy.csv'];

% csvwrite(RME_Entropy_Ouput_Path, RMEMotifEntropy);
csvwrite(RMT_Entropy_Ouput_Path, RMTMotifEntropy);
% csvwrite(MatrixProfile_Entropy_Ouput_Path, MatrixProfileEntropy);

fprintf('All done .\n');