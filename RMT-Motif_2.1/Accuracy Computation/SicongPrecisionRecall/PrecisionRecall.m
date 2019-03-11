clear;
clc;
DS_List ={'Energy','Mocap','BirdSong'};
for DSIdx =3:3
    Ds_Name= DS_List{DSIdx};%'Energy';%'Mocap';%'BirdSong';%
   % Path=['F:\Motif_Results\Motif1 CoherentShift\',Ds_Name,'\SameLength'];
%          Path='G:\syntethic motifs  good results\Mocap\Coherent Shift Variate 1M Mocap\instancessamesize\';
        %['F:\syntethic motifs  good results\',Ds_Name,'\numInstances_5_15'];%'\10_Motifs_MM_rebuttal\'];%'\ICMR RMT-Mstamp-RME\'];%'\samesize10inst\'];%'\random shift variates 1M ',Ds_Name ,'\instancessamesize\']%'\',Ds_Name,' M 1 2 3\'];%
    %10_Motifs_MM_rebuttal'];%
    % Path=['F:\syntethic motifs  good results\',Ds_Name,'\random shift variates 1M ',Ds_Name,'\instancesmultisize'];%'\instancessamesize'];%
      Path=['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\',Ds_Name,' Motifs 1 2 3 same variate multisize\'];%',Ds_Name,'\Coherent Shift Variate 1M ',Ds_Name,'\instancessamesize\'];%
      %      Path =['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\',Ds_Name,' Motifs 1 2 3 same variate multisize\'];%['F:\Motif_Results\Motif 1 2 3 multisize\',Ds_Name,'\']
     %'D:\Motif_Results\Datasets\SynteticDataset\Energy\Coherent Shift Variate 1M Energy\instanceMultisize\';
    %Path = ['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\RandomVariate\instancesmultisize'];
    
    
    
    windowSize = 58; % Energy dataset configuration
    if strcmp(Ds_Name,'BirdSong')==1
        windowSize = 32; % BirdSong configuration
    end
    % iterate file to for upload
    testCaseIndex = 1 : 10;
    load([Path,'\data\FeaturesToInject\allTSid.mat']);
    TS_index = sort(AllTS(1:30));
    for overlapid=1:2
        overlapping='';%
        if overlapid==2
            overlapping='Overlapping';%
        end
        %
        %          instancesInjecte = [10,5,15];
        %          for fivefifteen=2:3
        %              BaseName=['Motif1numInst_', num2str(instancesInjecte(fivefifteen))];
        
%         BaseName='MV_Sync_Motif1';%'Motif10';%'Motif1numInst_10';%%1';%'Motif';%
        
        %'Motif1';%numInst_10';%'MV_Sync_Motif';%'Motif10';%
        % MoCap
        % TS_index = [17, 20, 33, 37, 38, 40, 52, 59, 61, 69, 71, 81, 83, 86, 91, 92, 100, 104, 113, 115, 121, 130, 132, 133, 138, 141, 142, 143, 148, 151]; % MoCap Dataset
        
        % Energy dataset
        % TS_index = [2, 6, 9, 11, 18, 19, 24, 26, 28, 30, 31, 33, 34, 37, 42, 51, 53, 54, 57, 58, 68, 75, 78, 81, 85, 90, 91, 95, 96, 100]; % Energy Dataset
        
        % BirdSong dataset
        %TS_index = [3, 6, 8, 11, 21, 24, 32, 50, 53, 55, 59, 64, 70, 76, 79, 91, 93, 94, 95, 100, 101, 105, 114, 116, 124, 126, 133, 139, 149, 153]; % BirdSong Dataset
        
        algorithm_type = {'RMT'};%,'MStamp'};%'RME',%
        % algorithm_type = {'MStamp'};
        % strategy = [3,6,9];
        strategy = [1, 3, 4, 6, 7, 9];
        num_of_motif = [1,2,3,10];
        amp_scale = [0, 0.1, 0.25, 0.5, 0.75, 1, 2]; % 0.5 0.75 0 1
        timeOverlapThresholds = [0.1,0.25, 0.5, 0.75, 0.90,0.95,0.98, 1];
        
        
        %GroundTruthFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_8_BirdSong/GroundTruthBirdSong/FeaturePosition_Motif'];
        % GroundTruthFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_18_MoCap/GroundTruthMocap/FeaturePosition_Motif'];
        % MotifFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_18_MoCap/AccuracyMotif2_3'];
        
        % Energy Dataset
        % GroundTruthFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_24_Energy/GroundTruth/FeaturePosition_Motif'];
        % MotifFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_24_Energy/Accuracy_Motif2_3'];
        % MotifFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_24_Energy/MStampEnergy'];
        
        
        for i = 1 :  size(num_of_motif, 2)-1
            BaseName= ['Motif',num2str(i)];%['MV_Sync_Motif',num2str(i)];%
            GroundTruthFilePath = [Path,'\data\IndexEmbeddedFeatures\FeaturePosition_',BaseName];
            for ss = 1:size(strategy, 2)
                cur_strategy = strategy(ss);
                for m = 1 : size(amp_scale, 2)
                    for tt = 1 : size(timeOverlapThresholds, 2)
                        for kk = 1 : size(algorithm_type, 2)
                            
                            current_iteration_precision = cell(size(TS_index, 2) * size(testCaseIndex, 2), 1);
                            current_iteration_recall = cell(size(TS_index, 2) * size(testCaseIndex, 2), 1);
                            current_iteration_FScore = cell(size(TS_index, 2) * size(testCaseIndex, 2), 1);
                            cur_algorithm_type = algorithm_type{kk};
                            if(strcmp(cur_algorithm_type,'MStamp') == 1)
                                % MotifFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_24_Energy/MStampEnergy'];
                                % MotifFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_18_MoCap/MStampMoCap'];
                                %                         MotifFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_8_BirdSong/MStampBirdSong'];
                                MotifFilePath = [Path,'\MStamp\Accuracy'];
                            elseif(strcmp(cur_algorithm_type,'RME') == 1)
                                MotifFilePath = [Path,'\Features_RME\Accuracy'];
                            else
                                % MotifFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_18_MoCap/Accuracy_Motif2_3'];
                                % MotifFilePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_8_BirdSong/Accuracy'];
                                MotifFilePath = [Path,'\Features_RMT\Accuracy'];
                            end
                            savePath = [Path,'/Result/', cur_algorithm_type,'_',BaseName];
                            % savePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_18_MoCap/Result_', cur_algorithm_type,'_Motif'];
                            % savePath = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Sep_24_Energy/Result_', cur_algorithm_type,'_Motif'];
                            index_count = 1; % keep track of same motif but different number of instances
                            if(strcmp(cur_algorithm_type,'MStamp') == 1 & cur_strategy>3)
                                'Mstamp has just one strategy'
                            else
                                for j = 1 :size(TS_index, 2)
                                    for k = 1 : size(testCaseIndex, 2)
                                        %  fprintf('Num of motif: %d, Strategy: %d, TS index: %d, instance: %d, amp scale: %f, timeOverlapThreshold: %f .\n', num_of_motif(i), strategy(ss), TS_index(j), testCaseIndex(k), amp_scale(m), timeOverlapThresholds(tt));
                                        %                                             GroundTruthFile = [GroundTruthFilePath, num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '_', num2str(amp_scale(m)), '.csv'];
                                        GroundTruthFile = [GroundTruthFilePath, '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '_', num2str(amp_scale(m)), '.csv'];
                                        %% old files
                                        %                                               GroundTruthFile = [GroundTruthFilePath, '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(i)), '.csv'];
                                        
                                        if(strcmp(cur_algorithm_type,'MStamp') == 1)
                                            %                                                 MotifFile = [MotifFilePath, '/',BaseName, num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '_', num2str(amp_scale(m)), '.csv'];
                                            MotifFile = [MotifFilePath, '/',BaseName,  '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '_', num2str(amp_scale(m)), '.csv'];
                                            %oldfiles
                                            %                                                  MotifFile = [MotifFilePath, '/',BaseName,  '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '.csv'];
                                        else
                                            %                                                 MotifFile = [MotifFilePath, '/Strategy_', num2str(cur_strategy), '/AP_DepO_2_DepT_2_',BaseName, num2str(num_of_motif(i)), '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '_', num2str(amp_scale(m)), '.csv'];
                                            MotifFile = [MotifFilePath, '/Strategy_', num2str(cur_strategy), '/AP_DepO_2_DepT_2_',BaseName, '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '_', num2str(amp_scale(m)), '.csv'];
                                            %oldfiles
                                            %                                                 MotifFile = [MotifFilePath, '/Strategy_', num2str(cur_strategy), '/AP_DepO_2_DepT_2_',BaseName, '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '.csv'];
                                        end
                                        
                                        threshold = eps; % if it is non-zero
                                        timeOverlapThreshold = timeOverlapThresholds(tt);
                                        
                                        
                                        algorithmType = algorithm_type{kk};
                                        [currentMotifEntropy, precisionMatrix, recallMatrix, FScoreMatrix, total_index] = motifEvaluation(GroundTruthFile, MotifFile, algorithmType, windowSize, threshold, timeOverlapThreshold, overlapping);
                                  
                                            Namecheck=[BaseName, '_', num2str(TS_index(j)), '_instance_', num2str(testCaseIndex(k)), '_', num2str(amp_scale(m))];
                                            shFolder = [savePath, num2str(num_of_motif(i)), '/Strategy_', num2str(strategy(ss)), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold)];
                                            if(exist(shFolder,'dir')==0)
                                                mkdir(shFolder);
                                            end
                                            savePathPrecision = [shFolder, '/Precision_',Namecheck,'.csv'];% BaseName,'_', num2str(TS_index(j)), num2str(index_count), '.csv'];
                                            savePathRecall = [shFolder, '/Recall_',Namecheck,'.csv'];%,BaseName,'_', num2str(TS_index(j)), num2str(index_count), '.csv'];
                                            savePathFScore = [shFolder, '/FScore_',Namecheck,'.csv'];%,BaseName,'_', num2str(TS_index(j)), num2str(index_count), '.csv'];
                                            savePathRemainIndex = [shFolder, '/RemainIndex_',Namecheck,'.csv'];%,BaseName,'_', num2str(TS_index(j)), num2str(index_count), '.csv'];
                                            csvwrite(savePathPrecision, precisionMatrix);
                                            csvwrite(savePathRecall, recallMatrix);
                                            csvwrite(savePathFScore, FScoreMatrix);
                                            csvwrite(savePathRemainIndex, total_index);
                                            
                                            
                                        current_iteration_precision{index_count} = precisionMatrix;
                                        current_iteration_recall{index_count} = recallMatrix;
                                        current_iteration_FScore{index_count} = FScoreMatrix;
                                        
                                        index_count = index_count + 1;
                                    end
                                end
                                
                                
                                index_count = index_count - 1;
                                
                                cur_num_of_motif = num_of_motif(i);
                                fprintf('Aggregating... \n');
                                
%                                 sharedFolder = [Path,'/Result',num2str(instancesInjecte(fivefifteen)),'/', cur_algorithm_type, '_Motif', num2str(cur_num_of_motif), '/Strategy_', num2str(cur_strategy), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold)];
                                sharedFolder = [Path,'/Result','/', cur_algorithm_type, '_Motif', num2str(cur_num_of_motif), '/Strategy_', num2str(cur_strategy), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold)];
%                                   sharedFolder = ['D:/',Ds_Name,'/Result/', cur_algorithm_type, '_Motif', num2str(cur_num_of_motif), '/Strategy_', num2str(cur_strategy), '/amp_scale_', num2str(amp_scale(m)), '_TO_', num2str(timeOverlapThreshold)];
                                
                                if(exist(sharedFolder,'dir')==0)
                                    mkdir(sharedFolder);
                                end
                                precision_file_path = [sharedFolder, '/', cur_algorithm_type, 'Precision_'];
                                recall_file_path = [sharedFolder, '/', cur_algorithm_type, 'Recall_'];
                                FScore_file_path = [sharedFolder, '/', cur_algorithm_type, 'FScore_'];
                                aggregated_precision_file = [precision_file_path, overlapping,'aggregated.csv'];
                                aggregated_recall_file = [recall_file_path, overlapping,'aggregated.csv'];
                                aggregated_FScore_file = [FScore_file_path,overlapping, 'aggregated.csv'];
                                
                                aggregated_precision = zeros(index_count, cur_num_of_motif+1+1);
                                aggregated_recall = zeros(index_count, cur_num_of_motif+1+1);
                                aggregated_FScore = zeros(index_count, cur_num_of_motif+1+1);
                                
                                for ii = 1 : index_count
                                    precision_matrix = current_iteration_precision{ii};
                                    recall_matrix = current_iteration_recall{ii};
                                    FScore_matrix = current_iteration_FScore{ii};
                                    
                                    new_precision_matrix = zeros(size(precision_matrix, 1) + 1, size(precision_matrix, 2) + 1);
                                    new_recall_matrix = zeros(size(recall_matrix, 1) + 1, size(recall_matrix, 2) + 1);
                                    new_FScore_matrix = zeros(size(FScore_matrix, 1) + 1, size(FScore_matrix, 2) + 1);
                                    
                                    num_output_class = size(precision_matrix, 1);
                                    num_of_class = size(precision_matrix, 2);
                                    
                                    % compute row-wise average -- for checking purpose
                                    for jj = 1 : num_output_class
                                        new_precision_matrix(jj, 1 : size(precision_matrix, 2)) = precision_matrix(jj, :);
                                        if(sum(isnan(precision_matrix(jj, :)) > 0))
                                            my_precision = max(precision_matrix(jj, :));
                                        else
                                            my_precision = mean(precision_matrix(jj, :));
                                        end
                                        new_precision_matrix(jj, size(new_precision_matrix, 2)) = my_precision;
                                        
                                        new_recall_matrix(jj, 1 : size(recall_matrix, 2)) = recall_matrix(jj, :);
                                        if(sum(isnan(recall_matrix(jj, :)) > 0))
                                            my_recall = max(recall_matrix(jj, :));
                                        else
                                            my_recall = mean(recall_matrix(jj, :));
                                        end
                                        new_recall_matrix(jj, size(new_recall_matrix, 2)) = my_recall;
                                        
                                        new_FScore_matrix(jj, 1 : size(FScore_matrix, 2)) = FScore_matrix(jj, :);
                                        if(sum(isnan(FScore_matrix(jj, :)) > 0))
                                            my_FScore = max(FScore_matrix(jj, :));
                                        else
                                            my_FScore = mean(FScore_matrix(jj, :));
                                        end
                                        new_FScore_matrix(jj, size(new_FScore_matrix, 2)) = my_FScore;
                                    end
                                    
                                    % compute column-wise average -- real average stats
                                    temp_matrix = new_precision_matrix(1 : end - 1, :);
                                    for jj = 1 : size(new_precision_matrix, 2)
                                        nan_index = isnan(temp_matrix(:, jj));
                                        number_index = find(nan_index ~= 1);
                                        temp_array = nonzeros(temp_matrix(number_index, jj));
                                        if( size(temp_array, 1) == 0)
                                            new_precision_matrix(size(new_precision_matrix, 1), jj) = 0;
                                        else
                                            new_precision_matrix(size(new_precision_matrix, 1), jj) = sum(temp_array) / (size(temp_array, 1)) ;
                                        end
                                    end
                                    
                                    temp_matrix = new_recall_matrix(1 : end - 1, :);
                                    for jj = 1 : size(new_recall_matrix, 2)
                                        nan_index = isnan(temp_matrix(:, jj));
                                        number_index = find(nan_index ~= 1);
                                        temp_array = nonzeros(temp_matrix(number_index, jj));
                                        if( size(temp_array, 1) == 0)
                                            new_recall_matrix(size(new_recall_matrix, 1), jj) = 0;
                                        else
                                            new_recall_matrix(size(new_recall_matrix, 1), jj) = sum(temp_array) / (size(temp_array, 1)) ;
                                        end
                                        
                                    end
                                    
                                    temp_matrix = new_FScore_matrix(1 : end - 1, :);
                                    for jj = 1 : size(new_FScore_matrix, 2)
                                        nan_index = isnan(temp_matrix(:, jj));
                                        number_index = find(nan_index ~= 1);
                                        temp_array = nonzeros(temp_matrix(number_index, jj));
                                        if( size(temp_array, 1) == 0)
                                            new_FScore_matrix(size(new_FScore_matrix, 1), jj) = 0;
                                        else
                                            new_FScore_matrix(size(new_FScore_matrix, 1), jj) = sum(temp_array) / (size(temp_array, 1)) ;
                                        end
                                        
                                    end
                                    
                                    aggregated_precision(ii, 1) = ii;
                                    aggregated_recall(ii, 1) = ii;
                                    aggregated_FScore(ii, 1) = ii;
                                    
                                    aggregated_precision(ii, 2 : end) = new_precision_matrix(size(new_precision_matrix, 1), :);
                                    aggregated_recall(ii, 2 : end) = new_recall_matrix(size(new_recall_matrix, 1), :);
                                    aggregated_FScore(ii, 2 : end) = new_FScore_matrix(size(new_FScore_matrix, 1), :);
                                end
                                
                                csvwrite(aggregated_precision_file, aggregated_precision);
                                csvwrite(aggregated_recall_file, aggregated_recall);
                                csvwrite(aggregated_FScore_file, aggregated_FScore);
                            end % end if to avoid double computation of mstamp
                            clear current_iteration_precision current_iteration_recall current_iteration_FScore aggregated_precision aggregated_recall aggregated_FScore
                            
                        end
                    end
                end
            end
            %             end
        end
    end
end
fprintf('All done .\n');