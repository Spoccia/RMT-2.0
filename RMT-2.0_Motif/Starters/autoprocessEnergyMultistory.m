close all;
clc;
clear;

SubDSPath='data\';%'FlatTS_MultiFeatureDiffClusters\';%'CosineTS_MultiFeatureDiffClusters\';%'MultiFeatureDiffClusters\';
datasetPath= 'D:\Motif_Results\Datasets\Building_MultiStory\';
subfolderPath= '';%'Z_A_Temp_C\';%
FeaturesRM ='RMT';%'RME';%

normalizeData=0;

% Flag to abilitate portions of code
CreateRelation = 0;%1;
FeatureExtractionFlag = 0;%1;% 1; % 1 do it others  skip
createDependencyScale = 1;%1;
Cluster = 0;%1;%
CreateSubCluster=0;

motifidentificationBP_MatlabDescr = 0;%1
pruneClusterDescrMatlab = 0;%1;%0

motifidentificationBP = 0; %2;% work on all the features
pruneCluster = 0;

motifidentification = 0; % work on pruned features
savecaracteristics = 1;
showOriginalImage = 0;
mapdataintograyscale = 1;
saveTSasImage = 1;

% To report the  center variate to the right one in hte index
PruningEntropy = 0;%1;%
ShiftFeatures = 0;


% Path Parameters
TEST ='1';%

% Global Variables
SizeFeaturesforImages = [];

% FixCluster Experiment
FT1=[20,20,20,20];%[30,30,30,20];%10];%[5,5,5,5];%[3,3,3,3];%
ThresholdCluster =[0.05,0.05,0.05,0.05];%[0.1,0.2,0.1,0.2];
KmeansDescmetric='euclidean';%'cosine';%'cityblock';%
KmedoidsCoefTerm =0.005;% 0.5;

% kind of distance
typeofCluster='Cluster_AKmeans';%'ClusterMatlab';%'ClusterKmedoids';%
prunewith='Descriptor';%'Amplitude_Descriptor';%'Amplitude_Descriptor_overlapping'%
distanceUsed='Descriptor';%'Amplitude_Descriptor';%
SizeofK= 'Akmeans';%'Fixed';%'Threshould';% 'Computed';%'Fixed_K15';%
K_valuesCalc=SizeofK;
 EntropyPruningFolder='';
if(strcmp(FeaturesRM,'RME')& PruningEntropy==1)
    EntropyPruningFolder='AllFeatures\';
end
KindofFeatures= 0; % 1 for DoG 0 for DoE


