function [my_picked_features, variates] = pick_Features(featuresOfInterest, depdScale, num_of_features_to_pick)
% pick features (from small scales to larger ones) for injection, in round-robin
nonzero_depd_scope = sum(depdScale > 0);
num_of_features = size(featuresOfInterest, 2);
picked_features_index = [];
[sorted_values, index] = sort(nonzero_depd_scope);

j = 1;
for i = 1 : num_of_features_to_pick
    % if current candidate index is already picked, or its depd_size is the same as the last injected candidate
    if(size(picked_features_index, 2) == 0)
        % last_injected_index = 0;
        last_injected_feature_size = 0;
    else
        last_injected_index = picked_features_index(size(picked_features_index, 2));
        last_injected_feature_size = sorted_values(index == last_injected_index);
    end
    
    % skip duplicate
    while(ismember(index(j), picked_features_index) || nonzero_depd_scope(index(j)) == last_injected_feature_size)
        j = mod(j+1, num_of_features + 1);
        if(j == 0)
            j = 1;
        end
    end
    
    % load feature and feature index
    picked_features_index = [picked_features_index, index(j)];
end

my_picked_features = featuresOfInterest(:, picked_features_index);
variates = depdScale(:, picked_features_index);