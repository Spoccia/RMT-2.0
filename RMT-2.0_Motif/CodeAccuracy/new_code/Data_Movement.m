clear;
clc;

% Aggregate RMT & MStamp in one table, output as txt file
fprintf('Aggregating precision and recall files... \n');
testCaseIndex = 1 : 100; % 30 time series used, 10 instances each
pivot_index = 1;
portion = [2:3];
strategy = [1:9];
num_of_motif = [1:3];
algorithm_type = {'RMT', 'MStamp'}; % MStamp, MatrixProfile, RMT, RME, cleanmatlabentropy09
timeOverlapThresholds = [0.1, 0.25, 0.5, 0.75, 1];
amp_scale = [0, 0.1, 0.25, 0.5, 0.75, 1];

source_folder = [];

base_source_folder = [];
shared_source_folder = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Aug_20/'];
base_target_folder = ['/Users/sliu104/Desktop/MyMotif/Silvestro_Aug_20/Merged/Result_'];
for pp = 1 : size(portion, 2)
    if( portion(pp) == 1)
        pivot_index = 0;
        base_source_folder = [shared_source_folder, 'First_10_Raw_Backup/Result_'];
    elseif( portion(pp) == 2)
        pivot_index = 100;
        base_source_folder = [shared_source_folder, 'Second_10_Raw_Backup/Result_'];
    else
        pivot_index = 200;
        base_source_folder = [shared_source_folder, 'Third_10_Raw_Backup/Result_'];
    end
    
    for kk = 1 : size(algorithm_type, 2)
        for i = 1 : size(num_of_motif, 2)
            cur_num_of_motif = num_of_motif(i);
            for j = 1 : size(strategy, 2)
                cur_strategy = strategy(j);
                for aa = 1 : size(amp_scale, 2)
                    for tt = 1 : size(timeOverlapThresholds, 2)
                        fprintf('Current pivot: %d, Num of motif: %d, Strategy: %d, amp scale: %f, timeOverlapThreshold: %f .\n', pivot_index, num_of_motif(i), cur_strategy, amp_scale(aa), timeOverlapThresholds(tt));
                        
                        
                        source_file = [base_source_folder, algorithm_type{kk}, '_Motif', num2str(cur_num_of_motif), '/Strategy_', num2str(cur_strategy), '/amp_scale_', num2str(amp_scale(aa)), '_TO_', num2str(timeOverlapThresholds(tt))];
                        target_folder = [base_target_folder, algorithm_type{kk}, '_Motif', num2str(cur_num_of_motif), '/Strategy_', num2str(cur_strategy), '/amp_scale_', num2str(amp_scale(aa)), '_TO_', num2str(timeOverlapThresholds(tt))];
                        
                        if(exist(target_folder,'dir')==0)
                            mkdir(target_folder);
                        end
                        
                        for ts = 1 : size(testCaseIndex, 2)
                            source_FScore = [source_file, '/', algorithm_type{kk}, 'FScore_', num2str(ts), '.csv'];
                            source_precision = [source_file, '/', algorithm_type{kk}, 'precision_', num2str(ts), '.csv'];
                            source_recall = [source_file, '/', algorithm_type{kk}, 'recall_', num2str(ts), '.csv'];
                            
                            target_file_index = ts + pivot_index;
                            target_FScore = [source_file, '/', algorithm_type{kk}, 'FScore_', num2str(target_file_index), '.csv'];
                            target_precision = [source_file, '/', algorithm_type{kk}, 'precision_', num2str(target_file_index), '.csv'];
                            target_recall = [source_file, '/', algorithm_type{kk}, 'recall_', num2str(target_file_index), '.csv'];
                            
                            if(portion(pp) == 1)
                            else
                                % change file name
                                movefile(source_FScore, target_FScore);
                                movefile(source_precision, target_precision);
                                movefile(source_recall, target_recall);
                            end
                            
                            copyfile(target_FScore,target_folder);
                            copyfile(target_precision,target_folder)
                            copyfile(target_recall,target_folder)
                        end
                    end
                end
            end
        end
    end
end
fprintf('All done .\n');