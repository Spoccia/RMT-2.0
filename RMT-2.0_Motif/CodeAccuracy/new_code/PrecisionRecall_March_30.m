clear;
clc;

weighted = 0;
% iterate file to for upload
testCaseIndex = 1 : 10;
TS_index = [24, 35, 85, 127];

% motif1 -> stragety 1 - 6
% motif2 -> stragety 1 - 6

strategy = [1 : 6];
num_of_motif = [1];
amp_scale = [0, 0.1, 0.5, 0.75, 1]; % 0.5 0.75 0 1

% GroundTruthFilePath = ['/Users/sliu104/Desktop/Test_Case_Jan_30/GroundTruth_All/FeaturePosition_Motif_'];
GroundTruthFilePath = ['/Users/sliu104/Desktop/Results_Motif/Synthetic_Dataset/data/IndexEmbeddedFeatures/FeaturePosition_Motif'];

% MatrixProfileFilePath = ['/Users/sliu104/Desktop/Test_Case_Jan_30/MatrixProfile_Accuracy_size100_Motif_1/100_Motif_'];
RMTMotifFilePath = ['/Users/sliu104/Desktop/Results_Motif/Synthetic_Dataset/Features_RMT/Accuracy_Motif1/Strategy_'];

% RMTMotifFilePath = ['/Users/sliu104/Desktop/Test_Case_Jan_30/RMT_Accuracy_size100_Motif_1/AP_DepO_2_DepT_2_100_Motif_'];
% RMEMotifFilePath = ['/Users/sliu104/Desktop/Test_Case_Jan_30/RMT_Accuracy_size100_Motif_1/AP_DepO_2_DepT_2_100_Motif_'];

savePathRMT = ['/Users/sliu104/Desktop/Results_Motif_Save/Motif'];
% savePathMatrixProfile = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/MatrixProfile_Accuracy_Motif1_5_instances'];
% savePathMatrixProfile = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/MatrixProfile_Accuracy_size100_Motif_1/'];

MatrixProfileEntropy = [];
RMTMotifEntropy = [];

for ss = 1 : size(strategy, 2)
    for i = 1 : size(num_of_motif, 2)
        for m = 1 : size(amp_scale, 2)
            
            index_count = 1;
            for j = 1 : size(TS_index, 2)
                for k = 1 : size(testCaseIndex, 2)
                    fprintf('Strategy: %d, Num of motif: %d, TS index: %d, instance: %d, amp scale: %f .\n', strategy(ss), num_of_motif(i), TS_index(j), testCaseIndex(k), amp_scale(m));
                    GroundTruthFile = [GroundTruthFilePath, num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '_', num2str(amp_scale(m)), '.csv'];
                    
                    % MatrixProfileFile = [MatrixProfileFilePath, num2str(num_of_motif_injected), '_', num2str(num_of_motif), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '.csv'];
                    % RMTMotifFile = [RMTMotifFilePath, num2str(num_of_motif_injected), '_', num2str(num_of_motif), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '.csv'];
                    RMTMotifFile = [RMTMotifFilePath, num2str(strategy(ss)), '/AP_DepO_2_DepT_2_Motif', num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '_', num2str(amp_scale(m)), '.csv'];
                    
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
                        % algorithmType = 'MatrixProfile';
                        % [currentMatrixProfileEntropy,  precisionMatrixMatrixProfile, recallMatrixMatrixProfile, FScoreMatrixMatrixProfile, total_index] = motifEvaluation(GroundTruthFile, MatrixProfileFile, algorithmType, windowSize, threshold);
                        
                        algorithmType = 'RMT';
                        [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT, total_index] = motifEvaluation(GroundTruthFile, RMTMotifFile, algorithmType, windowSize, threshold);
                        
                    end
                    
                    % MatrixProfileEntropy = [MatrixProfileEntropy ; currentMatrixProfileEntropy];
                    RMTMotifEntropy = [RMTMotifEntropy ; currentRMTMotifEntropy];
                    
                    % MatrixProfileEntropy = [MatrixProfileEntropy ; currentMatrixProfileEntropy];
                    RMTMotifEntropy = [RMTMotifEntropy ; currentRMTMotifEntropy];
                    
                    % save current Matrix to files
                    %         savePathMatrixProfilePrecision = [savePathMatrixProfile, '/MatrixProfilePrecision_', num2str(index_count), '.csv'];
                    %         savePathMatrixProfileRecall = [savePathMatrixProfile, '/MatrixProfileRecall_', num2str(index_count), '.csv'];
                    %         savePathMatrixProfileFScore = [savePathMatrixProfile, '/MatrixProfileFScore_', num2str(index_count), '.csv'];
                    %         savePathRemainIndex = [savePathMatrixProfile, '/RemainIndex', num2str(index_count), '.csv'];
                    %         csvwrite(savePathMatrixProfilePrecision, precisionMatrixMatrixProfile);
                    %         csvwrite(savePathMatrixProfileRecall, recallMatrixMatrixProfile);
                    %         csvwrite(savePathMatrixProfileFScore, FScoreMatrixMatrixProfile)
                    %         csvwrite(savePathRemainIndex, total_index);
                    
                    
                    savePathRMTPrecision = [savePathRMT, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '/RMTPrecision_', num2str(index_count), '.csv'];
                    savePathRMTRecall = [savePathRMT, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '/RMTRecall_', num2str(index_count), '.csv'];
                    savePathRMTFScore = [savePathRMT, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '/RMTFScore_', num2str(index_count), '.csv'];
                    savePathRemainIndex = [savePathRMT, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '/RemainIndex', num2str(index_count), '.csv'];
                    csvwrite(savePathRMTPrecision, precisionMatrixRMT);
                    csvwrite(savePathRMTRecall, recallMatrixRMT);
                    csvwrite(savePathRMTFScore, FScoreMatrixRMT);
                    csvwrite(savePathRemainIndex, total_index);
                    
                    index_count = index_count + 1;
                end
            end
            % entropy: precision entropy, recall entropy, FScore entropy
            RMT_Entropy_Ouput_Path = [savePathRMT, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '/RMTMotifEntropy.csv'];
            % MatrixProfile_Entropy_Ouput_Path = [savePathMatrixProfile, '/MatrixProfileEntropy.csv'];
            
            % csvwrite(RME_Entropy_Ouput_Path, RMEMotifEntropy);
            csvwrite(RMT_Entropy_Ouput_Path, RMTMotifEntropy);
        end
    end
    
