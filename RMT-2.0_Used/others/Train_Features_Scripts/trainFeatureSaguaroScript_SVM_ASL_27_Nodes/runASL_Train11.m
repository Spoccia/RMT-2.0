function runASL_Train11()

scriptIndex = 11;
inputRange = [951,1045]; 

dataPath = ['./data/ASL/']; 
fileList = 1: 2565;
trainPath = ['./UnionScaleASL'];
unionFeaturePath = ['./UnionScaleASL']; 
saveFolder = ['./save_ASL_DAFS_DAAAFS_Folder_', num2str(scriptIndex), '/'];
%Array = [1, 27, 51, 81, 99, 118, 149, 179, 185];
Array = [1,28,55,82,109,136,163,190,217,244,271,298,325,352,379,406,433,460,487,514,541,568,595,622,649,676,703,730,757,784,811,838,865,892,919,946,973,1000,1027,1054,1081,1108,1135,1162,1189,1216,1243,1270,1297,1324,1351,1378,1405,1432,1459,1486,1513,1540,1567,1594,1621,1648,1675,1702,1729,1756,1783,1810,1837,1864,1891,1918,1945,1972,1999,2026,2053,2080,2107,2134,2161,2188,2215,2242,2269,2296,2323,2350,2377,2404,2431,2458,2485,2512,2539,2566];

remainFeatureOctave = zeros(2565, 4);
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
        
        maxTime1 = max(frame11(2, :));
        minTime1 = min(frame11(2, :));
        maxTime2 = max(frame22(2, :));
        minTime2 = min(frame22(2, :));
        p = tic;
        % XuniqueFeature,Ximportance, Xproject, XdescrRange
        % from feature in the database
        
        [Dist(i,j), remainOctave] = DistanceFrames_DAFS_DAAAFS_a1p2_Paired(gss11, frame11, idm11, gss22, frame22, idm22, descr11, descr22,XuniqueFeature,Ximportance, Xproject, XdescrRange,Xamp1,Xamp2);
        
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
