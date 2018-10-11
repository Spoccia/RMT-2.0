clc;
clear;

FeaturePath = 'D:\Motif_Results\Datasets\Mocap\Features_RMT/';%'/Users/sliu104/Desktop/Motif_Data/Features_RMT/';
Dset='Mocap';%'BirdSong';%'Energy';%'BirdSong';%Bird Song %'ASL';%'data';%for Mocap
DestDataPath = ['D:\Motif_Results\Datasets\SynteticDataset\',Dset,'/RandomVariate/'];%['/Users/sliu104/Desktop/Motif_Data/SynteticDataset/',Dset,'/'];

MaxVariateSize = 62; % MoCap
% MaxVariateSize = 27; % Energy
% MaxVariateSize = 13; % BirdSong

DepO = 2;
DepT = 2;
nummotifs = 3; % number of RMT features to be selected
TSConsidered = 30; % 90;%30
AllTS = randperm(184,TSConsidered); % randi([1,154],1,TSConsidered);
for numberofTS = 1 : TSConsidered
     TS_name = num2str(AllTS(numberofTS));
%     TS_name = num2str(1);
    
    savepath1 = [FeaturePath,TS_name,'/feature_',TS_name,'.mat'];
    savepath2 = [FeaturePath,TS_name,'/idm_',TS_name,'.mat'];
    savepath3 = [FeaturePath,TS_name,'/MetaData_',TS_name,'.mat'];
    load(savepath1);
    load(savepath2);
    load(savepath3);
    
    indexfeatureGroup = (frame1(6,:) == DepT & frame1(5,:) == DepO);
    X = frame1(:,indexfeatureGroup);
%     Check = sum(X(11:end,:) > eps);
%     X(:,Check <= 64) = [];
%     [rows,colmn] = size(X);
    dpscale = csvread(strcat(FeaturePath, TS_name, '/DistancesDescriptor/DepdScale_IM_', TS_name, '_DepO_', num2str(DepO), '_TimeO_', num2str(DepT),'.csv'));
%     dpscale(:,Check <= 64) = [];
     indexfeatureGroup = (X(4,:) == max(X(4,:)));
     X = X(:,indexfeatureGroup) ;
     dpscale = (dpscale(:,indexfeatureGroup));
    Features = [];
    Dependency = [];
    i = 1;
    if size(X,2) == 0
        TS_name
    end
    try
        while i <= nummotifs %& size(X,2)>nummotifs %for i=1:nummotifs
            % pick minimal size multi-variate feature
            myMax = MaxVariateSize;
            myIndex = 0;
            for kk = 1 : size(dpscale, 2)
                currentSize = nnz(dpscale(:, kk));
                if(currentSize < myMax && currentSize > 1)
                    myIndex = kk;
                    myMax = currentSize;
                end
                
            end
            myPick_Feature = X(:, myIndex);
            variates = dpscale(:, myIndex);
            
            % random = randi([1, size(X, 2)], 1, 1);
            % A = X(:, random);
            % B = dpscale(:, random);
            
            
            isokthefeature = 0;
            if(size(Dependency,2) ~= 0)
                isokthefeature = zeros(1, size(Dependency, 2));
                for actDEPD = 1 : size(Dependency, 2)
                    isokthefeature(actDEPD) = size(intersect(Dependency(Dependency(:, actDEPD) > 0, actDEPD), variates(variates(:, 1) > 0, 1)), 1); %For everithing
                    %                 %% if else for Birdsong
                    %                 if size(intersect(Dependency(Dependency(:,actDEPD)>0,actDEPD),B(B(:,1)>0,1)),1) ~= size(B(B(:,1)>0,1),1)%  size(union(Dependency(Dependency(:,actDEPD)>0,actDEPD),B(B(:,1)>0,1)),1)
                    %                     isokthefeature(actDEPD)=0;
                    %                 else
                    %                     isokthefeature(actDEPD)=1;
                    %                 end
                end
            end
            isokthefeature = sum(isokthefeature);
            if isokthefeature == 0
                Features = [Features, myPick_Feature];
                Dependency= [Dependency, variates];
                i = i+1;
            end
            index = X(1,:) == myPick_Feature(1,1);
            dpscale(:,index) =[];
            X(:,index) =[];
        end
    catch
        TS_name
    end
    
    %     if(exist([DestDataPath,'\FeaturesToInject\'],'dir')==0)
    %         mkdir([DestDataPath,'\FeaturesToInject\']);
    %     end
    if(exist([DestDataPath,'FeaturesToInject'],'dir')==0)
        mkdir([DestDataPath,'FeaturesToInject']);
    end
%     csvwrite([DestDataPath,'\FeaturesToInject\','Depd',TS_name,'.csv'],Dependency);
%     csvwrite([DestDataPath,'\FeaturesToInject\','Features',TS_name,'.csv'],Features);
    csvwrite([DestDataPath,'FeaturesToInject/','Depd',TS_name,'.csv'],Dependency);
    csvwrite([DestDataPath,'FeaturesToInject/','Features',TS_name,'.csv'],Features);
end

% save([DestDataPath,'\FeaturesToInject\allTSid.mat'],'AllTS');
save([DestDataPath,'FeaturesToInject/allTSid.mat'],'AllTS');
fprintf('Done .\n');