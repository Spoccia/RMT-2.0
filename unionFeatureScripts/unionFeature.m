function [frameUnion, gssFixed, descrAdaptive, idm1Fixed] = unionFeature(frameFixed, gssFixed, idm1Fixed, descrFixed, frameAdaptive, gssAdaptive, idmAdaptive, descrAdaptive)
% frameFixed -- features from fixed-scale
% frameAdaptive -- features from adaptive-scale
frameAdaptive(8:10,:) = [];

frameFixed2 = frameAdaptive(:,frameAdaptive(5,:) == frameAdaptive(6,:));
frameAdaptive = frameAdaptive(:,frameAdaptive(5,:) ~= frameAdaptive(6,:));

% union
[C, ia, ib]= union(frameFixed',frameFixed2','rows');
C = C';
frameFixedRemain = frameFixed(:, ia');
frameFixed2 = frameFixed2(:, ib');

frameUnion = [frameFixedRemain frameAdaptive frameFixed2];
descrAdaptive = frameUnion(8:135,:);



