clear;
clc;

weighted = 0;
% iterate file to for upload
testCaseIndex = 1 : 10;
% TS_index = [24, 35, 85, 127];

TS_index = [64, 70, 80, 147]; % BirdSong dataset

% motif1 -> stragety 1 - 6
% motif2 -> stragety 1 - 6

% strategy = [1 : 6];
strategy = 3;
num_of_motif = [1 : 3];
% amp_scale = [0, 0.1, 0.5, 0.75, 1]; % 0.5 0.75 0 1
amp_scale = 0;

% GroundTruthFilePath = ['/Users/sliu104/Desktop/Test_Case_Jan_30/GroundTruth_All/FeaturePosition_Motif_'];
GroundTruthFilePath = ['/Users/sicongliu/Desktop/MyMotif/ComputeAccuracy/GroundTruth/IndexEmbeddedFeatures/FeaturePosition_Motif'];

% MatrixProfileFilePath = ['/Users/sliu104/Desktop/Test_Case_Jan_30/MatrixProfile_Accuracy_size100_Motif_1/100_Motif_'];
MatrixProfileFilePath = ['/Users/sicongliu/Desktop/MyMotif/ComputeAccuracy/AccuracyMstamp'];

% RMTMotifFilePath = ['/Users/sicong/Desktop/Results_Motif/Synthetic_Dataset/Features_RMT/Accuracy_Motif'];
RMTMotifFilePath = ['/Users/sicongliu/Desktop/MyMotif/ComputeAccuracy/AccuracyRMT'];

% RMTMotifFilePath = ['/Users/sliu104/Desktop/Test_Case_Jan_30/RMT_Accuracy_size100_Motif_1/AP_DepO_2_DepT_2_100_Motif_'];
% RMEMotifFilePath = ['/Users/sliu104/Desktop/Test_Case_Jan_30/RMT_Accuracy_size100_Motif_1/AP_DepO_2_DepT_2_100_Motif_'];

savePathRMT = ['/Users/sicongliu/Desktop/Results_Motif_Save_NewlyAdded/RMT/Motif'];
savePathMatrixProfile = ['/Users/sicongliu/Desktop/Results_Motif_Save_NewlyAdded/MatrixProfile/Motif'];

% savePathMatrixProfile = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/MatrixProfile_Accuracy_Motif1_5_instances'];
% savePathMatrixProfile = ['/Users/sliu104/Desktop/Test_Case_Jan_30_Results/MatrixProfile_Accuracy_size100_Motif_1/'];

MatrixProfileEntropy = [];
RMTMotifEntropy = [];

timeOverlapThresholds = [0.1, 0.25, 0.5, 0.75, 1];
for tt = 1 : size(timeOverlapThresholds, 2)
    for ss = 1 : size(strategy, 2)
        for i = 1 : size(num_of_motif, 2)
            for m = 1 : size(amp_scale, 2)
                
                index_count = 1;
                for j = 1 : size(TS_index, 2)
                    for k = 1 : size(testCaseIndex, 2)
                        
                        fprintf('Strategy: %d, Num of motif: %d, TS index: %d, instance: %d, amp scale: %f .\n', strategy(ss), num_of_motif(i), TS_index(j), testCaseIndex(k), amp_scale(m));
                        GroundTruthFile = [GroundTruthFilePath, num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '_', num2str(amp_scale(m)), '.csv'];
                        
                        % fprintf('Strategy: %d, Num of motif: %d, TS index: %d, instance: %d.\n', strategy(ss), num_of_motif(i), TS_index(j), testCaseIndex(k));
                        % GroundTruthFile = [GroundTruthFilePath, num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '.csv'];
                        
                        MatrixProfileFile = [MatrixProfileFilePath, '/Motif', num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '_', num2str(amp_scale(m)), '.csv'];
                        % MatrixProfileFile = [MatrixProfileFilePath, num2str(num_of_motif_injected), '_', num2str(num_of_motif), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '.csv'];
                        % RMTMotifFile = [RMTMotifFilePath, num2str(num_of_motif_injected), '_', num2str(num_of_motif), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '.csv'];
                        
                        RMTMotifFile = [RMTMotifFilePath, '/Strategy_', num2str(strategy(ss)), '/AP_DepO_2_DepT_2_Motif', num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '_', num2str(amp_scale(m)), '.csv'];
                        
                        % RMTMotifFile = [RMTMotifFilePath, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/AP_DepO_2_DepT_2_Motif', num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '.csv'];

                        % RMTMotifFile = [RMTMotifFilePath, num2str(strategy(ss)), '/AP_DepO_2_DepT_2_Motif', num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '_', num2str(amp_scale(m)), '.csv'];
                        
                        % threshold = 0.5; % if it captures half of what we injected, then it is a motif instance
                        threshold = eps; % if it is non-zero
                        
                        timeOverlapThreshold = timeOverlapThresholds(tt);
                        % windowSize = 58;
                        windowSize = 32; % BirdSong configuration
                        if(weighted == 1)
                            % algorithmType = 'MatrixProfile';
                            % [currentMatrixProfileEntropy, precisionMatrixMatrixProfile, recallMatrixMatrixProfile, FScoreMatrixMatrixProfile] = motifEvaluationWeighted(GroundTruthFile, MatrixProfileFile, algorithmType, windowSize);
                            % algorithmType = 'RMT';
                            % [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT] = motifEvaluationWeighted(GroundTruthFile, RMTMotifFile, algorithmType, windowSize);
                            
                            % algorithmType = 'RME';
                            % [currentRMEMotifEntropy, precisionMatrixRME, recallMatrixRME, FScoreMatrixRME] = motifEvaluationWeighted(GroundTruthFile, RMEMotifFile, algorithmType, windowSize);
                        else
                            algorithmType = 'MatrixProfile';
                            [currentMatrixProfileEntropy,  precisionMatrixMatrixProfile, recallMatrixMatrixProfile, FScoreMatrixMatrixProfile, total_index_MStamp] = motifEvaluation(GroundTruthFile, MatrixProfileFile, algorithmType, windowSize, threshold, timeOverlapThreshold);
                            
                            algorithmType = 'RMT';
                            [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT, total_index_RMT] = motifEvaluation(GroundTruthFile, RMTMotifFile, algorithmType, windowSize, threshold, timeOverlapThreshold);
                            
                        end
                        
                        MatrixProfileEntropy = [MatrixProfileEntropy ; currentMatrixProfileEntropy];
                        RMTMotifEntropy = [RMTMotifEntropy ; currentRMTMotifEntropy];
                        
                        MatrixProfileEntropy = [MatrixProfileEntropy ; currentMatrixProfileEntropy];
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
                        RMTsharedFolder = [savePathRMT, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold)];
                        MStampsharedFolder = [savePathMatrixProfile, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold)];
                        
                        if(exist(RMTsharedFolder,'dir')==0)
                            mkdir(RMTsharedFolder);
                        end
                        
                        if(exist(MStampsharedFolder,'dir')==0)
                            mkdir(MStampsharedFolder);
                        end
                        
