function [ setofpossiblevalue ] = randomizeSet(queryID,startCluster,endCluster, percentage )
%randomizeSet Summary of this function goes here
% This function compute a percentage of the original set value random set startCluster:endCluster 
%  excluding a value of the set.

    setofpossibleindex= startCluster : endCluster;%(clusterID):Array(clusterID+1)-1;
    %remove the query from the set
    setofpossibleindex(setofpossibleindex==queryID) = []; % r is smaller now
    setofpossiblevalue = setofpossibleindex(randperm(size(setofpossibleindex,2),round(percentage*size(setofpossibleindex,2))));%randi([1,size(setofpossibleindex,2)],1,round(0.6*size(setofpossibleindex,2))));
end

