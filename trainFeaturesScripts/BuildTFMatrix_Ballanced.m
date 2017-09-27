function  [Class_Matrix, LabelClass,IndexCasses]= BuildTFMatrix_Ballanced(TimeSeriesRangeSamples, uniqueFeatures,setForClass,StartReductedFeatures)%[TFMatrix, TFLabelVector]
% count the membership and frequency of features from TimeSeriesRangeSamples in uniqueFeatures
% uniqueFeatures: feature instances are organized by rows
% TimeSeriesRangeSamples cell structure: {TimeSeriesCluster, TimeSeriesIndex}

CLUSTER_SIZE = size(TimeSeriesRangeSamples, 1);
UNIQUE_FEATURE_SIZE = size(uniqueFeatures, 1);

TFMatrix = [];
TFLabelVector = [];
% OCTAVE_START = 5; % starting index of depd octave
StructureClass_ID= [];
for Cluster= 1:8
    for id= 1:size(setForClass{clusterID}, 2)
        StructureClass_ID=[StructureClass_ID;Cluster,id];
    end
end
Class_Matrix=[];
LabelClass=[];
for clusterID = 1 : CLUSTER_SIZE
    StructureClass_ID = StructureClass_ID';
    
    IrrelevantIDs = StructureClass_ID;
    IrrelevantIDs(IrrelevantIDs(1, :)==clusterID) = [];
    
    RelevantIDs = StructureClass_ID;
    RelevantIDs (RelevantIDs(1,:)~=clusterID)=[];
    Idx_Sample_Irrelevant=[];
    Idx_Sample_Irrelevant = randperm(size(IrrelevantIDs,2),size(RelevantIDs,2));
    IrrelevantIDs=IrrelevantIDs(:,Idx_Sample_Irrelevant);
    Labels = ones(size(RelevantIDs,2),1);
    Labels = [Labels;ones(size(IrrelevantIDs,2),1)*2];
    AllClassTogether = [RelevantIDs,IrrelevantIDs];
        TIME_SERIES_SIZE_FOR_CLUSTERID = size(AllClassTogether, 2);% TIME_SERIES_SIZE = size(TimeSeriesRangeSamples{clusterID});
        for TSIndex  = 1 :  TIME_SERIES_SIZE_FOR_CLUSTERID
            currentFeatureSet = TimeSeriesRangeSamples{AllClassTogether(1,TSIndex), AllClassTogether(2,TSIndex)};%TimeSeriesRangeSamples{clusterID, TSIndex};

            % count the frequency of each unique features in each of the time series
            current_TF_vector = zeros(1, size(uniqueFeatures, 1));
            for k = 1 : UNIQUE_FEATURE_SIZE

                % prepare to populate TFMatrix(j, :)
                current_unique_feature = uniqueFeatures(k, :);
                frequency = find(all(bsxfun(@eq, currentFeatureSet(:, StartReductedFeatures : end), current_unique_feature(StartReductedFeatures : end)), 2));
                current_TF_vector(k) = size(frequency, 1);
            end
            TFMatrix = [TFMatrix; current_TF_vector];
           
            TFLabelVector = Labels;%[TFLabelVector; clusterID];
            
        end
         Class_Matrix{clusterID}=TFMatrix;
         LabelClass{clusterID}=Labels;
         IndexCasses {clusterID}= AllClassTogether;
end
end

