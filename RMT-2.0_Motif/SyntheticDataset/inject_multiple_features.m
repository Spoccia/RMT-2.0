function [rndWalks, FeatPositions, injectedDepdScale] = inject_multiple_features(patternFeatures, patternDepdScales, sameVariateGroup, NumInstances, rndWalks, FeatPositions, data, idm, DepdO, num_of_features_to_pick)
% sameVariateGroup = 1: feature injected to same group of variates
% sameVariateGroup = 0: feature injected to different group of variates

% for different scale feature inseration, insert twice each time
if(sameVariateGroup ==1 )
    NumInstances = NumInstances / 2;
end

injectedDepdScale = [];

pStep = 1;
Step = floor(size(rndWalks, 2) / NumInstances); % avoid injecting features in the same position

if(sameVariateGroup == 0)
    % different variate group but same interval time
    % nonZeropatternDepdScale = patternDepdScale(patternDepdScale > 0);
    
    % inject the same pattern
    
    for i = 1 : NumInstances
        round_robin_feature_index = mod(i, size(patternFeatures, 2));
        if(round_robin_feature_index == 0)
            round_robin_feature_index = num_of_features_to_pick;
        end
        variateGroups = compute_mutiple_variate_group(patternDepdScales(:, round_robin_feature_index), idm, DepdO);
        % compute variate group -- find variate group in graph, size same as mypatternDepdScale
        variateGroup = variateGroups{round_robin_feature_index};
        nonZeropatternDepdScale = nonzeros(patternDepdScales(:, round_robin_feature_index));
        pattern_time_sigma = patternFeatures(4, round_robin_feature_index);
        pattern_time_start = patternFeatures(2, round_robin_feature_index);
        timeScope = pattern_time_sigma * 3;
        intervaltime = (max(round((pattern_time_start - timeScope)), 1) : (min(round((pattern_time_start + timeScope)), size(data, 2)))); % feature time scope (integer)
        motifData = data(:, intervaltime);
        [~, motifColumn] = size(motifData);
        patternTimeSeriesData = data(nonZeropatternDepdScale, intervaltime);
        
        % insert same feature at different variate groups
        if(pStep == 1)
            starter = 1;
        else
            starter = randi([pStep, max(pStep + Step - motifColumn, 0)],1,1);
        end
        
        FeatPositions(i, :) = [i, patternFeatures(2, round_robin_feature_index), starter, starter + motifColumn - 1];
        mypatternDepdScale = variateGroup(:, mod(i, size(variateGroup, 2)) + 1);
        injectedDepdScale = [injectedDepdScale, mypatternDepdScale];
        rndWalks(mypatternDepdScale, starter : starter + motifColumn - 1) = patternTimeSeriesData; % inject the features into random walk time series data
        pStep = pStep + Step;
    end
else
    
    for i = 1 : NumInstances
        
        round_robin_feature_index1 = mod(i, size(patternFeatures, 2));
        if(round_robin_feature_index1 == 0)
            round_robin_feature_index1 = num_of_features_to_pick;
        end
        
        round_robin_feature_index2 = mod(i+1, size(patternFeatures, 2));
        if(round_robin_feature_index2 == 0)
            round_robin_feature_index2 = num_of_features_to_pick;
        end
        
        mypatternDepdScale = [patternDepdScales(:, round_robin_feature_index1) patternDepdScales(:, round_robin_feature_index2)];
        % mypatternDepdScale -- depd scales included are identical
        injectedDepdScale = [injectedDepdScale, mypatternDepdScale];
        % mypatternDepdScale = patternDepdScale(:, :) ~= 0;
        
        timeScope_1 = patternFeatures(4, round_robin_feature_index1) * 3;
        timeScope_2 = patternFeatures(4, round_robin_feature_index2) * 3;
        intervaltime_1 = (max(round((patternFeatures(2, round_robin_feature_index1) - timeScope_1)), 1) : (min(round((patternFeatures(2, round_robin_feature_index1) + timeScope_1)), size(data, 2)))); % feature time scope (integer)
        motifData_1 = data(:, intervaltime_1);
        [~, motifColumn_1] = size(motifData_1);
        
        intervaltime_2 = (max(round((patternFeatures(2, round_robin_feature_index2) - timeScope_2)), 1) : (min(round((patternFeatures(2, round_robin_feature_index2) + timeScope_2)), size(data, 2)))); % feature time scope (integer)
        motifData_2 = data(:, intervaltime_2);
        [~, motifColumn_2] = size(motifData_2);
        
        % insert different scale-features into same group of variates
        % size(patternFeature, 2) > 1, insert two at the same time
        
        % starter_1 from lower scale
        starter_1 = randi([pStep, max(pStep + Step - motifColumn_1, 0)],1,1);
        
        % starter_2 from higher scale
        starter_2 = randi([pStep, max(pStep + Step - motifColumn_2, 0)],1,1);
        
        % make sure starter_1 and ender_2 not immediately connected
        starter_1 = max(starter_1, starter_2 + motifColumn_2 - 1 + 5);
        while(starter_2 == starter_1)
            starter_2 = randi([pStep, max(pStep + Step - motifColumn_2, 0)],1,1);
        end
        
        FeatPositions(2 * (i - 1) + 1, :) = [2 * (i - 1) + 1, patternFeatures(2, round_robin_feature_index1), starter_1, starter_1 + motifColumn_1 - 1];
        FeatPositions(2 * i, :) = [2 * i, patternFeatures(2, round_robin_feature_index2), starter_2, starter_2 + motifColumn_2 - 1];
        
        rndWalks(mypatternDepdScale(:, 1) ~=0, starter_1 : starter_1 + motifColumn_1 - 1) = motifData_1(mypatternDepdScale(:, 1) ~=0, :); % inject the features into random walk time series data
        rndWalks(mypatternDepdScale(:, 2) ~=0, starter_2 : starter_2 + motifColumn_2 - 1) = motifData_2(mypatternDepdScale(:, 2) ~=0, :); % inject the features into random walk time series data
        
        pStep = pStep + Step;
    end
end




