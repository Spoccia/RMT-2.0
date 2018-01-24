clear;
clc;

% iterate file to for upload
testCaseIndex =  10 : 33;

% if stat is computed in a weighted manner
weighted = 0;
% GroundTruthFilePath = ['./DataFolder/synt_diffTSize/1motif/Groundtruth/IndexEmbeddedFeatures/FeaturePosition_Mocap_test'];
% MatrixProfileFilePath = ['./DataFolder/synt_diffTSize/1motif/Mstamp/Mocap_MStamp_test'];
% RMTMotifFilePath = ['./DataFolder/synt_diffTSize/1motif/RMT/AP_Mocap_DepO_2_DepT_2_test'];

GroundTruthFilePath = ['/Users/sliu104/Desktop/motif/Groundtruth/IndexEmbeddedFeatures/FeaturePosition_Mocap_test'];
MatrixProfileFilePath = ['/Users/sliu104/Desktop/motif/Mstamp/candanDistance/Mocap_test'];
RMTMotifFilePath = ['/Users/sliu104/Desktop/motif/RMT/normalAVGSum/AP_DepO_2_DepT_2_Mocap_test'];

savePathRMT = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_Folder'];
savePathMatrixProfile = ['/Users/sliu104/Desktop/MoCapTestData_Motif/Output_Folder'];


MatrixProfileEntropy = [];
RMTMotifEntropy = [];

% algorithm type: RMT, RME or MatrixProfile
algorithmType = 'RMT';

for ii = 14 : size(testCaseIndex, 2)
    fprintf('Test case: %d .\n', testCaseIndex(ii));
    GroundTruthFile = [GroundTruthFilePath, num2str(testCaseIndex(ii)), '.csv'];
    MatrixProfileFile = [MatrixProfileFilePath, num2str(testCaseIndex(ii)), '.csv'];
    RMTMotifFile = [RMTMotifFilePath, num2str(testCaseIndex(ii)), '.csv'];
    
    % threshold = 0.5; % if it captures half of what we injected, then it is a motif instance
    threshold = eps; % if it is non-zero
    
    
    windowSize = 58;
    if(weighted == 1)
        algorithmType = 'MatrixProfile';
        [currentMatrixProfileEntropy, precisionMatrixMatrixProfile, recallMatrixMatrixProfile, FScoreMatrixMatrixProfile] = motifEvaluationWeighted(GroundTruthFile, MatrixProfileFile, algorithmType, windowSize);
        algorithmType = 'RMT';
        [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT] = motifEvaluationWeighted(GroundTruthFile, RMTMotifFile, algorithmType, windowSize);
    else
        algorithmType = 'MatrixProfile';
        [currentMatrixProfileEntropy,  precisionMatrixMatrixProfile, recallMatrixMatrixProfile, FScoreMatrixMatrixProfile] = motifEvaluation(GroundTruthFile, MatrixProfileFile, algorithmType, windowSize, threshold);
        algorithmType = 'RMT';
        [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT] = motifEvaluation(GroundTruthFile, RMTMotifFile, algorithmType, windowSize, threshold);
    end
    
    MatrixProfileEntropy = [MatrixProfileEntropy ; currentMatrixProfileEntropy];
    RMTMotifEntropy = [RMTMotifEntropy ; currentRMTMotifEntropy];
    
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
end


% entropy: precision entropy, recall entropy, FScore entropy

RMT_Entropy_Ouput_Path = [savePathRMT, '/RMTMotifEntropy.csv'];
MatrixProfile_Entropy_Ouput_Path = [savePathMatrixProfile, '/MatrixProfileEntropy.csv'];
csvwrite(MatrixProfile_Entropy_Ouput_Path, MatrixProfileEntropy);
csvwrite(RMT_Entropy_Ouput_Path, RMTMotifEntropy);

fprintf('All done .\n');