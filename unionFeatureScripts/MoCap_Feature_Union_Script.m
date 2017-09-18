clc;
clear;
warning off;

adaptiveScalePath = 'D:\Mocap _ RMT2\Features 3 octave  SD 0_6 ST 11_2';%2_8';%['G:\Features_sigmaBig_Right\MoCap\FullScale\Features SD 0_6 ST 2_8'];%5_6 %2_8 %11_2['G:\Features_sigmaBig_Right\ASL\AdaptiveScale\Features'];%
fixedScalePath = 'D:\Mocap _ RMT2\FIX SCALE\Features Octave3 sd 0_6 st 11_2';%2_8';%['G:\Features_sigmaBig_Right\MoCap\FixedScale\Features sd 0_6 st 2_8'];%['G:\Features_sigmaBig_Right\ASL\FixedScale\Features'];%
unionScalePath = 'D:\Mocap _ RMT2\UNION\Features 3 octave  SD 0_6 ST 11_2';%2_8';%['G:\Features_sigmaBig_Right\MoCap\HYBScale\Features sd 0_6 st 2_8'];%['G:\Features_sigmaBig_Right\ASL\UnionScale'];%

fileList = 1 : 184;
for i = 1: size(fileList, 2)
    % load naive model features
    
    fprintf('Feature index: %d \n', i);
    savepath1 = [fixedScalePath, '/feature', num2str(fileList(i)), '.mat'];
    savepath2 = [fixedScalePath, '/idm', num2str(fileList(i))];
    savepath3 = [fixedScalePath, '/MetaData', num2str(fileList(i)), '.mat'];
    load(savepath1);
    load(savepath2);
    load(savepath3);
    frameFixed = frame2;
    gssFixed = gss2;
    idmFixed = idm2;
    descrFixed = descr2;
    
    % load adaptive model features
    savepath1 = [adaptiveScalePath, '/feature_', num2str(fileList(i)), '.mat'];
    savepath2 = [adaptiveScalePath, '/idm_', num2str(fileList(i))];
    savepath3 = [adaptiveScalePath, '/MetaData_', num2str(fileList(i)), '.mat'];
    load(savepath1);
    load(savepath2);
    load(savepath3);
    frameAdaptive = frame1;
    gssAdaptive = gss1;
    idmAdaptive = idm1;
    descrAdaptive = descr1;
    
    IsnanDS1  = sum(descr1);
    idxIsNan1 = isnan(IsnanDS1);
    
    IsnanDS2  = sum(descr2);
    idxIsNan2 = isnan(IsnanDS2);
    
    if (sum(idxIsNan2) > 0)
        i
    frameFixed(:,idxIsNan2) = [];
    descrFixed(:,idxIsNan2) = [];
    end
    if(sum(idxIsNan1) > 0)
        i
    frameAdaptive(:,idxIsNan1) = [];
    descrAdaptive(:,idxIsNan1) = [];
    end
    % untion function goes here
    % [frame1, gss1, descr11, idm1] = unionFeatureSAX(frame1, gss1, idm1, descr1, frame11, gss11, idm11, descr11);
    [frame1, gss1, descr11, idm1] = unionFeature(frameFixed, gssFixed, idmFixed, descrFixed, frameAdaptive, gssAdaptive, idmAdaptive, descrAdaptive);
    
    % frame1 = [frames1;descr11];
    % output features to files
    if(exist([unionScalePath,'/'],'dir')==0)
        mkdir([unionScalePath,'/']);
    end
    savepath1 = [unionScalePath, '/feature', num2str(i), '.mat'];
    savepath2 = [unionScalePath, '/idm', num2str(i)];
    savepath3 = [unionScalePath, '/MetaData', num2str(i), '.mat'];
    
    save(savepath1, 'frame1');
    save(savepath2, 'idm1');
    save(savepath3, 'gss1');
    
    clear frame1 gss1 descr11 idm1
end
fprintf('Union features done .\n');