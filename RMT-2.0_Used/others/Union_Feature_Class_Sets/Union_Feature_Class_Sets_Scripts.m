% union leave-one-out importance OR feature set across different class
clc;
clear;

DATA_SIZE = 184;
CLASS_SIZE = 8;

TrainedFolder = ['/Users/sicongliu/Desktop/features/NewPara/FullScale_SigmaT28SigmaD05_Octave3/SVM_Trained_Paired_6Dimensions/'];
SaveFolder = ['/Users/sicongliu/Desktop/features/NewPara/FullScale_SigmaT28SigmaD05_Octave3/SVM_Union_Feature_Importance_Paired_6Dimensions/'];

% for each leave-one-out data element
for data_index = 1 : DATA_SIZE
    fprintf('Data Index: %d .\n', data_index);
    % for each class
    class_pickup_index = 1;
    descrRangePath = [TrainedFolder, 'descrRange_Class_', num2str(class_pickup_index), '_', num2str(data_index), '.csv'];
    uniqueFeaturesPath = [TrainedFolder, 'uniqueFeature_Class_', num2str(class_pickup_index), '_', num2str(data_index), '.csv'];
    projectMatrixPath = [TrainedFolder, 'projectMatrix_Class_', num2str(class_pickup_index), '_', num2str(data_index), '.csv'];
    
    descrRange = csvread(descrRangePath);
    uniqueFeature = csvread(uniqueFeaturesPath);
    projectMatrix = csvread(projectMatrixPath);
    
    % only importance different the rest are the same
    importance = [];
    for class_index = 1 : CLASS_SIZE
        importancePath = [TrainedFolder, 'importance_Class_', num2str(class_index), '_', num2str(data_index), '.csv'];
        if(class_index == 1)
            importance = csvread(importancePath);
        else
            current_importance = csvread(importancePath);
            importance = importance | current_importance;
        end
    end
    savedescrRangePath = [SaveFolder, 'descrRange_', num2str(data_index), '.csv'];
    saveUniqueFeaturesPath = [SaveFolder, 'uniqueFeature_', num2str(data_index), '.csv'];
    saveProjectMatrix = [SaveFolder, 'projectMatrix_', num2str(data_index), '.csv'];
    csvwrite(savedescrRangePath, descrRange);
    csvwrite(saveUniqueFeaturesPath, uniqueFeature);
    csvwrite(saveProjectMatrix, projectMatrix);
    
    saveImportancePath = [SaveFolder, 'importance_', num2str(data_index), '.csv'];
    csvwrite(saveImportancePath, importance);
end
fprintf('Fin .\n');