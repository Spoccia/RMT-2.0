function [variateGroup] = computeVariateGroup(nonZeroDepdScale, idm, DepdO, depdScale)
% current test case DepdO = 2
variateGroup = [];
totalVariate = size(depdScale, 1);
targetVariateSize = size(nonZeroDepdScale, 1);
minGroupID = min(idm{DepdO});
maxGroupID = max(idm{DepdO});

for i = minGroupID : maxGroupID
    groupIndex = find(idm{DepdO} == i);
    if(size(groupIndex, 1) == targetVariateSize)
       variateGroup = [variateGroup, groupIndex]; 
    end
end