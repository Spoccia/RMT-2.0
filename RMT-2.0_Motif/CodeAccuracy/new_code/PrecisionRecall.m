clear;
clc;

% iterate file to for upload
testCaseIndex = 46 : 57;
% testCaseIndex =  44;

weighted = 0;

RMTClustering = []; % cleanmyentropy08 normalAVGAVG normalAVGSum normalSUM cleanmatlabentropy09 avgsum_GlobQuant_64 sumsum_GlobQuant_255
% GroundTruthFilePath = ['/Users/sliu104/Desktop/motif2/Groundtruth/IndexEmbeddedFeatures/FeaturePosition_Mocap_test'];
GroundTruthFilePath = ['/Users/sliu104/Desktop/syntRST/motifs5/Groundtruth/IndexEmbeddedFeatures/FeaturePosition_Mocap_test'];

% MatrixProfileFilePath = ['/Users/sliu104/Desktop/motif2/Mstamp/Mocap_test'];
MatrixProfileFilePath = ['/Users/sliu104/Desktop/syntRST/motifs5/Mstamp/Mocap_test'];
% RMTMotifFilePath = ['/Users/sliu104/Desktop/motif/RMT/', RMTClustering, '/AP_DepO_2_DepT_2_Mocap_test'];
% RMTMotifFilePath = ['/Users/sliu104/Desktop/motif2/RMT/', RMTClustering, '/AP_DepO_2_DepT_2_Mocap_test'];
% RMTMotifFilePath = ['/Users/sliu104/Desktop/', RMTClustering, '/AP_DepO_2_DepT_2_Mocap_test'];
% RMTMotifFilePath = ['/Users/sliu104/Desktop/AP_DepO_2_DepT_2_Mocap_test'];
% RMEMotifFilePath = ['/Users/sliu104/Desktop/motif2/RME/AP_DepO_2_DepT_2_Mocap_test'];
RMTMotifFilePath = ['/Users/sliu104/Desktop/syntRST/motifs5/RMT/AP_DepO_2_DepT_2_Mocap_test'];
% RMEMotifFilePath = ['/Users/sliu104/Desktop/syntRST/motif/RME/avgsum_LocalQuant_16/AP_DepO_2_DepT_2_Mocap_test'];

% savePathRME = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif', RMTClustering];
% savePathRMT = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif2', RMTClustering];
savePathRMT = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif5/'];
% savePathMatrixProfile = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif2', RMTClustering];
savePathMatrixProfile = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_motif5/'];

MatrixProfileEntropy = [];
RMTMotifEntropy = [];
RMEMotifEntropy = [];

% algorithm type: RMT, RME or MatrixProfile
% algorithmType = 'RMT';
% algorithmType = 'RME';

for ii = 1 : size(testCaseIndex, 2)
    fprintf('Test case: %d .\n', testCaseIndex(ii));
    GroundTruthFile = [GroundTruthFilePath, num2str(testCaseIndex(ii)), '.csv'];
    MatrixProfileFile = [MatrixProfileFilePath, num2str(testCaseIndex(ii)), '.csv'];
    RMTMotifFile = [RMTMotifFilePath, num2str(testCaseIndex(ii)), '.csv'];
    % RMEMotifFile = [RMEMotifFilePath, num2str(testCaseIndex(ii)), '.csv'];
    
    % threshold = 0.5; % if it captures half of what we injected, then it is a motif instance
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
        algorithmType = 'MatrixProfile';
        [currentMatrixProfileEntropy,  precisionMatrixMatrixProfile, recallMatrixMatrixProfile, FScoreMatrixMatrixProfile] = motifEvaluation(GroundTruthFile, MatrixProfileFile, algorithmType, windowSize, threshold);
        algorithmType = 'RMT';
        [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT] = motifEvaluation(GroundTruthFile, RMTMotifFile, algorithmType, windowSize, threshold);
%         algorithmType = 'RME';
%         [currentRMEMotifEntropy, precisionMatrixRME, recallMatrixRME, FScoreMatrixRME] = motifEvaluation(GroundTruthFile, RMEMotifFile, algorithmType, windowSize, threshold);
        
    end
    
    MatrixProfileEntropy = [MatrixProfileEntropy ; currentMatrixProfileEntropy];
    RMTMotifEntropy = [RMTMotifEntropy ; currentRMTMotifEntropy];
%     RMEMotifEntropy = [RMEMotifEntropy; currentRMEMotifEntropy];
    
    % save current Matrix to files
    savePathMatrixProfilePrecision = [savePathMatrixProfile, '/MatrixProfilePrecision_', num2str(testCaseIndex(ii)), '.csv'];
    savePathMatrixProfileRecall = [savePathMatrixProfile, '/MatrixProfileRecall_', num2str(testCaseIndex(ii)), '.csv'];
    savePathMatrixProfileFScore = [savePathMatrixProfile, '/MatrixProfileFScore_', num2str(testCaseIndex(ii)), '.csv'];
    csvwrite(savePathMatrixProfilePrecision, precisionMatrixMatrixProfile);
    csvwrite(savePathMatrixProfileRecall, recallMatrixMatrixProfile);
    csvwrite(savePathMatrixProfileFScore, FScoreMatrixMatrixProfile)

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
MatrixProfile_Entropy_Ouput_Path = [savePathMatrixProfile, '/MatrixProfileEntropy.csv'];

% csvwrite(RME_Entropy_Ouput_Path, RMEMotifEntropy);
csvwrite(RMT_Entropy_Ouput_Path, RMTMotifEntropy);
csvwrite(MatrixProfile_Entropy_Ouput_Path, MatrixProfileEntropy);

fprintf('All done .\n');