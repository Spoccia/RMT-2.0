clear;
clc;

featureFolder = ['./FullScale_SigmaT28SigmaD05_Octave3'];
saveFolder = ['./FullScale2_SigmaT28SigmaD05_Octave3'];
dataSize = 184;


for i = 1 : dataSize
    fprintf('Data Index: %d .\n', i);
    loadpath1 = [featureFolder, '/feature_', num2str(i), '.mat'];
    loadpath2 = [featureFolder, '/idm_', num2str(i)];
    loadpath3 = [featureFolder, '/Metadata_', num2str(i), '.mat'];
    
    load(loadpath1);
    load(loadpath2);
    load(loadpath3);
    
    frame1 = frame1(:, frame1(5,:) == frame1(6, :));
    
    savepath1 = [saveFolder, '/feature_', num2str(i), '.mat'];
    savepath2 = [saveFolder, '/idm_', num2str(i), '.mat'];
    savepath3 = [saveFolder, '/MetaData_', num2str(i), '.mat'];
    
    save(savepath1, 'frame1');
    save(savepath2, 'idm1');
    save(savepath3, 'gss1');
    
end

fprintf('Fin .\n');
