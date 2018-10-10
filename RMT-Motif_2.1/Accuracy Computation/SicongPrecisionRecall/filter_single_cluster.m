function [myClassID, classID, num] = filter_single_cluster(myClassID, classID, num)
% filter out the single pattern cluster, since single pattern is not a motif

% myClassID : unique(classID)
deprecated_index = [];
for i = 1 : size(myClassID, 1)
    current_cluster_index = find(myClassID(i) == classID);
    if(size(current_cluster_index, 1) <= 1 )
        % remove this single pattern cluster
        deprecated_index = [deprecated_index; current_cluster_index];
    end
end

classID(deprecated_index) = [];
num(deprecated_index, :) = [];
myClassID = unique(classID);




