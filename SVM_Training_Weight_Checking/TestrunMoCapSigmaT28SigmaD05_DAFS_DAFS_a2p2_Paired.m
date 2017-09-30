function TestrunMoCapSigmaT28SigmaD05_DAFS_DAFS_a2p2_Paired()

scriptIndex = 1;
inputRange = [1, 23];

dataPath = ['/Users/sicongliu/Desktop/data/mocap/'];
fileList = 1: 184;
trainPath = ['/Users/sicongliu/Desktop/features/NewPara/FullScale_SigmaT28SigmaD05_Octave3/SVM_Paired'];
unionFeaturePath = ['/Users/sicongliu/Desktop/features/NewPara/FullScale_SigmaT28SigmaD05_Octave3'];

saveFolder = ['./save_SigmaT28SigmaD05_DAFS_DAFS_a2p2_Paired1_Folder_', num2str(scriptIndex), '/'];

Array = [1, 15, 51, 81, 99, 118, 149, 179, 185];
remainFeatureOctave = zeros(184, 9);
for i = inputRange(1): inputRange(2)
    fprintf('Feature index: %d \n', i);
    savepath1 = [unionFeaturePath, '/feature_',num2str(i), '.mat'];
    savepath2 = [unionFeaturePath, '/idm_',num2str(i), '.mat'];
    savepath3 = [unionFeaturePath, '/MetaData_',num2str(i), '.mat'];
    load(savepath1);
    load(savepath2);
    load(savepath3);
    frame11 = frame1;
    gss11 = gss1;
    idm11 = idm1;
    descr11 = frame1(11:138,:);
    
    % compute amplitude of query data
    datapathx = [dataPath, num2str(i),'.csv'];
    I1 = csvread(datapathx); queryTimeSeriesLength = size(I1, 1);
    Xamp1 = amplitudediff_unionOnly(I1',frame11,gss11,idm11);
    
    clear gss2 idm2 frame2 descr2
    % time = zeros(size(fileList, 2),3);
    time = [];
    for j = 1: size(fileList, 2)
        fprintf('Query Index : %d , DB Index: %d ', i, fileList(j));
        
        clusterID = 0;
        dataIndex = fileList(j); % feature importance comes from database features
        for kk = 1 : size(Array, 2)-1
            if(dataIndex >= Array(kk) && dataIndex < Array(kk+1))
                clusterID = kk;
                break;
            end
        end
        fprintf('Cluster ID : %d \n', clusterID);
        if(clusterID == 2)
           disp(clusterID) 
        end
        XuniqueFeature = load ([trainPath, '/uniqueFeature_Class_', num2str(clusterID), '_',  num2str(i), '.csv']);
        Ximportance = load([trainPath, '/importance_Class_', num2str(clusterID), '_',  num2str(i), '.csv']);
        Xproject = load([trainPath, '/projectMatrix_Class_', num2str(clusterID), '_',  num2str(i), '.csv']);
        XdescrRange = load([trainPath, '/descrRange_Class_', num2str(clusterID), '_',  num2str(i), '.csv']);
        
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
        
        
        p = tic;
        % XuniqueFeature,Ximportance, Xproject, XdescrRange
        % from feature in the database
        
        [Dist(i,j), remainOctave] = DistanceFrames_DAFS_DAFS_a2p2_New_Train_Paired(gss11, frame11, idm11, gss22, frame22, idm22, descr11, descr22,XuniqueFeature,Ximportance, Xproject, XdescrRange,Xamp1,Xamp2, queryTimeSeriesLength);
        
        time(j) = toc(p);
        if(i ~= j)
            remainFeatureOctave(i,:) = remainFeatureOctave(i,:) + remainOctave;
            % ttRemain(j,:) = remainOctave;
        end
    end
    % savepath = [saveFolder,'Pairedf3remainDetail',num2str(i), '.csv'];
    % savepath = [saveFolder,'Pairedf3remainDetail',num2str(i), '.csv'];
    % csvwrite(savepath, ttRemain);
    
    % savepath = [saveFolder,'PairedmatchingTime',num2str(i), '.csv'];
    savepath = [saveFolder,'PairedmatchingTime',num2str(i), '.csv'];
    csvwrite(savepath, time);
    
    remainFeatureOctave(i,:) = remainFeatureOctave(i,:)/(size(fileList, 2)-1);
    % beforePruning(i, :) = beforePruning(i, :)/(size(fileList, 2)-1);
    clear frames1 descr1 gss1 dogss1 depd idm I;
end

% resultpathDist = [saveFolder, 'PairedDist.csv'];
resultRemainFeatures = [saveFolder, 'remainFeatures.csv'];
csvwrite(resultRemainFeatures, remainFeatureOctave);

% resultpathDist = [saveFolder, 'PairedDist.csv'];
resultpathDist = [saveFolder, 'PairedDist.csv'];
csvwrite(resultpathDist, Dist);
