function [my_picked_features, variates] = pick_Features(featuresOfInterest, depdScale, num_of_features_to_pick)
% pick multiple features of the smallest size
nonzero_depd_scope = sum(depdScale > 0);
picked_features_index = [];
[sorted_values, index] = sort(nonzero_depd_scope);

smallest_coverage_feature_index = index(sorted_values == sorted_values(1));
candidate_feature_size = size(smallest_coverage_feature_index, 2);

current_picked_feature_index = [];
for i = 1 : num_of_features_to_pick
    current_randi = randi([1 candidate_feature_size],1,1);
    current_feature_index = smallest_coverage_feature_index(current_randi);
    % skip duplicate
    while(ismember(current_feature_index, picked_features_index))
        current_randi = randi([1 candidate_feature_size],1,1);
        current_feature_index = smallest_coverage_feature_index(current_randi);
    end
    
    % load feature and feature index
    picked_features_index = [picked_features_index, current_feature_index];
end

my_picked_features = featuresOfInterest(:, picked_features_index);
variates = depdScale(:, picked_features_index);