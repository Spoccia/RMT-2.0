function [variateGroup] = compute_mutiple_variate_group(patternDepdScale, idm, DepdO)
% current test case DepdO = 2
% variateGroup = [];
variateGroup = cell(size(patternDepdScale, 2), 1);
minGroupID = min(idm{DepdO});
maxGroupID = max(idm{DepdO});
for i = 1 : size(patternDepdScale, 2)
    target_variate_group = patternDepdScale(:, i);
    target_variate_size = size(nonzeros(target_variate_group), 1);
    for j = minGroupID : maxGroupID
        groupIndex = find(idm{DepdO} == j);
        if(size(groupIndex, 1) == target_variate_size)
            variateGroup{i} = [variateGroup{i}, groupIndex];
        end
    end
    
end