end

% % entropy: precision entropy, recall entropy, FScore entropy
% RMT_Entropy_Ouput_Path = [savePathRMT, '/RMTMotifEntropy.csv'];
% % MatrixProfile_Entropy_Ouput_Path = [savePathMatrixProfile, '/MatrixProfileEntropy.csv'];
% % RME_Entropy_Ouput_Path = [savePathRME, '/RMEMotifEntropy.csv'];
% 
% % csvwrite(RME_Entropy_Ouput_Path, RMEMotifEntropy);
% csvwrite(RMT_Entropy_Ouput_Path, RMTMotifEntropy);
% % csvwrite(MatrixProfile_Entropy_Ouput_Path, MatrixProfileEntropy);

fprintf('All done .\n');

% for j = 1 : size(TS_index, 2)
%     for i = 1 : size(testCaseIndex, 2)
%         for k = 1 : size(amp_scale, 2)
%             
%         end
%         fprintf('Test case: %d, TS index: %d .\n', testCaseIndex(i), TS_index(j));
%         
%         % num_of_motif_injected num_of_motif
%         % FeaturePosition_Motif3_127_instance_7
%         % GroundTruthFile = [GroundTruthFilePath, num2str(num_of_motif_injected), '_', num2str(num_of_motif), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '.csv'];
%         % GroundTruthFile = [GroundTruthFilePath, num2str(num_of_motif), '.csv'];
%         GroundTruthFile = [GroundTruthFilePath, num2str(num_of_motif_injected), '_', num2str(num_of_motif), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '.csv'];
%         
%         % MatrixProfileFile = [MatrixProfileFilePath, num2str(num_of_motif_injected), '_', num2str(num_of_motif), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '.csv'];
%         % RMTMotifFile = [RMTMotifFilePath, num2str(num_of_motif_injected), '_', num2str(num_of_motif), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '.csv'];
%         RMTMotifFile = [RMTMotifFilePath, num2str(num_of_motif_injected), '_', num2str(num_of_motif), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '.csv'];
%         % RMTMotifFile = [RMTMotifFilePath, num2str(num_of_motif), '.csv'];
%         % MatrixProfileFile = [MatrixProfileFilePath, num2str(num_of_motif), '.csv'];
%         
%         % threshold = 0.5; % if it captures half of what we injected, then it is a motif instance
%         threshold = eps; % if it is non-zero
%         
%         windowSize = 58;
%         if(weighted == 1)
%             % algorithmType = 'MatrixProfile';
%             % [currentMatrixProfileEntropy, precisionMatrixMatrixProfile, recallMatrixMatrixProfile, FScoreMatrixMatrixProfile] = motifEvaluationWeighted(GroundTruthFile, MatrixProfileFile, algorithmType, windowSize);
%             % algorithmType = 'RMT';
%             % [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT] = motifEvaluationWeighted(GroundTruthFile, RMTMotifFile, algorithmType, windowSize);
%             
%             % algorithmType = 'RME';
%             % [currentRMEMotifEntropy, precisionMatrixRME, recallMatrixRME, FScoreMatrixRME] = motifEvaluationWeighted(GroundTruthFile, RMEMotifFile, algorithmType, windowSize);
%         else
%             % algorithmType = 'MatrixProfile';
%             % [currentMatrixProfileEntropy,  precisionMatrixMatrixProfile, recallMatrixMatrixProfile, FScoreMatrixMatrixProfile, total_index] = motifEvaluation(GroundTruthFile, MatrixProfileFile, algorithmType, windowSize, threshold);
%             
%             algorithmType = 'RMT';
%             [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT, total_index] = motifEvaluation(GroundTruthFile, RMTMotifFile, algorithmType, windowSize, threshold);
%             
%         end
%         
%         % MatrixProfileEntropy = [MatrixProfileEntropy ; currentMatrixProfileEntropy];
%         RMTMotifEntropy = [RMTMotifEntropy ; currentRMTMotifEntropy];
%         
%         % save current Matrix to files
%         %         savePathMatrixProfilePrecision = [savePathMatrixProfile, '/MatrixProfilePrecision_', num2str(index_count), '.csv'];
%         %         savePathMatrixProfileRecall = [savePathMatrixProfile, '/MatrixProfileRecall_', num2str(index_count), '.csv'];
%         %         savePathMatrixProfileFScore = [savePathMatrixProfile, '/MatrixProfileFScore_', num2str(index_count), '.csv'];
%         %         savePathRemainIndex = [savePathMatrixProfile, '/RemainIndex', num2str(index_count), '.csv'];
%         %         csvwrite(savePathMatrixProfilePrecision, precisionMatrixMatrixProfile);
%         %         csvwrite(savePathMatrixProfileRecall, recallMatrixMatrixProfile);
%         %         csvwrite(savePathMatrixProfileFScore, FScoreMatrixMatrixProfile)
%         %         csvwrite(savePathRemainIndex, total_index);
%         
%         
%         savePathRMTPrecision = [savePathRMT, '/RMTPrecision_', num2str(index_count), '.csv'];
%         savePathRMTRecall = [savePathRMT, '/RMTRecall_', num2str(index_count), '.csv'];
%         savePathRMTFScore = [savePathRMT, '/RMTFScore_', num2str(index_count), '.csv'];
%         savePathRemainIndex = [savePathRMT, '/RemainIndex', num2str(index_count), '.csv'];
%         csvwrite(savePathRMTPrecision, precisionMatrixRMT);
%         csvwrite(savePathRMTRecall, recallMatrixRMT);
%         csvwrite(savePathRMTFScore, FScoreMatrixRMT);
%         csvwrite(savePathRemainIndex, total_index);
%         
%         index_count = index_count + 1;
%     end
% end
% 
% % entropy: precision entropy, recall entropy, FScore entropy
% RMT_Entropy_Ouput_Path = [savePathRMT, '/RMTMotifEntropy.csv'];
% % MatrixProfile_Entropy_Ouput_Path = [savePathMatrixProfile, '/MatrixProfileEntropy.csv'];
% % RME_Entropy_Ouput_Path = [savePathRME, '/RMEMotifEntropy.csv'];
% 
% % csvwrite(RME_Entropy_Ouput_Path, RMEMotifEntropy);
% csvwrite(RMT_Entropy_Ouput_Path, RMTMotifEntropy);
% % csvwrite(MatrixProfile_Entropy_Ouput_Path, MatrixProfileEntropy);
% 
% fprintf('All done .\n');