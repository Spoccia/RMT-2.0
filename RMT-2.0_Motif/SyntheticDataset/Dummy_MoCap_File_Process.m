clc;
clear;

file_folder = ['/Users/sliu104/Desktop/MoCapTestData/InjectedFeatures/IndexEmbeddedFeatures/FeaturePosition_MoCap'];
file_num = 40;
for i = 1 : file_num
    file_path = [file_folder, num2str(i), '.csv'];
    data = csvread(file_path);
    data(:, 2) = data(:, 1);
    data(:, 1) = 1;
    csvwrite(file_path, data);
end

fprintf('Manual injection done .\n');
