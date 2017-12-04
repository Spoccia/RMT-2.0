% This matlab script reads a cluster of a features and saves features that have similiar variates as one cluster
function returned= allignClusterFeatures()
clc;
clear;

SubDSPath = 'data\';%'FlatTS_MultiFeatureDiffClusters\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
datasetPath = 'D:\Motif_Results\Datasets\Mocap\';
subfolderPath = '';%'Z_A_Temp_C\';%
FeaturesRM ='RMT';%'RME';%

% Path Parameters
TEST ='1';%
typeofCluster='ClusterMatlab';
distanceUsed ='Descriptor';%'Amplitude_Descriptor';%
SizeofK = 'Fixed';
TS_name = TEST;
imagename = TS_name;
saveFeaturesPath = [datasetPath, subfolderPath, 'Features_', FeaturesRM, '\', TS_name, '\'];

savepath1 = [saveFeaturesPath, 'feature_', TS_name,'.mat'];
savepath2 = [saveFeaturesPath, 'idm_', TS_name,'.mat'];
savepath3 = [saveFeaturesPath, 'MetaData_', TS_name,'.mat'];
ClusterPath = [saveFeaturesPath,'DistancesDescriptors\Cluster_',SizeofK,'\',distanceUsed,'\',typeofCluster];
%         ImageSavingPath=[saveFeaturesPath,'DistancesDescriptors\Cluster_',K_valuesCalc,'\',distanceUsed,'\BP_Kmeans_CosineDescriptor'];%\imageMotifs\',imagename];
%         RebSeriesPath = [saveFeaturesPath,'DistancesDescriptors\Cluster_',K_valuesCalc,'\',distanceUsed,'\BP_Kmeans_CosineDescriptor\rebClusters\'];
load(savepath1);
load(savepath2);
load(savepath3);
depdOverLapThreshold = 0.5;

reOrgFeatures = [];
subFeatureLabels = []; % design as a row vector
for timeOctave = 2:DeOctTime
    for depdOctave = 2:DeOctDepd
        if(exist(strcat(ClusterPath, '\Cluster_IM_', imagename, '_DepO_', num2str(depdOctave), '_TimeO_', num2str(timeOctave), '.csv'), 'file')~=0)
            
            % for features from each octave
            indexfeatureGroup = (frame1(6,:) == timeOctave & frame1(5,:) == depdOctave);
            X = frame1(:,indexfeatureGroup);
            depdScaleRead = csvread(strcat(saveFeaturesPath, 'DistancesDescriptors\DepdScale_IM_', imagename, '_DepO_', num2str(depdOctave),'_TimeO_',num2str(timeOctave),'.csv'));
            
            % read output from preivous k-means
            C = csvread(strcat(ClusterPath,'\Cluster_IM_',imagename,'_DepO_',num2str(depdOctave),'_TimeO_',num2str(timeOctave),'.csv'));
            mu = csvread(strcat(ClusterPath,'\Centroids_IM_',imagename,'_DepO_',num2str(depdOctave),'_TimeO_',num2str(timeOctave),'.csv'));
            clusterLabel = unique(C);
            numberOfClusters = length(clusterLabel);
            
            % subCluster label for interesting octave monotonically increases
            % for features from different octaves, subClusterLabel reset to 1
            subClusterLabel = 1; 
            
            for clusterIndex = 1 : numberOfClusters
                % get the features from current clutser index
                clusterFeatures = X(:, C == clusterLabel(clusterIndex));
                
                % create sub-cluster below
                depdScale = depdScaleRead(:, C == clusterLabel(clusterIndex));
                
                % should use cell structure to index cluster features
                Depd_OverLapping = zeros(size(clusterFeatures, 2));
                
                for queryFeatureIndex = 1 : size(clusterFeatures, 2)
                    % dataFeatureIndex starts from queryFeatureIndex since our goal is to group feature from the same simulation data
                    for dataFeatureIndex = queryFeatureIndex : size(clusterFeatures, 2)
                        % use symmetric approach to define the similiar motifs below
                        overlap = overlapJaccardSimilarity(depdScale(:, queryFeautreIndex), depdScale(:, dataFeatureIndex));
                        Depd_OverLapping(queryFeatureIndex, dataFeatureIndex) = overlap;
                        Depd_OverLapping(dataFeatureIndex, queryFeatureIndex) = overlap;
                    end
                end
                Depd_OverLapping = Depd_OverLapping > depdOverLapThreshold;
                stopFlag= 0;
                while(stopFlag == 0 )
                    columnSum = sum(Depd_OverLapping); % row vector
                    [maxSum, index] = max(columnSum);
                    if(maxSum<=1)%(maxSum == 0) % check maxSum condition at the beginning Silv Did <=1 because 1 means single cluster
                        stopFlag = 1;
                    else
                        subClusterFeatureIndex = Depd_OverLapping(:, index); % column vector
                        %nonZeroEntryIndex = find(subClusterFeatureIndex ~= 0); % nonZeroEntryIndex is the actual feature index from current cluster
                        subClusterFeatures =  clusterFeatures(:, subClusterFeatureIndex);
                        
                        % re-org features and the feathre labels
                        reOrgFeatures       = [reOrgFeatures, subClusterFeatures];
                        currentFeatureLabel = [currentFeatureLabel, repmat(subClusterLabel, 1, size(subClusterFeatures, 2))]; % design as a row vector
                        reorgCentroids      = [reorgCentroids,avg(currentFeatureLabel')'];
                        currentFeatDepd     = [currentFeatDepd,depdScale(:,subClusterFeatureIndex)];
                        
                        prevFeaturesLabel   = [prevFeaturesLabel,repmat(clusterIndex, 1, size(subClusterFeatures, 2))];   
                        % save as index: subClusterLabel
                        subClusterLabel = subClusterLabel + 1;
                        
                        % now update Depd_OverLapping matrix
                        zeroColumn = zeros(size(subClusterFeatureIndex));
                        Depd_OverLapping(:, index) = zeroColumn;
                    end
                end
                
                % Depd_OverLapping = Depd_OverLapping(~cellfun(@(x) size(x, 2)==1, Depd_OverLapping));
                %                 %%  need to revise the apporach below
                %                 % timeScope = A(4, :)*3;
                %                 Depd_OverLapping = zeros(size(clusterFeatures, 2));
                %                 for queryFeatureIndex = 1 : size(clusterFeatures, 2)
                %                     % dataFeatureIndex starts from queryFeatureIndex since our goal is to group feature from the same simulation data
                %                     % for dataFeatureIndex = queryFeatureIndex : size(A, 2)
                %                     for dataFeatureIndex = 1 : size(clusterFeatures, 2)
                %                         % Depd_OverLapping(queryFeatureIndex, dataFeatureIndex) = (size(intersect(B(:,queryFeatureIndex),B(:,dataFeatureIndex)),1)-1)/(size(union(B(:, queryFeatureIndex), B(:,dataFeatureIndex)), 1)-1);
                %                         % Depd_OverLapping(dataFeatureIndex, queryFeatureIndex) = Depd_OverLapping(queryFeatureIndex,dataFeatureIndex);
                %
                %                         % use separate functions below, as shown in RMT journal paper, the values should not be symetric
                %                         Depd_OverLapping(queryFeatureIndex, dataFeatureIndex) = overlapQueryFeature(depdScale(:, queryFeautreIndex), depdScale(:, dataFeatureIndex));
                %                     end
                %                 end
                %                 idx_Depd_OverLapping = Depd_OverLapping > depdOverLapThreshold;
                %                 idxmax = max(sum(idx_Depd_OverLapping));
                %                 A1 = clusterFeatures(:, idx_Depd_OverLapping(idxmax, :));
                %                 B1 = depdScale(:, idx_Depd_OverLapping(idxmax, :));
                %                 % timeScope1 = A1(4, :)*3;
            end % end marking current cluster at interesting octave
        end
    end
end

function overlap = overlapQueryFeature(depdin1,depdin2)
depdin1 = depdin1(depdin1~=0);
depdin2 = depdin2(depdin2~=0);
ov = intersect(depdin1(1,:),depdin2(1,:));
overlap = size(ov,2)/size(depdin1,2);
end

function overlap = overlapJaccardSimilarity(depdin1,depdin2)
depdin1 = depdin1(depdin1~=0);
depdin2 = depdin2(depdin2~=0);
intersecFeatures = intersect(depdin1(1,:),depdin2(1,:));
unionFeatures = union(depdin1(1,:),depdin2(1,:));
overlap = size(intersecFeatures, 2)/size(unionFeatures, 2);
end

end

