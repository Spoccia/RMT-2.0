function timeforcleaning =  EliminateOutboiudaryInstances(TEST, imagepath,specificimagepath,imagename,typeofCluster,K_valuesCalc,prunewith,distanceUsed ,DictionarySize,histdataimage,FeaturesRM,cleanfeatures,NumWindows,saveMotifImages )

    saveFeaturesPath=[imagepath,specificimagepath,'Features_',FeaturesRM,'\',cleanfeatures,TEST,'\'];
    savepath1 = [saveFeaturesPath,'feature_',imagename,'.mat'];
    savepath2 = [saveFeaturesPath,'idm_',imagename,'.mat'];
    savepath3 = [saveFeaturesPath,'MetaData_',imagename,'.mat'];   
     ClusterPath = [saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',K_valuesCalc,'\SplitVariate'];%'\',distanceUsed,'\',typeofCluster,
    ImageSavingPath=[ClusterPath,'\AP_VA'];%\imageMotifs\',imagename];
%     ImageSavingPath=[saveFeaturesPath,'DistancesDescriptors\Cluster_',K_valuesCalc,'\',distanceUsed,'\AP_Kmeans\'];%,prunewith,'\imageMotifs\'];
     PrunedClusterPath = [ClusterPath,'\AP_VA\',typeofCluster];
% PrunedClusterPath=[saveFeaturesPath,'DistancesDescriptors\Cluster_',K_valuesCalc,'\',distanceUsed,'\AP_Kmeans\',typeofCluster];
%     ClusterPath = [saveFeaturesPath,'DistancesDescriptors\Cluster_',K_valuesCalc,'\',distanceUsed,'\',typeofCluster];
    load(savepath1);
    load(savepath2);
    load(savepath3);
    for k=1:DeOctTime
       for j=1:DeOctDepd
           load (strcat(PrunedClusterPath,'\Motif_',imagename,'_DepO_',num2str(j),'_DepT_',num2str(k),'.mat'));
           numMotif = size(MotifBag,2);
           for motifID =1 :numMotif
               startIndex = MotifBag{motifID}.startIdx;
               TSSections=[];
               for iterator=1:size(MotifBag{motifID}.startIdx,1)
                  depd =  MotifBag{motifID}.depd{iterator};
                  timescope =  MotifBag{motifID}.Tscope{iterator};
                  TSSection(:,:,iterator) = representation(data,startIndex,depd,timescope,NumWindows);
               end
               D= DistancesTS(TSSection);
               'job done'
           end
       
       % iterate on motif bags
       % for each motif bag read the timeseries section 
       % for each timeseries represent it as a PAA
       % compute the euclidean distance between the subsections
       
       end
    end

end