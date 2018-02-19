close all;
clc;
clear;

DatasetInject=2;  % 1 Energy 2 Mocap

SubDSPath='data\';%'FlatTS_MultiFeatureDiffClusters\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
datasetPath= 'D:\Motif_Results\Datasets\SynteticDataset\';
subfolderPath= '';%'Z_A_Temp_C\';%
FeaturesRM ='RMT';

% Flag to abilitate portions of code
CreateRelation = 0;%1;
FeatureExtractionFlag = 0;%1;% 1; % 1 do it others  skip
createDependencyScale = 0;%1;
Cluster = 0;%1;%
CreateSubCluster=0;

motifidentificationBP_MatlabDescr = 0;%1

% pruneCluster = 0;
pruneClusterDescrMatlab = 1;%0


savecaracteristics = 1;
showOriginalImage = 0;

%% Parameters 
Num_SyntSeries=1; % num of instances of one motif
Name_OriginalSeries = [35,85,127,24]; % name of the original  series from with we  got the  motif instances to inject
%% Parameter for kmeans: distance measure to use
kmeans_Descmetric='euclidean';%'cosine';%'cityblock';%
distanceUsed='Descriptor';% use just descriptors to  cluster
prunewith='Descriptor';% use this strategy to prune  the outbound features ina  cluster
kindOfClustring= 'Akmeans'; % the algorithm of clustering to use
    %% sift parameters
    % x - variate
    % y - time
    % oframes - octaves
    % sigmad - sigma dependency (variate)
    % sigmat - sigma time (time)
    % pricur - principle curvature
    USER_OT_targhet=2;
    USER_OD_targhet=2;
    
    DeOctTime = USER_OT_targhet;
    DeOctDepd = USER_OD_targhet;
    DeLevelTime = 4;%6;
    DeLevelDepd = 4;%6;
    DeSigmaDepd = 0.4;%
    DeSigmaTime = 1.6*2^(1/DeLevelTime);%
    DeGaussianThres = 0.1;%
    if DatasetInject == 1 % Energy Building
        DeSigmaDepd = 0.5;%0.6;%0.5;%0.4;%
        DeSigmaTime = 1.6*2^(1/DeLevelTime);%4*sqrt(2);%1.6*2^(1/DeLevelTime);%4*sqrt(2);%2*1.6*2^(1/DeLevelTime);%  8;%4*sqrt(2);%1.2*2^(1/DeLevelTime);%
        DeGaussianThres = 0.2;%0.3;%0.1;%0.4;%1;%0.6;%2;%6; % TRESHOLD with the normalization of hte distance matrix should be  between 0 and 1
    elseif DatasetInject == 2 % MoCap
        DeSigmaDepd = 0.5;%1.6*2^(1/(DeLevelTime));%0.3;%0.4;%0.6;%0.5;%0.4;%
        DeSigmaTime = 4*sqrt(2)/2;%    
        DeGaussianThres = 0.1;%
    end
    thresh = 0.04 / DeLevelTime / 2 ;%0.04;%
    DeSpatialBins = 4; %NUMBER OF BINs
    r= 10; %5 threshould variates


for pip=1:1
    for NAME = 1:Num_SyntSeries
        Time4Clustering=zeros(1,4);
        TIMEFOROCTAVE=zeros(1,4);
        TimeComputationDepdScale = zeros(1,4);
        TimeforPruningClustering =zeros(1,4);
        TimeforPruningSubClustering=zeros(1,4);
        TEST = ['Energy_test',num2str(NAME)];
        if DatasetInject == 2 % MoCap
        %       TEST=['Mocap_test',num2str(NAME)]%'Mocap_test11';
        %         TEST=['MoCap',num2str(NAME)]
         TEST=['Motif1_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME)] 

        %       TEST=['MotifShift1_2_instance_',num2str(NAME)]

        %         TEST=['Motif_15_1_',num2str(pippo(pip)),'_instance_',num2str(NAME)] %'35','_instance_',num2str(NAME)]%85  
        %   TEST=['100_Motif_10_1_',num2str(pippo(pip)),'_instance_',num2str(NAME)]
        end
        
        %% read location matrix
        TS_name=TEST;
        distanceVaraiteTS=[datasetPath,'HopMatrix_multistory_aggregate.csv'];%'HopMatrix_multistory.csv'];
        if DatasetInject == 2 % MoCap
            distanceVaraiteTS=[datasetPath,'LocationMatrixMocap.csv'];%
        end
        % read coordinates
        coordinates=csvread(strcat(datasetPath,'location\LocationSensor_aggregate.csv'));
        if DatasetInject == 2 % MoCap
            coordinates=csvread(strcat(datasetPath,'location\LocationMatrixMocap.csv'));%
        end
        RELATION=coordinates;
        
        data = csvread([datasetPath,SubDSPath,TS_name,'.csv']);%double(imread([imagepath,specificimagepath,imagename,'.jpg']));%

        %% Features Extraction
        if(FeatureExtractionFlag==1) 
            saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\',EntropyPruningFolder];
            if(exist(saveFeaturesPath,'dir')==0)
                mkdir(saveFeaturesPath);
                mkdir([saveFeaturesPath,'GaussianSmoothing\']);
            end
            sBoundary=1;
            eBoundary=size(data',1);
            frames1=[];
            descr1=[];
            gss1=[];
            dogss1=[];
            depd1=[];
            idm1=[];
            time=[];
            timee=[];
            timeDescr=[];
            if(strcmp(FeaturesRM,'RMT')) % we can add other  features methods
                [frames1,descr1,gss1,dogss1,depd1,idm1, time, timee, timeDescr] = sift_gaussianSmooth_Silv(data',RELATION, DeOctTime, DeOctDepd,...
                                                                                                           DeLevelTime, DeLevelDepd, DeSigmaTime ,DeSigmaDepd,...
                                                                                                           DeSpatialBins, DeGaussianThres, r, sBoundary, eBoundary);
            end
            while(size(frames1,2)==0)
                frames1 = zeros(4,1);
                descr2 = zeros(128,1);
            end
            frame1 = [frames1;descr1];
            if( isnan(sum(descr1(:))))
                TS_name
                nanIDX=  isnan(sum(descr1));
                frame1(:,nanIDX)  = [];
                descr1(:,nanIDX)  = [];
                frames1(:,nanIDX) = [];
            end
            frame1(7,:) = [];
            feature = frame1;
            TIMEFOROCTAVE=time;
            savepath1 = [saveFeaturesPath,'feature_',TS_name,'.mat'];
            savepath2 = [saveFeaturesPath,'idm_',TS_name,'.mat'];
            savepath3 = [saveFeaturesPath,'MetaData_',TS_name,'.mat'];
            savepath5 = [saveFeaturesPath,'GaussianSmoothing/DepdMatrix_',TS_name,'.mat'];

            savepath6 = [saveFeaturesPath,'/ComparisonTime_',TS_name,'.csv'];
            savepath7 = [saveFeaturesPath,'/ScaleTime_',TS_name,'.csv'];
            savepath8 = [saveFeaturesPath,'/DescrTime_',TS_name,'.csv'];

            save(savepath1,'data', 'gss1', 'frame1','depd1');
            save(savepath2,'idm1');
            save(savepath3,'DeOctTime', 'DeOctDepd', 'DeSigmaTime','DeSigmaDepd', 'DeLevelTime','DeLevelDepd', 'DeGaussianThres', 'DeSpatialBins', 'r', 'descr1' );
            save(savepath5, 'depd1');
        end
    end
end