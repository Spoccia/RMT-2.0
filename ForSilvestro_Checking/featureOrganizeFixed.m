function [feature1, feature2] = featureOrganizeFixed(feature1, feature2, descr1, descr2, projectMatrix, descrRange, resolution)
% process feature matrix as the same format for matching
descr1 = descr1'*projectMatrix; % base
descr2 = descr2'*projectMatrix; % target


% descrRange1 = zeros(2, size(descr1, 2));
% for i = 1 : size(descrRange, 2)
%     descrRange1(1, i) = min(descr1(:, i));
%     descrRange1(2, i) = max(descr1(:, i));
% end

descr1 = clusterDescrs(descr1, descrRange, resolution);
descr2 = clusterDescrs(descr2, descrRange, resolution);
feature1 =[feature1(1,:)' feature1(2,:)' feature1(3,:)' feature1(3,:)'  descr1];
feature2 =[feature2(1,:)' feature2(2,:)' feature2(3,:)' feature2(3,:)'  descr2];
end

