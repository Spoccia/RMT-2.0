clear;
clc;

% iterate file to for upload
testCaseIndex = 1 : 9;
% GroundTruthFilePath = ['./DataFolder/synt_diffTSize/1motif/Groundtruth/IndexEmbeddedFeatures/FeaturePosition_Mocap_test'];
% MatrixProfileFilePath = ['./DataFolder/synt_diffTSize/1motif/Mstamp/Mocap_MStamp_test'];
% RMTMotifFilePath = ['./DataFolder/synt_diffTSize/1motif/RMT/AP_Mocap_DepO_2_DepT_2_test'];

GroundTruthFilePath = ['/Users/sliu104/Desktop/MoCapTestData/example_tests/examles/Groundtruth/IndexEmbeddedFeatures/FeaturePosition_Mocap_test'];
MatrixProfileFilePath = ['./DataFolder/synt_diffTSize/1motif/Mstamp/Mocap_MStamp_test'];
RMTMotifFilePath = ['/Users/sliu104/Desktop/MoCapTestData/example_tests/examles/RMT/AP_DepO_2_DepT_2_Mocap_test'];

MatrixProfileEntropy = [];
RMTMotifEntropy = [];

% algorithm type: RMT, RME or MatrixProfile
algorithmType = 'RMT';
% savePathMatrixProfile = ['./'];
savePathRMT = ['./'];

for ii = 1 : size(testCaseIndex, 2)
    GroundTruthFile = [GroundTruthFilePath, num2str(testCaseIndex(ii)), '.csv'];
    MatrixProfileFile = [MatrixProfileFilePath, num2str(testCaseIndex(ii)), '.csv'];
    RMTMotifFile = [RMTMotifFilePath, num2str(testCaseIndex(ii)), '.csv'];
    
    algorithmType = 'MatrixProfile';
    windowSize = 58;
    % [currentMatrixProfileEntropy,  precisionMatrixMatrixProfile, recallMatrixMatrixProfile, FScoreMatrixMatrixProfile] = motifEvaluation(GroundTruthFile, MatrixProfileFile, algorithmType, windowSize);
    
    algorithmType = 'RMT';
    % [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT] = motifEvaluationWeighted(GroundTruthFile, RMTMotifFile, algorithmType, windowSize);
    
    % threshold = 0.5; % if it captures half of what we injected, then it is a motif instance
    threshold = eps; % if it is non-zero
    [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT] = motifEvaluation(GroundTruthFile, RMTMotifFile, algorithmType, windowSize, threshold);
    
    % MatrixProfileEntropy = [MatrixProfileEntropy ; currentMatrixProfileEntropy];
    RMTMotifEntropy = [RMTMotifEntropy ; currentRMTMotifEntropy];
    
    % save current Matrix to files

    % savePathMatrixProfilePrecision = [savePathMatrixProfile, '/MatrixProfilePrecision_', num2str(ii), '.csv'];
    % savePathMatrixProfileRecall = [savePathMatrixProfile, '/MatrixProfileRecall_', num2str(ii), '.csv'];
    % savePathMatrixProfileFScore = [savePathMatrixProfile, '/MatrixProfileFScore_', num2str(ii), '.csv'];
    % csvwrite(savePathMatrixProfilePrecision, precisionMatrixMatrixProfile);
    % csvwrite(savePathMatrixProfileRecall, recallMatrixMatrixProfile);
    % csvwrite(savePathMatrixProfileFScore, FScoreMatrixMatrixProfile)

    savePathRMTPrecision = [savePathRMT, '/RMTPrecision_', num2str(ii), '.csv'];
    savePathRMTRecall = [savePathRMT, '/RMTRecall_', num2str(ii), '.csv'];
    savePathRMTFScore = [savePathRMT, '/RMTFScore_', num2str(ii), '.csv'];
    csvwrite(savePathRMTPrecision, precisionMatrixRMT);
    csvwrite(savePathRMTRecall, recallMatrixRMT);
    csvwrite(savePathRMTFScore, FScoreMatrixRMT);
end

% csvwrite('./MatrixProfileEntropy.csv', MatrixProfileEntropy);
csvwrite('./RMTMotifEntropy.csv', RMTMotifEntropy);
% potentially save entropy values to files
fprintf('All done .\n');