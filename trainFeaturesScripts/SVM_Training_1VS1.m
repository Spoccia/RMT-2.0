clear;
clc;

%% Input variable
% featureFolder      = Folder that contains the features
% dataFolder         = Folder that contains the data
% destFolder         = Destination where to save trained SVM model
% SelectDataset      = 1 full scale  change the descriptor start end position
%                      2 for all the others
% startDescr         = location where the descriptor start
% endDescr           = location where the descriptor ends
% dataSize           = number of timeseries in the dataset 
% trainingPercentage = what percentage of data we should use to train the SVM
% ClassIndexes       = Start and End index for eleents of each class



fileList = 1: 184;

featureFolder = ['D:\Mocap _ RMT2\Features Octave 3\Features 3 octave  SD 0_5 ST 2_8'];
dataFolder = ['D:\Mocap _ RMT2\data'];
destFolder = ['D:\Mocap _ RMT2\Features Octave 3\Features 3 octave  SD 0_5 ST 2_8\LinearSVMTrained\'];


SelectDataset= 1; % 1 means full scale ; 2 means hybrid or fix scale
startDescr =8;
endDescr = 135;
%saveFolder = '.';
dataSize = 184;
trainingPercentage = 1;%0.6; 
% OBSERVATION: take 60% require to do multiple test  using the remaning 40%  to understand what is the best set to use for the query.


if(SelectDataset ==1)
    startDescr =11;
    endDescr = 138;
end

% MoCap data Class
ClassIndexes = [1, 15, 51, 81, 99, 118, 149, 179, 185];

% read all the features
AllFeatures = cell(dataSize, 1);
ProcessedAllFeatures = cell(dataSize, 1);
timeSeriesLength =zeros(1,dataSize);
for i = 1 : dataSize
    featurePath = [featureFolder,'/feature_',num2str(i),'.mat'];
    AllFeatures{i} = load(featurePath); % feature is frame1 from cell structure
    dataPath = [dataFolder, '/', num2str(i), '.csv'];
    data = csvread(dataPath);
    timeSeriesLength(1,i) = size(data, 1);
end

labels =1:size(ClassIndexes,2)-1;
for queryID =1:184
    % Select index of the elements in each class
    training_Sets=[];
    for clusterID =1:8
        training_Sets{clusterID} = randomizeSet(queryID,ClassIndexes(clusterID),ClassIndexes(clusterID+1)-1, trainingPercentage );
    end
    for clusterID = 1:size(ClassIndexes,2)-1;
        'training query class' 
        %trainingIDX = randomizeSet(queryID,ClassIndexes(clusterID),ClassIndexes(clusterID+1)-1, trainingPercentage );
        trainingIDX  = [];
        ClassificationIDX= [];
        AllFeaturesClass =[];
        goodlabel=1;
        badLabel=2:8;
        badidx=1;
        for i = 1: size(ClassIndexes, 2)-1
            if(i == clusterID) % my class
                trainingIDX = [trainingIDX,training_Sets{i}];
                AllFeaturesIN =[];
                for j =1 : size(training_Sets{i},2)
                    AllFeaturesIN = [AllFeaturesIN,AllFeatures{training_Sets{i}(j)}.frame1];
                end
                AllFeaturesClass =[AllFeaturesClass,AllFeaturesIN];
                ClassificationIDX= [ClassificationIDX;ones(size(AllFeaturesIN,2),1)*1];
            else % other class
                trainingIDX=[trainingIDX,training_Sets{i}];%[trainingSetIrrelevant,randomizeSet(queryID,Array(i),Array(i+1)-1, 0.6 )];
                AllFeaturesNO =[];
                for j =1 : size(training_Sets{i},2)
                    AllFeaturesNO = [AllFeaturesNO,AllFeatures{training_Sets{i}(j)}.frame1];
                end
                AllFeaturesClass =[AllFeaturesClass,AllFeaturesNO];
                ClassificationIDX= [ClassificationIDX;ones(size(AllFeaturesNO,2),1)*badLabel(badidx)];
                badidx=badidx+1;
            end
        end
        
    

        for OT =1: 3
            for OD = 1:3
                for Vsclass =2 : 8
                index_Of_Octave= (AllFeaturesClass(5,:)==OD & AllFeaturesClass(6,:)==OT );
                OctaveClassification=ClassificationIDX(index_Of_Octave,1);
                OctaveFeatures = AllFeaturesClass(:,index_Of_Octave);
                VSClassIDX = (OctaveClassification==1 | OctaveClassification==Vsclass)
                OctaveClassification=OctaveClassification(VSClassIDX,1);
                OctaveFeatures = OctaveFeatures(:,VSClassIDX);
                % liblinear SVM function
                Training_instance_matrix = OctaveFeatures(startDescr:endDescr,:)';
                Training_instance_matrix = sparse(Training_instance_matrix);
                
                model = train(OctaveClassification, Training_instance_matrix, '-s 5');

                
                % Xilun Suggested function
                % Mdl = fitcecoc(OctaveFeatures(startDescr:endDescr,:)',OctaveClassification);
                % From my reading  this should be fine
                % SVMModel = fitcsvm(X,Y,'KernelFunction','linear','Standardize',true,'ClassNames',{'1','2'});
 %              % Mdl = fitcecoc(OctaveFeatures(startDescr:endDescr,:)',OctaveClassification);
                % From my reading  this should be fine
                % SVMModel = fitcsvm(OctaveFeatures(startDescr:endDescr,:)',OctaveClassification,'KernelFunction','rbf','Standardize',true,'ClassNames',{'1','2'});

%                 CVSVMModel = crossval(SVMModel);
%                 [~,scorePred] = kfoldPredict(CVSVMModel);
%                 outlierRate = mean(scorePred<0);
                if(exist(strcat(destFolder,num2str(queryID),'\'),'dir')==0)
                    mkdir(strcat(destFolder,num2str(queryID),'\'));
                end
               
                % save([destFolder,num2str(queryID),'\','Class_',num2str(clusterID),'_OD_',num2str(OD),'_OT_',num2str(OT),'.mat'],'Mdl');
                save([destFolder,num2str(queryID),'\','Class_',num2str(clusterID),'VS',num2str(Vsclass),'_OD_',num2str(OD),'_OT_',num2str(OT),'.mat'],'model');
                % save([destFolder,num2str(queryID),'\','Class_',num2str(clusterID),'_OD_',num2str(OD),'_OT_',num2str(OT),'.mat'],'SVMModel');
                end
            end
        end
        
    end
end
