function [my_picked_features, variates] = pick_Features_same_variate_group(featuresOfInterest, depdScale, num_of_features_to_pick)
% pick multiple features of the smallest size
picked_features_index = [];
candidate_feature_size = size(depdScale, 2);
for i = 1 : num_of_features_to_pick
    current_randi = randi([1 candidate_feature_size],1,1);
    current_feature_index = current_randi;
    % current_feature_index = smallest_coverage_feature_index(current_randi);
    % skip duplicate
    while(ismember(current_feature_index, picked_features_index) || ismember(depdScale(:, current_feature_index)', depdScale(:, picked_features_index)', 'rows'))
        current_randi = randi([1 candidate_feature_size],1,1);
        current_feature_index = current_randi;
        % current_feature_index = smallest_coverage_feature_index(current_randi);
    end
    
    % load feature and feature index
    picked_features_index = [picked_features_index, current_feature_index];
end

my_picked_features = featuresOfInterest(:, picked_features_index);
variates = depdScale(:, picked_features_index);