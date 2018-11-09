function runMoCap_DA_DAAA_a2p2_6_a2p2()

scriptIndex = 6;
inputRange = [116, 138]; 

dataPath = ['./data/mocap/']; 
fileList = 1: 184;
trainPath = ['./FullScale_SigmaT28SigmaD05_Octave3'];
unionFeaturePath = ['./FullScale_SigmaT28SigmaD05_Octave3']; 
saveFolder = ['./save_DA_DAAA_a2p2_Folder_', num2str(scriptIndex), '/'];

Array = [1, 15, 51, 81, 99, 118, 149, 179, 185];
remainFeatureOctave = zeros(184, 9);
for i = inputRange(1): inputRange(2)
    fprintf('Feature index: %d \n', i);
    savepath1 = [unionFeaturePath, '/feature_',num2str(fileList(i)), '.mat'];
    savepath2 = [unionFeaturePath, '/idm_',num2str(fileList(i)), '.mat'];
    savepath3 = [unionFeaturePath, '/MetaData_',num2str(fileList(i)), '.mat'];
    load(savepath1);
    load(savepath2);
    load(savepath3);
    frame11 = frame1;
    gss11 = gss1;
    idm11 = idm1;
    descr11 = frame1(11:138,:);
    
    % compute amplitude of query data
    datapathx = [dataPath, num2str(fileList(i)),'.csv'];
    I1 = csvread(datapathx);
    Xamp1 = amplitudediff_unionOnly(I1',frame11,gss11,idm11);
    
    clear gss2 idm2 frame2 descr2
    % time = zeros(size(fileList, 2),3);
    time = [];
    for j = 1: size(fileList, 2)
        
        
        savepath1 = [unionFeaturePath, '/feature_',num2str(fileList(j)), '.mat'];
        savepath2 = [unionFeaturePath, '/idm_',num2str(fileList(j)), '.mat'];
        savepath3 = [unionFeaturePath, '/MetaData_',num2str(fileList(j)), '.mat'];
        load(savepath1);
        load(savepath2);
        load(savepath3);
        frame22 = frame1;
        gss22 = gss1;
        idm22 = idm1;
        descr22 = frame1(11:138,:);
        
        datapathx = [dataPath, num2str(fileList(j)),'.csv'];
        I2 = csvread(datapathx);
        % we are forcing the match from query data object
        Xamp2 = amplitudediff_unionOnly(I2',frame22,gss22,idm22);
        
        maxTime1 = max(frame11(2, :));
        minTime1 = min(frame11(2, :));
        maxTime2 = max(frame22(2, :));
        minTime2 = min(frame22(2, :));
        p = tic;
        % maxTime1, minTime1, maxTime2, minTime2
        % from feature in the database
        
        [Dist(i,j), remainOctave] = DistanceFrames_DA_DAAA_a2p2(gss11, frame11, idm11, gss22, frame22, idm22, descr11, descr22,maxTime1, minTime1, maxTime2, minTime2,Xamp1,Xamp2);
        time(j) = toc(p);
        if(i ~= j)
            remainFeatureOctave(i,:) = remainFeatureOctave(i,:) + remainOctave;
            % ttRemain(j,:) = remainOctave;
        end
    end
    % savepath = [saveFolder,'UnPairedf3remainDetail',num2str(i), '.csv'];
    % savepath = [saveFolder,'UnPairedf3remainDetail',num2str(i), '.csv'];
    % csvwrite(savepath, ttRemain);
    
    % savepath = [saveFolder,'UnPairedmatchingTime',num2str(i), '.csv'];
    savepath = [saveFolder,'PairedmatchingTime',num2str(i), '.csv'];
    csvwrite(savepath, time);
    
    remainFeatureOctave(i,:) = remainFeatureOctave(i,:)/(size(fileList, 2)-1);
    % beforePruning(i, :) = beforePruning(i, :)/(size(fileList, 2)-1);
    clear frames1 descr1 gss1 dogss1 depd idm I;
end

% resultpathDist = [saveFolder, 'UnPairedDist.csv'];
resultRemainFeatures = [saveFolder, 'remainFeatures.csv'];
csvwrite(resultRemainFeatures, remainFeatureOctave);

% resultpathDist = [saveFolder, 'UnPairedDist.csv'];
resultpathDist = [saveFolder, 'PairedDist.csv'];
csvwrite(resultpathDist, Dist);
