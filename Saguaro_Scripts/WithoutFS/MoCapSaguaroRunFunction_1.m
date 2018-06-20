function MoCapSaguaroRunFunction_1()

scriptIndex = 1;
inputRange = [1, 23]; 
% LocMatrixPath = ['./data/LocationMatrixMoCap.csv']; 
dataPath = ['./data/mocap/']; 
fileList = 1: 184;
trainPath = ['./UnionScale'];
unionFeaturePath = ['./UnionScale']; 
saveFolder = ['./saveFolder_', num2str(scriptIndex), '/'];
% LocM = csvread(LocMatrixPath);
Array = [1, 15, 51, 81, 99, 118, 149, 179, 185];
remainFeatureOctave = zeros(184, 4);
for i = inputRange(1): inputRange(2)
    fprintf('Feature index: %d \n', i);
    savepath1 = [unionFeaturePath, '/feature',num2str(i), '.mat'];
    savepath2 = [unionFeaturePath, '/idm',num2str(i), '.mat'];
    savepath3 = [unionFeaturePath, '/MetaData',num2str(i), '.mat'];
    load(savepath1);
    load(savepath2);
    load(savepath3);
    frame11 = frame1;
    gss11 = gss1;
    idm11 = idm1;
    descr11 = frame1(8:135,:);
    
    % compute amplitude of query data
    datapathx = [dataPath, num2str(i),'.csv'];
    I1 = csvread(datapathx);
    Xamp1 = amplitudediff_unionOnly(I1',frame11,gss11,idm11);
    
    clear gss2 idm2 frame2 descr2
    % time = zeros(size(fileList, 2),3);
    time = [];
    for j = 1: size(fileList, 2)
        fprintf('Query Index : %d , DB Index: %d \n', i, fileList(j));
        
        clusterID = 0;
        dataIndex = fileList(j); % feature importance comes from database features
        for kk = 1 : size(Array, 2)-1
            if(dataIndex >= Array(kk) && dataIndex < Array(kk+1))
                clusterID = kk;
                break;
            end
        end
        fprintf('Cluster ID : %d \n', clusterID);
        XuniqueFeature = load ([trainPath, '/uniqueFeature', num2str(clusterID), '.csv']);
        Ximportance = load([trainPath, '/importance', num2str(clusterID), '.csv']);
        Xproject = load([trainPath, '/projectMatrix', num2str(clusterID), '.csv']);
        XdescrRange = load([trainPath, '/descrRange', num2str(clusterID), '.csv']);
        
        savepath1 = [unionFeaturePath, '/feature',num2str(fileList(j)), '.mat'];
        savepath2 = [unionFeaturePath, '/idm',num2str(fileList(j)), '.mat'];
        savepath3 = [unionFeaturePath, '/MetaData',num2str(fileList(j)), '.mat'];
        load(savepath1);
        load(savepath2);
        load(savepath3);
        frame22 = frame1;
        gss22 = gss1;
        idm22 = idm1;
        descr22 = frame1(8:135,:);
        
        
        datapathx = [dataPath, num2str(fileList(j)),'.csv'];
        I2 = csvread(datapathx);
        % we are forcing the match from query data object
        Xamp2 = amplitudediff_unionOnly(I2',frame22,gss22,idm22);
        
        tic;
        maxTime1 = max(frame11(2, :));
        minTime1 = min(frame11(2, :));
        maxTime2 = max(frame22(2, :));
        minTime2 = min(frame22(2, :));
        p = tic;
        % XuniqueFeature,Ximportance, Xproject, XdescrRange
        % from feature in the database
        
        % [Dist(i,j), remainOctave, timee] = DistanceFrames_GaussianSmoothingUnionImportance(gss11, frame11, idm11, gss22, frame22, idm22, descr11, descr22,XuniqueFeature,Ximportance, Xproject, XdescrRange,Xamp1,Xamp2);
        [Dist(i,j), remainOctave, timee] = DistanceFrames_GaussianSmoothingUnionImportanceMatching(gss11, frame11, idm11, gss22, frame22, idm22, descr11, descr22,XuniqueFeature,Ximportance, Xproject, XdescrRange,Xamp1,Xamp2);
        % [Dist(i,j), remainOctave, timee] = DistanceFrames_GaussianSmoothing_a1p2TimePruningPaired(gss11, frame11, idm11, gss22, frame22, idm22, descr11, descr22, maxTime1, minTime1, maxTime2, minTime2, Xamp1,Xamp2);
        time(j,:) = timee;
        if(i ~= j)
            remainFeatureOctave(i,:) = remainFeatureOctave(i,:) + remainOctave;
            ttRemain(j,:) = remainOctave;
        end
    end
    % savepath = [saveFolder,'UnPairedf3remainDetail',num2str(i), '.csv'];
    
    savepath = [saveFolder,'UnPairedf3remainDetail',num2str(i), '.csv'];
    csvwrite(savepath, ttRemain);
    
    % savepath = [saveFolder,'UnPairedmatchingTime',num2str(i), '.csv'];
    savepath = [saveFolder,'UnPairedmatchingTime',num2str(i), '.csv'];
    csvwrite(savepath, time);
    
    % remainFeatureOctave(i,:) = remainFeatureOctave(i,:)/(size(fileList, 2)-1);
    % beforePruning(i, :) = beforePruning(i, :)/(size(fileList, 2)-1);
    clear frames1 descr1 gss1 dogss1 depd idm I;
end

resultpathDist = [saveFolder, 'UnPairedDist.csv'];
csvwrite(resultpathDist, Dist);
