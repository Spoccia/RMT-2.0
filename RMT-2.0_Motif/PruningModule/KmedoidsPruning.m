function [  ] = KmedoidsPruning(TEST, imagepath,specificimagepath,imagename,typeofCluster,K_valuesCalc,prunewith,distanceUsed ,DictionarySize,histdataimage)
%KMEDOIDSPRUNING Summary of this function goes here
% imagepath=path of the original timeseries
% specificimagepath= ppath to go inside  where the dataset is located
% imagename= the timeseries name
% typeofCluster= ClusterKmedoids or ClusterMatlab it identify the subfolder where  the cluster should be saved and  then it can be readed
% K_valuesCalc =  the value of k can be 'Fixed';%'Threshould';% 'Computed'; a different name  will  help us to go in the specific cluster folder created for the test
% prunewith= Descriptor, Amplitude_Descriptor, Amplitude_Descriptor_overlapping
% distanceUsed= 'Descriptor';%'Amplitude_Descriptor';% it is used inside the cluster to define if use the amplitude or not in the cluster
% DictionarySize= vector containing the k used for each cluster.
% TEST= test folder path
if (strcmp(typeofCluster,'ClusterKmedoids')~=1)
    'wrong cluster !!!!' 
    typeofCluster
    pause;
        return;
end
    ImageSavingPath=[saveFeaturesPath,'DistancesDescriptors\Cluster_',K_valuesCalc,'\',distanceUsed,'\afterPruning\ClusterMatlab\',prunewith,'\imageMotifs\'];
    PrunedClusterPath=[saveFeaturesPath,'DistancesDescriptors\Cluster_',K_valuesCalc,'\',distanceUsed,'\afterPruning\',typeofCluster];
    ClusterPath = [saveFeaturesPath,'DistancesDescriptors\Cluster_',K_valuesCalc,'\',distanceUsed,'\',typeofCluster];
    %% load features
    saveFeaturesPath=[imagepath,specificimagepath,'Features\',TEST,'\'];
    savepath1 = [saveFeaturesPath,'feature_',imagename,'.mat'];
    savepath2 = [saveFeaturesPath,'idm_',imagename,'.mat'];
    savepath3 = [saveFeaturesPath,'MetaData_',imagename,'.mat'];   
    load(savepath1);
    load(savepath2);
    load(savepath3);    
    
%     structureFinal = splitCluster(frame1);
%     numgroups=size(structureFinal,2);
    TS =data;
    
    %% for each octave time
    clustindfix=0;
    for k=1:DeOctTime
       for j=1:DeOctDepd
           clustindfix=clustindfix+1;
           indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);     
           X=frame1(:,indexfeatureGroup);
     %      DictionarySizeApplied= floor(abs(size(X,2))/10);
%     for p=1:numgroups
%         indexfeatureGroup =  structureFinal(:,p);
        prunedFeaturesCluster=[];
        prunedCluster=[];
        prunedDepScale=[];

        DictionarySizeApplied=0;
           if(strcmp(K_valuesCalc,'Computed')==1)
               DictionarySizeApplied= floor(abs(size(X,2))/10);
               if(DictionarySizeApplied == 0)
                   DictionarySizeApplied=1;
               end
           elseif(strcmp(K_valuesCalc,'Fixed')==1)
               DictionarySizeApplied = DictionarySize(clustindfix);
           end
         if(abs(size(X,2))>=DictionarySizeApplied & abs(size(X,2))>0)
                dpscale = csvread(strcat(saveFeaturesPath,'DistancesDescriptors\DepdScale_IM_',imagename,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));
                C = csvread(strcat(ClusterPath,'\Cluster_IM_',imagename,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));%_',imagename,'_',num2str(p),'.csv'));
                mu = csvread(strcat(ClusterPath,'\Centroids_IM_',imagename,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));%_',imagename,'_',num2str(p),'.csv'));
                clusterLabel = unique(C);
                nCluster     = length(clusterLabel);
                %% for each cluster
                dataid=zeros(size(data,1),size(data,2),nCluster);
                histdataid=zeros(size(data,1),size(data,2),nCluster);
                for i=1:nCluster

                    centroid_tempMinScope1=min(3*mu(4, i));
                    %% features and depscale of each feature in cluster i
                    A = X(:, C == clusterLabel(i));

                    [featsize,numfeatures]= size(A);
                    act_centroid = mu(11:featsize,i);
                    descr = A(11:featsize,:);
                    centroid_distDescriptors= zeros(1,numfeatures);
                    
                    distancecentroid = pdist2(act_centroid',descr',KmeansDescmetric);
%                     for k1=1:numfeatures
%                         centroid_distDescriptors(1,k1)= pdist([act_centroid';descr(:,k1)'],KmeansDescmetric);
%                     end
                    std_cluster=std(descr');
                    avg_cluster = mean(descr');
                    
                    B =dpscale(:,C == clusterLabel(i));
                    tempMinScope1 = min(3*A(4, :)); % temporal scope of the features in cluster i
                    X_Amp1=amplitudediff(TS,A,gss1,idm1); 
                    cent_Amp= amplitudediff(TS,mu(:,i),gss1,idm1);

                    %% compute the scope from the centroid i
                    FinalScore=[];
                    if(strcmp(prunewith,'Descriptor')==1)
                       'Prune using just Descriptors'
                        FinalScore= descr_Score(centroid_distDescriptors,numfeatures);
                    elseif(strcmp(prunewith,'Amplitude_Descriptor')==1)
                        'Prune using  Descriptors + Amplitude'
                        FinalScore= Amp_descr_Score(centroid_distDescriptors,numfeatures,X_Amp1,cent_Amp); % 1-combinedscore
                    end
                    A1=A(:,FinalScore < ThresholdCluster(clustindfix));
                    B1=B(:,FinalScore < ThresholdCluster(clustindfix));
%                     %% use overlapping to prune  the feature selected
%                     [A1,B1]=pruneoverlap(A,B);
%                     A=A1;
%                     B=B1;
                   if(size(A(FinalScore<ThresholdCluster(clustindfix)),2)>1)
                        prunedFeaturesCluster=[prunedFeaturesCluster,A(:,FinalScore < ThresholdCluster(clustindfix))];
                        prunedDepScale = [prunedDepScale,B(:,FinalScore < ThresholdCluster(clustindfix))];
                        prunedsymbols = ones(1,size(A(:,FinalScore < ThresholdCluster(clustindfix)),2))*i;
                        prunedCluster=[prunedCluster,prunedsymbols];
                   end
                   
                   if (size(A1,2)>0)
                        timescope= A1(4,:)*3;
                    end
                    for iii=1: size(A1,2)
                        intervaltime=(round((A1(2,iii)-timescope(iii))) : (round((A1(2,iii)+timescope(iii)))));
                        dataid(B1((B1(:,iii)>0),iii),intervaltime((intervaltime>0 & intervaltime<=size(data,2))),i)= data(B1(B1(:,iii)>0,iii),intervaltime((intervaltime>0 & intervaltime<=size(data,2))));
                        histdataid(B1((B1(:,iii)>0),iii),intervaltime((intervaltime>0 & intervaltime<=size(data,2))),i)= histdataimage(B1(B1(:,iii)>0,iii),intervaltime((intervaltime>0 & intervaltime<=size(data,2))));
                    end
                    if(size(A1,2)>1)
                        if(exist([ImageSavingPath,imagename,'\octaveT_',num2str(k),'_octaveD_',num2str(j)],'dir')==0)
                            mkdir([ImageSavingPath,imagename,'\octaveT_',num2str(k),'_octaveD_',num2str(j),'\']);
                        end
                        imwrite(uint8(dataid(:,:,i)),[ImageSavingPath,imagename,'\octaveT_',num2str(k),'_octaveD_',num2str(j),'\Im_',imagename,'_octT_',num2str(k),'_octD_',num2str(j),'_Cl_',num2str(i),'.jpg']);
                        imwrite(uint8(histdataid(:,:,i)),[ImageSavingPath,imagename,'\octaveT_',num2str(k),'_octaveD_',num2str(j),'\HistIm_',imagename,'_octT_',num2str(k),'_octD_',num2str(j),'_Cl_',num2str(i),'.jpg']);
                    end
                   
                end
                save(strcat(PrunedClusterPath,'\datacluster_',imagename,'_DepO_',num2str(j),'_DepT_',num2str(k),'.mat'),'dataid');%save(savepath1,'data', 'gss1', 'frame1','depd1');
                save(strcat(PrunedClusterPath,'\Histdatacluster_',imagename,'_DepO_',num2str(j),'_DepT_',num2str(k),'.mat'),'histdataid');%save(savepath1,'data', 'gss1', 'frame1','depd1');
                csvwrite(strcat(PrunedClusterPath,'\PrunedCluster_IM_',imagename,'_DepO_',num2str(j),'_DepT_',num2str(k),'.csv'),prunedCluster);%; _',imagename,'_',num2str(p),'.csv')
                csvwrite(strcat(PrunedClusterPath,'\Centroids_IM_',imagename,'_DepO_',num2str(j),'_DepT_',num2str(k),'.csv'),mu);%',imagename,'_',num2str(p),'.csv')
                csvwrite(strcat(PrunedClusterPath,'\PrunedFeatures_IM_',imagename,'_DepO_',num2str(j),'_DepT_',num2str(k),'.csv'),prunedFeaturesCluster);%',imagename,'_',num2str(p),'.csv'),
                csvwrite(strcat(PrunedClusterPath,'\PrunedDepScaleFeatures_IM_',imagename,'_DepO_',num2str(j),'_DepT_',num2str(k),'.csv'),prunedDepScale);%',imagename,'_',num2str(p),'.csv'),
            
         end
       end
    end

end

