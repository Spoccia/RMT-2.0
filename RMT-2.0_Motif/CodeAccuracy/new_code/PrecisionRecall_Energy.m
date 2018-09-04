clear;
clc;

weighted = 0;

testCaseIndex = 1 : 10;

TS_index = [2, 10, 11, 12, 16, 17, 20, 21, 23, 24, 26, 28, 33, 34, 36, 39, 42, 43, 44, 46, 47, 53, 61, 66, 70, 73, 79, 82, 87, 88]; % Energy Dataset

% strategy = [1 : 9];
strategy = [9];

% num_of_motif = [1:3];
num_of_motif = [3];

amp_scale = [0, 0.1, 0.25, 0.5, 0.75, 1]; % 0.5 0.75 0 1

GroundTruthFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_3_Energy/data/IndexEmbeddedFeatures/FeaturePosition_Motif'];

MatrixProfileFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_3_Energy/MStampEnergy/Accuracy_Motif'];

RMTMotifFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_3_Energy/Accuracy_Motif'];

savePathRMT = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_3_Energy/Result_RMT_Motif'];
savePathMatrixProfile = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_3_Energy/Result_MStamp_Motif'];

MatrixProfileEntropy = [];
RMTMotifEntropy = [];

timeOverlapThresholds = [0.1, 0.25, 0.5, 0.75, 1];
for i = 1 : size(num_of_motif, 2)
    for ss = 1 : size(strategy, 2)
        for m = 1 : size(amp_scale, 2)
            for tt = 1 : size(timeOverlapThresholds, 2)
                index_count = 1; % keep track of same motif but different number of instances
                for j = 1 : size(TS_index, 2)
                    for k = 1 : size(testCaseIndex, 2)
                        
                        fprintf('Num of motif: %d, Strategy: %d, TS index: %d, instance: %d, amp scale: %f, timeOverlapThreshold: %f .\n', num_of_motif(i), strategy(ss), TS_index(j), testCaseIndex(k), amp_scale(m), timeOverlapThresholds(tt));
                        GroundTruthFile = [GroundTruthFilePath, num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '_', num2str(amp_scale(m)), '.csv'];
                        
                        % need update
                        MatrixProfileFile = [MatrixProfileFilePath, num2str(num_of_motif(i)), '/Motif', num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '_', num2str(amp_scale(m)), '.csv'];
                        
                        RMTMotifFile = [RMTMotifFilePath, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/AP_DepO_2_DepT_2_Motif', num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '_', num2str(amp_scale(m)), '.csv'];
                        
                        threshold = eps; % if it is non-zero
                        timeOverlapThreshold = timeOverlapThresholds(tt);
                        % windowSize = 32; % BirdSong configuration
                        windowSize = 58; % Energy dataset configuration
                        if(weighted == 1)
                            % algorithmType = 'MatrixProfile';
                            % [currentMatrixProfileEntropy, precisionMatrixMatrixProfile, recallMatrixMatrixProfile, FScoreMatrixMatrixProfile] = motifEvaluationWeighted(GroundTruthFile, MatrixProfileFile, algorithmType, windowSize);
                            % algorithmType = 'RMT';
                            % [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT] = motifEvaluationWeighted(GroundTruthFile, RMTMotifFile, algorithmType, windowSize);
                            
                            % algorithmType = 'RME';
                            % [currentRMEMotifEntropy, precisionMatrixRME, recallMatrixRME, FScoreMatrixRME] = motifEvaluationWeighted(GroundTruthFile, RMEMotifFile, algorithmType, windowSize);
                        else
                            algorithmType = 'MatrixProfile';
                            [currentMatrixProfileEntropy,  precisionMatrixMatrixProfile, recallMatrixMatrixProfile, FScoreMatrixMatrixProfile, total_index_MStamp] = motifEvaluation_Energy(GroundTruthFile, MatrixProfileFile, algorithmType, windowSize, threshold, timeOverlapThreshold);
                            
                            algorithmType = 'RMT';
                            [currentRMTMotifEntropy, precisionMatrixRMT, recallMatrixRMT, FScoreMatrixRMT, total_index_RMT] = motifEvaluation_Energy(GroundTruthFile, RMTMotifFile, algorithmType, windowSize, threshold, timeOverlapThreshold);
                            
                        end
                        
                        MatrixProfileEntropy = [MatrixProfileEntropy ; currentMatrixProfileEntropy];
                        RMTMotifEntropy = [RMTMotifEntropy ; currentRMTMotifEntropy];
                        
                        % MatrixProfileEntropy = [MatrixProfileEntropy ; currentMatrixProfileEntropy];
                        % RMTMotifEntropy = [RMTMotifEntropy ; currentRMTMotifEntropy];
                        
                        
                        RMTsharedFolder = [savePathRMT, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold)];
                        MStampsharedFolder = [savePathMatrixProfile, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold)];
                        
                        if(exist(RMTsharedFolder,'dir')==0)
                            mkdir(RMTsharedFolder);
                        end
                        
                        if(exist(MStampsharedFolder,'dir')==0)
                            mkdir(MStampsharedFolder);
                        end
                        
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
                    
                    save_RMT_Entropy_Folder = [savePathRMT, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold)];
                    save_MStamp_Entropy_Folder= [savePathMatrixProfile, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold)];
                    
                    if(exist(save_RMT_Entropy_Folder,'dir')==0)
                        mkdir(save_RMT_Entropy_Folder);
                    end
                    
                    if(exist(save_MStamp_Entropy_Folder,'dir')==0)
                        mkdir(save_MStamp_Entropy_Folder);
                    end
                    
                    RMT_Entropy_Ouput_Path = [save_RMT_Entropy_Folder, '/RMTMotifEntropy.csv'];
                    MStamp_Entropy_Ouput_Path = [save_MStamp_Entropy_Folder, '/MStampMotifEntropy.csv'];
                    
                    csvwrite(MStamp_Entropy_Ouput_Path, MatrixProfileEntropy);
                    csvwrite(RMT_Entropy_Ouput_Path, RMTMotifEntropy);
                end
                
            end
        end
    end
    
end

fprintf('All done .\n');
