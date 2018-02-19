function [variates] = random_variate_selection(nonZeroDepdScale, depd_scale_length)
% randomly pick nonZeroDepdScale number of variates for injection
num_of_variate = size(nonZeroDepdScale, 1);
total_num_of_variate = depd_scale_length;
variates = [];

for i = 1 : num_of_variate
    selected_index = randi([1, total_num_of_variate], 1, 1);
    while(ismember(selected_index, variates) == 1)
        selected_index = randi([1, total_num_of_variate], 1, 1);
    end
    variates = [variates; selected_index];
end