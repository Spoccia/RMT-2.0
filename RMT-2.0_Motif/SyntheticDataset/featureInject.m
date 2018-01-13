function [rndWalks, FeatPositions] = featureInject(patternFeature, depdScale, sameVariateGroup, NumInstances, rndWalks, FeatPositions, data, idm, DepdO)
% sameVariateGroup = 1: feature injected to same group of variates
% sameVariateGroup = 0: feature injected to different group of variates

% for different scale feature inseration, insert twice each time
if(sameVariateGroup ==1 )
    NumInstances = NumInstances / 2;
end

pStep = 0;
Step = floor(size(rndWalks, 2) / NumInstances); % avoid injecting features in the same position

if(sameVariateGroup == 0)
    % different variate group but same interval time
    nonZeroDepdScale = depdScale(depdScale ~= 0);
    
    % compute variate group -- find variate group in graph, size same as myDepdScale
    variateGroup = computeVariateGroup(nonZeroDepdScale, idm, DepdO, depdScale);
    timeScope = patternFeature(4) * 3;
    intervaltime = (max(round((patternFeature(2) - timeScope), 0)) : (min(round((patternFeature(2) + timeScope)), size(data, 2)))); % feature time scope (integer)
    motifData = data(:, intervaltime);
    [~, motifColumn] = size(motifData);
    
    % inject the same pattern
    patternTimeSeriesData = data(nonZeroDepdScale, intervaltime);
    
    % insert same feature at different variate groups
    starter = randi([pStep, max(pStep + Step - motifColumn, 0)],1,1);
    for i = 1 : NumInstances
        FeatPositions(i, :) = [i, patternFeature(2), starter, starter + motifColumn - 1];
        myDepdScale = variateGroup(:, mod(i, size(variateGroup, 2)) + 1);
        rndWalks(myDepdScale, starter : starter + motifColumn - 1) = patternTimeSeriesData; % inject the features into random walk time series data
        pStep = pStep + Step;
    end
else
    for i = 1 : NumInstances
        % myDepdScale -- depd scales included are identical
        myDepdScale = depdScale(:, :) ~= 0;
        timeScope_1 = patternFeature(4, 1) * 3;
        timeScope_2 = patternFeature(4, 2) * 3;
        intervaltime_1 = (max(round((patternFeature(2, 1) - timeScope_1), 0)) : (min(round((patternFeature(2, 1) + timeScope_1)), size(data, 2)))); % feature time scope (integer)
        motifData_1 = data(:, intervaltime_1);
        [~, motifColumn_1] = size(motifData_1);
        
        intervaltime_2 = (max(round((patternFeature(2, 2) - timeScope_2), 0)) : (min(round((patternFeature(2, 2) + timeScope_2)), size(data, 2)))); % feature time scope (integer)
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
        
        FeatPositions(2 * (i - 1) + 1, :) = [2 * (i - 1) + 1, patternFeature(2, 1), starter_1, starter_1 + motifColumn_1 - 1];
        FeatPositions(2 * i, :) = [2 * i, patternFeature(2, 2), starter_2, starter_2 + motifColumn_2 - 1];
        
        rndWalks(myDepdScale(:, 1), starter_1 : starter_1 + motifColumn_1 - 1) = motifData_1(myDepdScale(:, 1), :); % inject the features into random walk time series data
        rndWalks(myDepdScale(:, 1), starter_2 : starter_2 + motifColumn_2 - 1) = motifData_2(myDepdScale(:, 1), :); % inject the features into random walk time series data
        
        pStep = pStep + Step;
    end
end




