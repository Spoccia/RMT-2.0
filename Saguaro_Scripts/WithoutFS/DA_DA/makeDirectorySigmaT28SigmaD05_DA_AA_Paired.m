close all;
clc;
clear;

% make directory as save output folder
cluster = 8;
% keyNames = {'AA_AA', 'DA_AA', 'DA_DAAA', 'DA_DAAAFS', 'DAAA_DAAA', 'DAFS_DAAAFS', 'DATA_DAAATA', 'DATO_DAAATO', 'DATP_DAAATP', 'DATS_DAAATS', 'DAVA_DAAAVA', 'DAVS_DAAAVS'};
% keyNames = {'AA_DAAA_a1p1', 'AA_DAAA_a2p1', 'AA_DAAA_a1p1', 'AA_DAAA_a2p2', 'Adaptive_AA_DAAA_a1p1', 'Adaptive_AA_DAAA_a2p1', 'Adaptive_AA_DAAA_a1p1', 'Adaptive_AA_DAAA_a2p2', 'Adaptive2_AA_DAAA_a1p1', 'Adaptive2_AA_DAAA_a2p1', 'Adaptive2_AA_DAAA_a1p1', 'Adaptive2_AA_DAAA_a2p2', 'Fixed_AA_DAAA_a1p1', 'Fixed_AA_DAAA_a2p1', 'Fixed_AA_DAAA_a1p1', 'Fixed_AA_DAAA_a2p2'};

keyNames = {'SigmaT28SigmaD05_DA_AA_a2p2_Paired'};
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