%                         savePathRMTPrecisonFolder = sharedFolder;
%                         savePathRMTRecallFolder = sharedFolder;
%                         savePathRMTFScoreFolder = sharedFolder;
%                         savePathRemainIndexFolder = sharedFolder;
                        
                        savePathRMTPrecision = [RMTsharedFolder, '/RMTPrecision_', num2str(index_count), '.csv'];
                        savePathRMTRecall = [RMTsharedFolder, '/RMTRecall_', num2str(index_count), '.csv'];
                        savePathRMTFScore = [RMTsharedFolder, '/RMTFScore_', num2str(index_count), '.csv'];
                        savePathRemainIndex = [RMTsharedFolder, '/RemainIndex', num2str(index_count), '.csv'];
                        csvwrite(savePathRMTPrecision, precisionMatrixRMT);
                        csvwrite(savePathRMTRecall, recallMatrixRMT);
                        csvwrite(savePathRMTFScore, FScoreMatrixRMT);
                        csvwrite(savePathRemainIndex, total_index_RMT);
                        
                        savePathMStampPrecision = [MStampsharedFolder, '/MStampPrecision_', num2str(index_count), '.csv'];
                        savePathMStampRecall = [MStampsharedFolder, '/MStampRecall_', num2str(index_count), '.csv'];
                        savePathMStampFScore = [MStampsharedFolder, '/MStampFScore_', num2str(index_count), '.csv'];
                        savePathRemainIndex = [MStampsharedFolder, '/RemainIndex', num2str(index_count), '.csv'];
                        csvwrite(savePathMStampPrecision, precisionMatrixMatrixProfile);
                        csvwrite(savePathMStampRecall, recallMatrixMatrixProfile);
                        csvwrite(savePathMStampFScore, FScoreMatrixMatrixProfile);
                        csvwrite(savePathRemainIndex, total_index_MStamp);
                        
                        index_count = index_count + 1;
                    end
                    % entropy: precision entropy, recall entropy, FScore entropy
                    RMT_Entropy_Ouput_Path = [savePathRMT, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold), '/RMTMotifEntropy.csv'];
                    % RMT_Entropy_Ouput_Path = [savePathRMT, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold), '/RMTMotifEntropy.csv'];
                    MStamp_Entropy_Ouput_Path = [savePathMatrixProfile, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold), '/MStampMotifEntropy.csv'];
                    
                    csvwrite(MStamp_Entropy_Ouput_Path, MatrixProfileEntropy);
                    csvwrite(RMT_Entropy_Ouput_Path, RMTMotifEntropy);
                end
                
            end
        end
    end
    
end

fprintf('All done .\n');