for TSnumber = 1:10%183: 709
    TEST =num2str(TSnumber); %'1';%
    TS_name=num2str(TSnumber);%
    distanceVaraiteTS=[datasetPath,'HopMatrix_multistory_aggregate.csv'];%'HopMatrix_multistory.csv'];
    
    
    %% sift parameters
    % x - variate
    % y - time
    % oframes - octaves
    % sigmad - sigma dependency (variate)
    % sigmat - sigma time (time)
    % pricur - principle curvature
    DeOctTime = 2;
    DeOctDepd = 2;
    DeLevelTime = 4;%6;
    DeLevelDepd = 4;%6;
    DeSigmaDepd = 0.5;%0.6;%0.5;%0.3;%
    DeSigmaTime = 1.6*2^(1/DeLevelTime)*2;%4*sqrt(2);%1.6*2^(1/DeLevelTime);%4*sqrt(2);%2*1.6*2^(1/DeLevelTime);%  8;%4*sqrt(2);%1.2*2^(1/DeLevelTime);%
    thresh = 0.04 / DeLevelTime / 2 ;%0.04;%
    DeGaussianThres = 0.3;%0.1;%0.4;%1;%0.6;%2;%6; % TRESHOLD with the normalization of hte distance matrix should be  between 0 and 1
    DeSpatialBins = 4; %NUMBER OF BINs
    r= 10; %5 threshould variates
    
    %%  inside cluster paramenters
    DictionarySize=FT1;%
    data = csvread([datasetPath,SubDSPath,TS_name,'.csv']);%double(imread([imagepath,specificimagepath,imagename,'.jpg']));%
    data1=data;
    if(normalizeData == 1)
        [Nrows,Ncols]= size(data);
        minvariate= min(data');
        maxvariate=max(data');
        for i=1:Nrows
            data1(i,:)= (data(i,:)-minvariate(i))/(maxvariate(i)-minvariate(i));
        end
        data=data1;
    end
    
    
    if (showOriginalImage==1)
        figure
        TSasImageShow(data);
        %imshow(uint8(data));
    end
    
    histTSImage=[];
    if(mapdataintograyscale==1)
        % create a histogram of the original image => data
        manip_f = data - min(data(:));
        % normalize 0-1
        manip_f = manip_f/(max(data(:))-min(data(:)));
        %normalize 0-255
        manip2_f = manip_f*255;
        histTSImage= manip2_f;
        % imshow(uint8(manip2_f));
    end
    if (saveTSasImage==1)
        if(exist([datasetPath,subfolderPath,'TS_as_Image\'],'dir')==0)
            mkdir([datasetPath,subfolderPath,'TS_as_Image\']);
        end
        imwrite(uint8(histTSImage),[datasetPath,subfolderPath,'TS_as_Image\',TS_name,'.jpg'])
        csvwrite([datasetPath,subfolderPath,'TS_as_Image\',TS_name,'.csv'],histTSImage);
    end
    if CreateRelation==1
        [row,col]= size(data);
        rel_reord = csvread(distanceVaraiteTS);
        maxim = max(rel_reord(:));
        minim = min(rel_reord(:));
        normdist= (rel_reord - minim) /abs(maxim-minim);
        
        % normal coordinate in the space from D:
        M=zeros(row);
        M_notnorm=zeros(row);
        for i=1:row
            for j=1:row
                M(i,j)= (normdist(1,j)^2+normdist(i,1)^2-normdist(i,j)^2)/2;
                M_notnorm(i,j)= (rel_reord(1,j)^2+rel_reord(i,1)^2-rel_reord(i,j)^2)/2;
            end
        end
        rank(M);
        rank(M_notnorm);
        [U,s,V]=eig(M);
        [U1,s1,V1]=eig(M_notnorm);
        X_Coordinate = U*(s^1/2);
        X_Coordinate_NN = U1*(s1^1/2);
        csvwrite(strcat(datasetPath,'norm_Dist_aggregate.csv'),normdist);
        csvwrite(strcat(datasetPath,'LocationSensor_aggregate.csv'),X_Coordinate);
        csvwrite(strcat(datasetPath,'LocationSensor_NN_aggregate.csv'),X_Coordinate_NN);
    end
    
    coordinates=csvread(strcat(datasetPath,'location\LocationSensor_aggregate.csv'));%'LocationSensor_NN.csv'));%csvread(strcat(datasetPath,'LocationSensor.csv'));
    
    RELATION=coordinates;
    
    
    % Features Extraction
    if(FeatureExtractionFlag==1)
        % * test_Diag.m - DIAG Scale feature extraction and matching process
        % * test_Full.m - FULL Scale feature extraction and matching process
        % * test_Hyb.m - HYB Scale feature extraction and matching process
        % + After getting Diag and Full scale features, execute saveUnionFeatures.m to generate union features;
        saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\'];
        if(exist([datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\'],'dir')==0)
            mkdir([datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\']);
            mkdir([datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\','GaussianSmoothing\']);
        end
        %saveFeaturesPath=[datasetPath,subfolderPath,'Features\',TEST,'\'];
        
        % Test Full
        
        sBoundary=1;
        eBoundary=size(data',1);
        %           [frames1,descr1,orient1,gss1,dogss1,depd1,idm1, time, timee, timeDescr] = sift_gaussianSmooth_orientation(data',RELATION, DeOctTime, DeOctDepd,...
        %                                                                                DeLevelTime, DeLevelDepd, DeSigmaTime ,DeSigmaDepd,...
        %                                                                                DeSpatialBins, DeGaussianThres, r, sBoundary, eBoundary);
        frames1=[];
        descr1=[];
        gss1=[];
        dogss1=[];
        depd1=[];
        idm1=[];
        time=[];
        timee=[];
        timeDescr=[];
        
        if(strcmp(FeaturesRM,'RMT'))
            %             [frames1,descr1,gss1,dogss1,depd1,idm1, time, timee, timeDescr] = sift_gaussianSmooth(data',RELATION, DeOctTime, DeOctDepd,...
            %                                                                                    DeLevelTime, DeLevelDepd, DeSigmaTime ,DeSigmaDepd,...
            %                                                                                    DeSpatialBins, DeGaussianThres, r, sBoundary, eBoundary);
            [frames1,descr1,gss1,dogss1,depd1,idm1, time, timee, timeDescr] = sift_gaussianSmooth_Silv(data',RELATION, DeOctTime, DeOctDepd,...
                DeLevelTime, DeLevelDepd, DeSigmaTime ,DeSigmaDepd,...
                DeSpatialBins, DeGaussianThres, r, sBoundary, eBoundary);
        elseif(strcmp(FeaturesRM,'RME'))
            [frames1,descr1,gss1,dogss1,depd1,idm1, time, timee, timeDescr] = sift_gaussianSmooth_entropy(data',RELATION, DeOctTime, DeOctDepd,...
                DeLevelTime, DeLevelDepd, DeSigmaTime ,DeSigmaDepd,...
                DeSpatialBins, DeGaussianThres, r, sBoundary, eBoundary);%
        end
        %         [frames1,descr1,gss1,dogss1,depd1,idm1, time, timee, timeDescr] = sift_gaussianSmooth(data',RELATION, DeOctTime, DeOctDepd,...
        %                                                                                DeLevelTime, DeLevelDepd, DeSigmaTime ,DeSigmaDepd,...
        %                                                                                DeSpatialBins, DeGaussianThres, r, sBoundary, eBoundary);
        
        %         [frames1,descr1,gss1,dogss1,depd1,idm1, time, timee, timeDescr] = sift_gaussianSmooth_entropy(data',RELATION, DeOctTime, DeOctDepd,...
        %                                                                                  DeLevelTime, DeLevelDepd, DeSigmaTime ,DeSigmaDepd,...
        %                                                                                  DeSpatialBins, DeGaussianThres, r, sBoundary, eBoundary);%
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
        % Silv offset features
% %         frame1 = shiftFeatures(frame1,1);
        % end
        % remove descriptors near 0
        %             Parse= sum((frame1(11:138,:)~=0))<64;
        %             X1 = frame1(:,Parse==0);
        %             frame1 =X1;
        %
        feature = frame1;
        
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
       if(ShiftFeatures==1)
        saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TEST,'\'];
        
        savepath1 = [saveFeaturesPath,'feature_',TS_name,'.mat'];
        savepath2 = [saveFeaturesPath,'idm_',TS_name,'.mat'];
        savepath3 = [saveFeaturesPath,'MetaData_',TS_name,'.mat'];
        load(savepath1);
        load(savepath2);
        load(savepath3);
        f=  frame1(:,:);
        frame1 = shiftFeatures(frame1,1);
        save(savepath1,'data', 'gss1', 'frame1','depd1');
    end
    
    if(createDependencyScale==1)
        saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TEST,'\'];
        
        savepath1 = [saveFeaturesPath,EntropyPruningFolder,'feature_',TS_name,'.mat'];
        savepath2 = [saveFeaturesPath,EntropyPruningFolder,'idm_',TS_name,'.mat'];
        savepath3 = [saveFeaturesPath,EntropyPruningFolder,'MetaData_',TS_name,'.mat'];
        load(savepath1);
        load(savepath2);
        load(savepath3);
        
        for k=1:DeOctTime
            for j=1:DeOctDepd
                indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);
                X=frame1(:,indexfeatureGroup);
                % save dependency of each feature
                [depdScale1] = computeDepdScale(X, gss1, idm1);
                if(exist(strcat(saveFeaturesPath,EntropyPruningFolder,'Distances',distanceUsed,'\'),'dir')==0)
                    mkdir(strcat(saveFeaturesPath,EntropyPruningFolder,'Distances',distanceUsed,'\'));
                end
                csvwrite(strcat(saveFeaturesPath,EntropyPruningFolder,'Distances',distanceUsed,'\DepdScale_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),depdScale1);
            end
        end
    end
    
    % PruningEntropy
    if (PruningEntropy==1)
        % execute K-means Cluster k = DictionarySize;
        % A Dictionary for each cluster
        saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TEST,'\'];
        
        savepath1 = [saveFeaturesPath,EntropyPruningFolder,'feature_',TS_name,'.mat'];
        savepath2 = [saveFeaturesPath,EntropyPruningFolder,'idm_',TS_name,'.mat'];
        savepath3 = [saveFeaturesPath,EntropyPruningFolder,'MetaData_',TS_name,'.mat'];
        load(savepath1);
        load(savepath2);
        load(savepath3);
        
        clustindfix=0;
        NewFeatures=[];
        for k=1:DeOctTime
            for j=1:DeOctDepd
                clustindfix=clustindfix+1;
                indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);
                X=frame1(:,indexfeatureGroup);
                A=X;
                
                NewDependency=[];
                if(abs(size(X,2))>0)
                    dpscale = csvread(strcat(saveFeaturesPath,EntropyPruningFolder,'Distances',distanceUsed,'\DepdScale_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));
                    
                    % Remove feature withentropy  near to 0
                    EntropyTHR=0.01;
                    [A,dpscale] = pruningEntropyThresh(A,dpscale,EntropyTHR,data);
                    
                    % pruningOverlapping features using and of overlapping
                    overTime=0.7;
                    overDep =1;
                    criteria =3;
                    %                   [A,dpscale]=pruneOverlappingFeaturesTimeandDep(A,dpscale,overTime,overDep,data);
                    %                   [A,dpscale]=pruneOverlappingFeaturesTimeandDepEntropy(A,dpscale,overTime,overDep,data);
                    %                   [A,dpscale]=PruningOverlappingFeaturesSize(A,dpscale,overTime,overDep,data);
                    [A,dpscale] = Pre_PruningOverlappingFeaturesCombined(A,dpscale,overTime,overDep,data,criteria);
                    
                    if(exist(strcat(saveFeaturesPath,'Distances',distanceUsed,'\FeaturesPruned\'),'dir')==0)
                        mkdir(strcat(saveFeaturesPath,'Distances',distanceUsed,'\FeaturesPruned\'));
                    end
                    csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\FeaturesPruned\Features_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),A);%Matlab_
                    csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\FeaturesPruned\DepdScale_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),dpscale);%Matlab_
                    NewFeatures=[NewFeatures,A];
                    NewDependency= [NewDependency,dpscale];
                    %                     [C,mu] = kmeans(A(11:size(X,1),:)',5,'Distance','cosine');
                    %                     csvwrite(strcat(saveFeaturesPath,'DistancesDescriptors\FeaturesPruned\Cluster_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),C);%Matlab_
                    %                     csvwrite(strcat(saveFeaturesPath,'DistancesDescriptors\\FeaturesPruned\Centroids_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),mu);%Matlab_
                end
            end
        end
        frame1=NewFeatures;
        if(exist([datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\','GaussianSmoothing\'],'dir')==0)
            mkdir([datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\']);
            mkdir([datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\','GaussianSmoothing\']);
        end
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
        save(strcat(saveFeaturesPath,'Distances',distanceUsed,'\FeaturesPruned\','feature_',TS_name,'.mat'),'data', 'gss1', 'frame1','depd1');
        
            if(createDependencyScale==1)
                saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TEST,'\'];

                savepath1 = [saveFeaturesPath,'feature_',TS_name,'.mat'];
                savepath2 = [saveFeaturesPath,'idm_',TS_name,'.mat'];
                savepath3 = [saveFeaturesPath,'MetaData_',TS_name,'.mat'];
                load(savepath1);
                load(savepath2);
                load(savepath3);

                for k=1:DeOctTime
                    for j=1:DeOctDepd
                        indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);
                        X=frame1(:,indexfeatureGroup);
                        % save dependency of each feature
                        [depdScale1] = computeDepdScale(X, gss1, idm1);
                        if(exist(strcat(saveFeaturesPath,'Distances',distanceUsed,'\'),'dir')==0)
                            mkdir(strcat(saveFeaturesPath,'Distances',distanceUsed,'\'));
                        end
                        csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\DepdScale_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),depdScale1);
                    end
                end
            end
    end
    
    % Clustering
    if (Cluster==1)
        % execute K-means Cluster k = DictionarySize;
        % A Dictionary for each cluster
        saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\'];
        
        savepath1 = [saveFeaturesPath,'feature_',TS_name,'.mat'];
        savepath2 = [saveFeaturesPath,'idm_',TS_name,'.mat'];
        savepath3 = [saveFeaturesPath,'MetaData_',TS_name,'.mat'];
        load(savepath1);
        load(savepath2);
        load(savepath3);
        
        clustindfix=0;
        for k=1:DeOctTime
            for j=1:DeOctDepd
                clustindfix=clustindfix+1;
                indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);
                X=frame1(:,indexfeatureGroup);
                
                DictionarySizeApplied=0;
                if(strcmp(SizeofK,'Computed')==1)
                    DictionarySizeApplied= floor(abs(size(X,2))/10);
                    if(DictionarySizeApplied == 0)
                        DictionarySizeApplied=1;
                    end
                elseif(strcmp(SizeofK,'Fixed')==1)
                    DictionarySizeApplied = DictionarySize(clustindfix);
                end
                
                        'Cluster on Descriptors'
                    if(strcmp(typeofCluster,'ClusterKmedoid')==1)
                            [C,mu] = cvKmeans (X, DictionarySizeApplied,KmedoidsCoefTerm ,'@Distance_RMT_DESC',false,data,gss1,idm1,KmeansDescmetric);
                    elseif(strcmp(typeofCluster,'ClusterMatlab')==1)
                            [C,mu] = kmeans(X(11:size(X,1),:)',DictionarySizeApplied,'Distance','sqeuclidean');%);%'cosine');%
                    elseif(strcmp(typeofCluster,'Cluster_AKmeans')==1)
                       [C,mu,inertia,tryK,startK]= adaptiveKmeans(X,3,0.003,0,'sqeuclidean');%'cosine');%4th parameter will fix the step to 2 as default
                        if(exist(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\'),'dir')==0)
                            mkdir(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\'));
                        end
                        csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\Cl_behavior_IM_',TS_name,'_DO_',num2str(j),'_TO_',num2str(k),'.csv'),[inertia',tryK']);%Matlab_    
                    end
                    if(exist(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\'),'dir')==0)
                        mkdir(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\'));
                    end
                    csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\Cluster_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),C);%Matlab_
                    csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\Centroids_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),mu);%Matlab_
            end
        end
    end
    
    % threshould clustering
    if(Cluster==2)
        NumofCluster=10;
        saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\'];
        savepath1 = [saveFeaturesPath,'feature_',TS_name,'.mat'];
        savepath2 = [saveFeaturesPath,'idm_',TS_name,'.mat'];
        savepath3 = [saveFeaturesPath,'MetaData_',TS_name,'.mat'];
        
        load(savepath1);
        load(savepath2);
        load(savepath3);
        clustindfix=0;
        for k=1:DeOctTime
            for j=1:DeOctDepd
                clustindfix=clustindfix+1;
                indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);
                X=frame1(:,indexfeatureGroup);
                descr = X(11:size(frame1,1),:);
                [featsize,numfeatures]= size(X);
                DescrDist = pdist2(descr',descr',KmeansDescmetric)/2;
                dpscale = csvread(strcat(saveFeaturesPath,'Distances',distanceUsed,'\DepdScale_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));

                [centroids,Clusterfeatures,ClusterSymbols,ClusterDep] = clusteronInportance(X,DescrDist,dpscale,0.05,NumofCluster);%ThresholdCluster(clustindfix),NumofCluster);
                mkdir(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\',distanceUsed,'\ClusterThrehold\'));
                csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\',distanceUsed,'\ClusterThrehold\Cluster_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),ClusterSymbols);
                csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\',distanceUsed,'\ClusterThrehold\Centroids_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),centroids);
                csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\',distanceUsed,'\ClusterThrehold\Cluster_Features_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),Clusterfeatures);
                csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\',distanceUsed,'\ClusterThrehold\Cluster_Dep_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),ClusterDep);
                
                
            end
        end
        ShowThresholdCluster(TS_name,datasetPath,subfolderPath,TS_name,K_valuesCalc,distanceUsed,'ClusterThrehold',histTSImage,FeaturesRM);
    end
    
    if (CreateSubCluster==1)
        saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\'];
        depdOverLapThreshold = 1;
        subCluster_Varaites(saveFeaturesPath,TS_name,K_valuesCalc,distanceUsed,typeofCluster,depdOverLapThreshold);
        
    end
    
    if(motifidentificationBP_MatlabDescr ==1)
        ShowKmeansCluster(TS_name,datasetPath,subfolderPath,TS_name,K_valuesCalc,distanceUsed,typeofCluster,histTSImage,FeaturesRM,0);%1);
        ShowVaraiteallineadCluster(TS_name,datasetPath,subfolderPath,TS_name,K_valuesCalc,distanceUsed,typeofCluster,histTSImage,FeaturesRM,0);%1);
    end
    
    % Prune the clusters
    if(pruneClusterDescrMatlab==1)
        TimeforPruningClustering = KmeansPruning(TS_name,datasetPath,subfolderPath,TS_name,typeofCluster,K_valuesCalc,prunewith,distanceUsed ,DictionarySize,histTSImage,FeaturesRM,1);%1);
        TimeforPruningSubClustering = VariateAllinedKmeansPruning(TS_name,datasetPath,subfolderPath,TS_name,typeofCluster,K_valuesCalc,prunewith,distanceUsed ,DictionarySize,histTSImage,FeaturesRM,1);%1);
    end    
%     if(ShiftFeatures==1)
%         saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TEST,'\'];
%         
%         savepath1 = [saveFeaturesPath,'feature_',TS_name,'.mat'];
%         savepath2 = [saveFeaturesPath,'idm_',TS_name,'.mat'];
%         savepath3 = [saveFeaturesPath,'MetaData_',TS_name,'.mat'];
%         load(savepath1);
%         load(savepath2);
%         load(savepath3);
%         f=  frame1(:,:);
%         frame1 = shiftFeatures(frame1,1);
%         save(savepath1,'data', 'gss1', 'frame1','depd1');
%     end
%     
%     if(createDependencyScale==1)
%         saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TEST,'\'];
%         
%         savepath1 = [saveFeaturesPath,'feature_',TS_name,'.mat'];
%         savepath2 = [saveFeaturesPath,'idm_',TS_name,'.mat'];
%         savepath3 = [saveFeaturesPath,'MetaData_',TS_name,'.mat'];
%         load(savepath1);
%         load(savepath2);
%         load(savepath3);
%         
%         for k=1:DeOctTime
%             for j=1:DeOctDepd
%                 indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);
%                 X=frame1(:,indexfeatureGroup);
%                 % save dependency of each feature
%                 [depdScale1] = computeDepdScale(X, gss1, idm1);
%                 if(exist(strcat(saveFeaturesPath,'Distances',distanceUsed,'\'),'dir')==0)
%                     mkdir(strcat(saveFeaturesPath,'Distances',distanceUsed,'\'));
%                 end
%                 csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\DepdScale_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),depdScale1);
%             end
%         end
%     end
%     
%     % PruningEntropy
%     if (PruningEntropy==1)
%         % execute K-means Cluster k = DictionarySize;
%         % A Dictionary for each cluster
%         saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TEST,'\'];
%         
%         savepath1 = [saveFeaturesPath,'feature_',TS_name,'.mat'];
%         savepath2 = [saveFeaturesPath,'idm_',TS_name,'.mat'];
%         savepath3 = [saveFeaturesPath,'MetaData_',TS_name,'.mat'];
%         load(savepath1);
%         load(savepath2);
%         load(savepath3);
%         
%         clustindfix=0;
%         NewFeatures=[];
%         for k=1:DeOctTime
%             for j=1:DeOctDepd
%                 clustindfix=clustindfix+1;
%                 indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);
%                 X=frame1(:,indexfeatureGroup);
%                 A=X;
%                 
%                 NewDependency=[];
%                 if(abs(size(X,2))>0)
%                     dpscale = csvread(strcat(saveFeaturesPath,'Distances',distanceUsed,'\DepdScale_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));
%                     
%                     % Remove feature withentropy  near to 0
%                     EntropyTHR=0.01;
%                     [A,dpscale] = pruningEntropyThresh(A,dpscale,EntropyTHR,data);
%                     
%                     % pruningOverlapping features using and of overlapping
%                     overTime=0.8;
%                     overDep =0.8;
%                     criteria =3;
%                     %                   [A,dpscale]=pruneOverlappingFeaturesTimeandDep(A,dpscale,overTime,overDep,data);
%                     %                   [A,dpscale]=pruneOverlappingFeaturesTimeandDepEntropy(A,dpscale,overTime,overDep,data);
%                     %                   [A,dpscale]=PruningOverlappingFeaturesSize(A,dpscale,overTime,overDep,data);
%                     [A,dpscale] = Pre_PruningOverlappingFeaturesCombined(A,dpscale,overTime,overDep,data,criteria);
%                     
%                     if(exist(strcat(saveFeaturesPath,'Distances',distanceUsed,'\FeaturesPruned\'),'dir')==0)
%                         mkdir(strcat(saveFeaturesPath,'Distances',distanceUsed,'\FeaturesPruned\'));
%                     end
%                     csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\FeaturesPruned\Features_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),A);%Matlab_
%                     csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\FeaturesPruned\DepdScale_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),dpscale);%Matlab_
%                     NewFeatures=[NewFeatures,A];
%                     NewDependency= [NewDependency,dpscale];
%                     %                     [C,mu] = kmeans(A(11:size(X,1),:)',5,'Distance','cosine');
%                     %                     csvwrite(strcat(saveFeaturesPath,'DistancesDescriptors\FeaturesPruned\Cluster_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),C);%Matlab_
%                     %                     csvwrite(strcat(saveFeaturesPath,'DistancesDescriptors\\FeaturesPruned\Centroids_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),mu);%Matlab_
%                 end
%             end
%         end
%         frame1=NewFeatures;
%         save(strcat(saveFeaturesPath,'Distances',distanceUsed,'\FeaturesPruned\','feature_',TS_name,'.mat'),'data', 'gss1', 'frame1','depd1');
%     end
%     
%     % Clustering
%     if (Cluster==1)
%         % execute K-means Cluster k = DictionarySize;
%         % A Dictionary for each cluster
%         saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\'];
%         
%         savepath1 = [saveFeaturesPath,'feature_',TS_name,'.mat'];
%         savepath2 = [saveFeaturesPath,'idm_',TS_name,'.mat'];
%         savepath3 = [saveFeaturesPath,'MetaData_',TS_name,'.mat'];
%         load(savepath1);
%         load(savepath2);
%         load(savepath3);
%         
%         clustindfix=0;
%         for k=1:DeOctTime
%             for j=1:DeOctDepd
%                 clustindfix=clustindfix+1;
%                 indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);
%                 X=frame1(:,indexfeatureGroup);
%                 
%                 DictionarySizeApplied=0;
%                 if(strcmp(SizeofK,'Computed')==1)
%                     DictionarySizeApplied= floor(abs(size(X,2))/10);
%                     if(DictionarySizeApplied == 0)
%                         DictionarySizeApplied=1;
%                     end
%                 elseif(strcmp(SizeofK,'Fixed')==1)
%                     DictionarySizeApplied = DictionarySize(clustindfix);
%                 end
%                 
%                         'Cluster on Descriptors'
%                     if(strcmp(typeofCluster,'ClusterKmedoid')==1)
%                             [C,mu] = cvKmeans (X, DictionarySizeApplied,KmedoidsCoefTerm ,'@Distance_RMT_DESC',false,data,gss1,idm1,KmeansDescmetric);
%                     elseif(strcmp(typeofCluster,'ClusterMatlab')==1)
%                             [C,mu] = kmeans(X(11:size(X,1),:)',DictionarySizeApplied,'Distance','sqeuclidean');%);%'cosine');%
%                     elseif(strcmp(typeofCluster,'Cluster_AKmeans')==1)
%                        [C,mu,inertia,tryK,startK]= adaptiveKmeans(X,3,0.05,0,'sqeuclidean');%'cosine');%0 will fix the step to 2 as default
%                         if(exist(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\'),'dir')==0)
%                             mkdir(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\'));
%                         end
%                         csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\Cl_behavior_IM_',TS_name,'_DO_',num2str(j),'_TO_',num2str(k),'.csv'),[inertia',tryK']);%Matlab_    
%                     end
%                     if(exist(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\'),'dir')==0)
%                         mkdir(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\'));
%                     end
%                     csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\Cluster_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),C);%Matlab_
%                     csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\Centroids_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),mu);%Matlab_
%             end
%         end
%     end
%     
%     % threshould clustering
%     if(Cluster==2)
%         NumofCluster=10;
%         saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\'];
%         savepath1 = [saveFeaturesPath,'feature_',TS_name,'.mat'];
%         savepath2 = [saveFeaturesPath,'idm_',TS_name,'.mat'];
%         savepath3 = [saveFeaturesPath,'MetaData_',TS_name,'.mat'];
%         
%         load(savepath1);
%         load(savepath2);
%         load(savepath3);
%         clustindfix=0;
%         for k=1:DeOctTime
%             for j=1:DeOctDepd
%                 clustindfix=clustindfix+1;
%                 indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);
%                 X=frame1(:,indexfeatureGroup);
%                 descr = X(11:size(frame1,1),:);
%                 [featsize,numfeatures]= size(X);
%                 DescrDist = pdist2(descr',descr',KmeansDescmetric)/2;
%                 dpscale = csvread(strcat(saveFeaturesPath,'Distances',distanceUsed,'\DepdScale_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));
% 
%                 [centroids,Clusterfeatures,ClusterSymbols,ClusterDep] = clusteronInportance(X,DescrDist,dpscale,0.05,NumofCluster);%ThresholdCluster(clustindfix),NumofCluster);
%                 mkdir(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\',distanceUsed,'\ClusterThrehold\'));
%                 csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\',distanceUsed,'\ClusterThrehold\Cluster_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),ClusterSymbols);
%                 csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\',distanceUsed,'\ClusterThrehold\Centroids_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),centroids);
%                 csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\',distanceUsed,'\ClusterThrehold\Cluster_Features_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),Clusterfeatures);
%                 csvwrite(strcat(saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',SizeofK,'\',distanceUsed,'\ClusterThrehold\Cluster_Dep_IM_',TS_name,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'),ClusterDep);
%                 
%                 
%             end
%         end
%         ShowThresholdCluster(TS_name,datasetPath,subfolderPath,TS_name,K_valuesCalc,distanceUsed,'ClusterThrehold',histTSImage,FeaturesRM);
%     end
%     
%     if (CreateSubCluster==1)
%         saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\'];
%         depdOverLapThreshold = 0.7;
%         subCluster_Varaites(saveFeaturesPath,TS_name,K_valuesCalc,distanceUsed,typeofCluster,depdOverLapThreshold);
%         
%     end
%     
%     % save images before pruning
%     if(motifidentificationBP ==1)
%         ShowKmedoidsCluster(TS_name,datasetPath,subfolderPath,TS_name,K_valuesCalc,distanceUsed,typeofCluster,histTSImage,FeaturesRM );
%     end
%     if(motifidentificationBP_MatlabDescr ==1)
%         ShowKmeansCluster(TS_name,datasetPath,subfolderPath,TS_name,K_valuesCalc,distanceUsed,typeofCluster,histTSImage,FeaturesRM);
%         ShowVaraiteallineadCluster(TS_name,datasetPath,subfolderPath,TS_name,K_valuesCalc,distanceUsed,typeofCluster,histTSImage,FeaturesRM);
%     end
%     
%     % Prune the clusters
%     if(pruneClusterDescrMatlab==1)
%         
%         KmeansPruning(TS_name,datasetPath,subfolderPath,TS_name,typeofCluster,K_valuesCalc,prunewith,distanceUsed ,DictionarySize,histTSImage,FeaturesRM);
%         
%         VariateAllinedKmeansPruning(TS_name,datasetPath,subfolderPath,TS_name,typeofCluster,K_valuesCalc,prunewith,distanceUsed ,DictionarySize,histTSImage,FeaturesRM);
%     end
%     
%     if(pruneClusterDescrMatlab==2)
%         KmeansPruning_overlappingcleaning(TS_name,datasetPath,subfolderPath,TS_name,typeofCluster,K_valuesCalc,prunewith,distanceUsed ,DictionarySize,histTSImage,FeaturesRM);
%     end
%     
%     if (pruneCluster==1)
%         KmedoidsPruning(TS_name,datasetPath,subfolderPath,TS_name,typeofCluster,K_valuesCalc,prunewith,distanceUsed ,DictionarySize,histTSImage,FeaturesRM);
%     end
    
    if(savecaracteristics==1)
        saveFeaturesPath=[datasetPath,subfolderPath,'Features_',FeaturesRM,'\',TS_name,'\'];
        savepath1 = [saveFeaturesPath,'feature_',TS_name,'.mat'];
        savepath2 = [saveFeaturesPath,'idm_',TS_name,'.mat'];
        savepath3 = [saveFeaturesPath,'MetaData_',TS_name,'.mat'];
        load(savepath1);
        load(savepath2);
        load(savepath3);
        a=[];
        for k=1:DeOctTime
            for j=1:DeOctDepd
                indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);
                X=frame1(:,indexfeatureGroup);
                a=[a;[k,j,size(X,2)]];
            end
        end
        SizeFeaturesforImages=[SizeFeaturesforImages;a];
        xlswrite(strcat(saveFeaturesPath,'NumFeatures.xls'),SizeFeaturesforImages);
    end
end