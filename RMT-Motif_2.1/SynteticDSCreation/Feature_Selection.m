clc;
clear;

time_series_index = 2;
feature_path = ['/Users/sliu104/Desktop/MoCapTestData/RMT/2/feature_2.mat'];
depd_path = ['/Users/sliu104/Desktop/MoCapTestData/RMT/2/DistancesDescriptor/DepdScale_IM_2_DepO_2_TimeO_2.csv'];

save_feathre_path = ['/Users/sliu104/Desktop/Features_To_Inject/Features'];
save_depd_path = ['/Users/sliu104/Desktop/Features_To_Inject/Depd'];

features = load(feature_path);
features = features.frame1;
depd = csvread(depd_path);

idx = find(features(5, :) == 2 & features(6, :) == 2);
features = features(:, idx);

nonzeros_size = sum(depd(:, :) > 0);
feature_of_interest = find(nonzeros_size == 3);

selected_features = [];
selected_depd = [];
depds = depd(:, feature_of_interest);
for i = 1 : size(depds, 2) - 1
    if(sum(depds(:, i) - depds(:, i+1)) == 0) % they are the same
        continue;
    else
        selected_features = [selected_features, features(:, feature_of_interest(i))];
        selected_depd = [selected_depd, depds(:, i)];
    end
end

if(sum(depds(:, end) - selected_depd(:, end) ~= 0))
    selected_depd = [selected_depd, depds(:, end)];
    selected_features = [selected_features, features(:, feature_of_interest(end))];
end


save_feathre_file = [save_feathre_path, num2str(time_series_index), '_10.csv'];
save_depd_file = [save_depd_path, num2str(time_series_index), '_10.csv'];

csvwrite(save_feathre_file, selected_features);
csvwrite(save_depd_file, selected_depd);