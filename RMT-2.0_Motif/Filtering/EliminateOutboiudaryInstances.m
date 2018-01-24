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
           
       % iterate on motif bags
       % for each motif bag read the timeseries section 
       % for each timeseries represent it as a PAA
       % compute the euclidean distance between the subsections
       
           load (strcat(PrunedClusterPath,'\Motif_',imagename,'_DepO_',num2str(j),'_DepT_',num2str(k),'.mat'));
           numMotif = size(MotifBag,2);
           MotifOK=[];
           Contator=1;
           for motifID =1 :numMotif
               startIndex = MotifBag{motifID}.startIdx;
               TSSections=[];
               for iterator=1:size(MotifBag{motifID}.startIdx,1)
                  depd =  MotifBag{motifID}.depd{iterator};
                  timescope =  MotifBag{motifID}.Tscope{iterator};
                  TSSections(:,:,iterator) = representation(data,startIndex,depd,timescope,NumWindows);
               end
               D= DistancesTS(TSSections);
               counts = sum(D <=eps);
               SurvivedMotifInstances = counts>2;
               if sum(SurvivedMotifInstances)>0
                   IDX = 1:size(counts,2);
                   IDX = IDX(SurvivedMotifInstances);
                   MotifOK{Contator}.startIdx=startIndex(SurvivedMotifInstances);
                   for  variateMotifs = 1:size(IDX,2)
                       MotifOK{Contator}.depd{variateMotifs}   = MotifBag{motifID}.depd{IDX(variateMotifs)};
                       MotifOK{Contator}.Tscope{variateMotifs} = MotifBag{motifID}.Tscope{IDX(variateMotifs)};
                   end
                   Contator=Contator+1;
               end
               
               'job done'
           end
           MotifBag= MotifOK;
           
%            Plot motifs :))
           
           strcat(PrunedClusterPath,'\Motif_',imagename,'_DepO_',num2str(j),'_DepT_',num2str(k),'.mat')
           
       end
    end

end