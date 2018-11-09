close all;
clc;
clear;

% make directory as save output folder
cluster = 46;

keyNames = {'SVM_Model'};
prefix = 'save_';

for i = 1 : size(keyNames, 2)
    keyName = keyNames{i};
    for j = 1 : cluster
        folderName = [prefix, keyName, '_Folder_', num2str(j)];
        mkdir(folderName);
    end
    fprintf(keyName, 'done .\n');
end

fprintf('Fin .\n');
