function  [timeforcleaning]= CleaningClusters (TEST, imagepath,specificimagepath,imagename,typeofCluster,K_valuesCalc,prunewith,distanceUsed ,FeaturesRM,cleanfeatures,saveMotifImages)

    saveFeaturesPath=[imagepath,specificimagepath,'Features_',FeaturesRM,'\',cleanfeatures,TEST,'\'];
    savepath1 = [saveFeaturesPath,'feature_',imagename,'.mat'];
    savepath2 = [saveFeaturesPath,'idm_',imagename,'.mat'];
    savepath3 = [saveFeaturesPath,'MetaData_',imagename,'.mat'];   
    ClusterPath = [saveFeaturesPath,'Distances',distanceUsed,'\Cluster_',K_valuesCalc,'\SplitVariate'];
    ImageSavingPath=[ClusterPath,'\AP_VA'];%\imageMotifs\',imagename];
    PrunedClusterPath = [ClusterPath,'\AP_VA\',typeofCluster];
    newPrunedPath = [ClusterPath,'\AP_VA_clean\',typeofCluster];
    %% load the original data
    load(savepath1);
    load(savepath2);
    load(savepath3);
    timeforcleaning=[];
    %ppath where we will save our stuff
    FinalPath = strcat(newPrunedPath);
    if(exist(newPrunedPath,'dir')==0)
            mkdir(newPrunedPath);
    end
    for k=2:DeOctTime
       for j=2:DeOctDepd
%           Load  all the clusters from the structure  
          load (strcat(PrunedClusterPath,'\Motif_',imagename,'_DepO_',num2str(j),'_DepT_',num2str(k),'.mat'));
          numClusters = size(MotifBag,2);
          % read the centroid of a cluster
          Counter=1;
          featureforClusters=[];
          ClusterLabels = [];
          MotifBag1=[];
          Clusterused=[];
          for motifID =1 :numClusters
              featuresCluster = MotifBag{motifID}.features;
              fin= false;
              kmeansK=2; %% suppose my cluster is bad
              RelativeErrors = [];
%               Quality = [];
              centroid = pdist2(featuresCluster(11:end,:),featuresCluster(11:end,:));
              centroid = mean(centroid);
              distancesF_C =pdist2(featuresCluster(11:end,:)',centroid);
              Quality = sum(distancesF_C);
              tentativeC=ones(size(featuresCluster,2),1); % clusterIndex
              tentativemu = centroid;
              while  ~fin
                [C,m,SUMD,D] = kmeans(featuresCluster(11:end,:)',kmeansK,'Replicates',5);
                distancesF_Ci = sum(SUMD);
                Quality  = [Quality, distancesF_Ci];
                RelativeErrors = [RelativeErrors,(abs(Quality(end)- Quality(end-1))/Quality(end-1))];
                SlidingError=inf;
                if(size(RelativeErrors,2)>1)
                    SlidingError = RelativeErrors(end)-RelativeErrors(end-1);%abs();
                end
                  if (RelativeErrors(end)<0.2  || kmeansK == size(featuresCluster,2)-1 || Quality(end)<0.1)
                      %the previus cluster wass a good one
                      if(  kmeansK==2 & size(featuresCluster,2)~=3 )
                          [~,bestclusterinstance] = min(Quality);
                          C =tentativeC(:,end);
                      end
                      % add the max value from Clusterused to C
                      if(size(Clusterused, 1) == 0)
                          max_value_cluster_used = 0;
                      else
                          max_value_cluster_used = max(Clusterused);
                      end
                      C_append = C + max_value_cluster_used;
                      Clusterused=[Clusterused;C_append];
                      labels = unique(C);%tentativeC);
                      for subclusterID =1 : length(labels)
                          IDXClusterF = C == subclusterID; %tentativeC==subclusterID;
                          MotifBag1{Counter + subclusterID-1}.features = MotifBag{motifID}.features(:,IDXClusterF);
                          MotifBag1{Counter + subclusterID-1}.startIdx = MotifBag{motifID}.startIdx(IDXClusterF);
                          IDX = 1:size(MotifBag{motifID}.startIdx,1);
                          IDX = IDX(IDXClusterF);
                          for  variateMotifs = 1:size(IDX,2)
                             MotifBag1{Counter + subclusterID-1}.depd{variateMotifs}   =  MotifBag{motifID}.depd{IDX(variateMotifs)};%bestvariate{IDX(variateMotifs)};%
                             MotifBag1{Counter + subclusterID-1}.Tscope{variateMotifs} =  MotifBag{motifID}.Tscope{IDX(variateMotifs)};
                          end
                              %% printmotifs
                          if(saveMotifImages==1)
                            if(exist([FinalPath,'\octaveT_',num2str(k),'_octaveD_',num2str(j)],'dir')==0)
                                mkdir([FinalPath,'\octaveT_',num2str(k),'_octaveD_',num2str(j),'\']);
                            end 
                            figure1 = plot_RMTmotif_on_data(data, MotifBag1{Counter + subclusterID-1}.startIdx, MotifBag1{Counter + subclusterID-1}.depd,MotifBag1{Counter + subclusterID-1}.Tscope);
                            filename=[FinalPath,'\octaveT_',num2str(k),'_octaveD_',num2str(j),'\TS_',imagename,'_octT_',num2str(k),'_octD_',num2str(j),'_M_',num2str(Counter + subclusterID-1),'.eps'];%'.jpg'];
                            saveas(figure1,filename,'epsc');
                          end
                      end

                      Counter = Counter+subclusterID;
                      fin =true;
                  else 
                      kmeansK=kmeansK+1;
                      tentativeC = [tentativeC,C];
                      tentativemu = m;

                  end
              end    

          end
          MotifBag=MotifBag1;
          save(strcat(FinalPath,'\Motif_',imagename,'_DepO_',num2str(j),'_DepT_',num2str(k),'.mat'),'MotifBag');
       end
    end
end


                  
                  
%               
%               [C,m,SUMD,D] = kmeans(featuresCluster(11:end,:)',2,'Replicates',5);
%               distancesF_Ci = sum(SUMD);
%               RelativeErrors = (distancesF_Ci-distancesF_C)/distancesF_C;
%               distancesF_C1 = SUMD(1);
%               distancesF_C2 = SUMD(2);
              
              
%               if(RelativeErrors > 0.5)
%               % a voting scheme, pick the better clustered one for representation
% %                   if(distancesF_C1 < distancesF_C2)
%                       IDXClusterF = C==1;
% %                       featureforClusters= [featureforClusters,featuresCluster(:,IDXClusterF)];
% %                       ClusterLabels = [ClusterLabels,ones(1,size(featuresCluster(:,IDXClusterF),2))*Counter];
%                       
%                       MotifBag1{Counter}.features = featuresCluster(:,IDXClusterF);
%                       MotifBag1{Counter}.startIdx = MotifBag{motifID}.startIdx(IDXClusterF);
%                       IDX = 1:size(MotifBag{motifID}.startIdx,2);
%                       IDX = IDX(IDXClusterF);
%                       for  variateMotifs = 1:size(IDX,2)
%                          MotifBag1{Counter}.depd{variateMotifs}   =  MotifBag{motifID}.depd{IDX(variateMotifs)};%bestvariate{IDX(variateMotifs)};%
%                          MotifBag1{Counter}.Tscope{variateMotifs} =  MotifBag{motifID}.Tscope{IDX(variateMotifs)};
%                       end
%                        Counter =Counter+1;
%                       % use cluster-1 to represent the previous cluster
%     %                   RelativeErrors = (distancesF_C1-distancesF_C)/distancesF_C;
%     %                   if(RelativeErrors > 0.5)
%     % %                       use Cluster C1
%     %                   else
%     % %                       Use OriginalCluster
%     %                   end
%                 
%                       IDXClusterF = C==2;
% %                       featureforClusters= [featureforClusters,featuresCluster(:,IDXClusterF)];
% %                       ClusterLabels = [ClusterLabels,ones(1,size(featuresCluster(:,IDXClusterF),2))*Counter];
%                       
%                       MotifBag1{Counter}.features = featuresCluster(:,IDXClusterF);
%                       MotifBag1{Counter}.startIdx = MotifBag{motifID}.startIdx(IDXClusterF);
%                       IDX = 1:size(MotifBag{motifID}.startIdx,2);
%                       IDX = IDX(IDXClusterF);
%                       for  variateMotifs = 1:size(IDX,2)
%                          MotifBag1{Counter}.depd{variateMotifs}   =  MotifBag{motifID}.depd{IDX(variateMotifs)};%bestvariate{IDX(variateMotifs)};%
%                          MotifBag1{Counter}.Tscope{variateMotifs} =  MotifBag{motifID}.Tscope{IDX(variateMotifs)};
%                       end
%                       
% %                       Counter =Counter+1;
%                       % use cluster-2 to represent the previous cluster
%     %                   RelativeErrors = (distancesF_C2-distancesF_C)/distancesF_C;
%     %                   if(RelativeErrors > 0.5)
%     % %                       use Cluster C2
%     %                   else
%     % %                      Use OriginalCluster
%     %                   end
% %                   end
%               else
% %                   featureforClusters= [featureforClusters,featuresCluster];
% %                   ClusterLabels = [ClusterLabels,ones(1,size(featuresCluster,2))*Counter];
%                   MotifBag1{Counter} = MotifBag{motifID};
%                   
%               end
              
              

%               if(RelativeError > 0.5)
% %               Use cluster from Kmenas2
%               else
% %               the previus cluster was already good
%               end
%               Quality = distancesF_C;
%               ClusterQuality = sum(distancesF_C);
%               BestClusterlabel = count;
%               
          
          
%           Labels = unique(ClusterLabels);
%           MotifBag=[];
%           for MotifID =1:size(Labels,2)
%              featureActualCluster =  featureforClusters(:,ClusterLabels==MotifID);
%              MotifBag{MotifID}.features=featureActualCluster;
%              timescope= featureActualCluster(4,:)*3;
%              StartID= round(featureActualCluster(2,:)-timescope);
%              StartID(StartID <1)=1;
%              MotifBag{MotifID}.startIdx = StartID';
%              for iterator=1:size(MotifBag{MotifID}.startIdx,1)
%                  MotifBag{MotifID}.depd{iterator}=B1(B1(:,iterator)>0,iterator);
%                  intervaltime=(round((A1(2,iterator)-timescope(iterator))) : (round((A1(2,iterator)+timescope(iterator)))));  
%                  MotifBag{MotifID}.Tscope{iterator}= size(intervaltime(intervaltime>0 & intervaltime<=size(data,2)),2);%2* timescope(:);
%              end
%              if(saveMotifImages==1)
%                 if(exist([FinalPath,'\octaveT_',num2str(k),'_octaveD_',num2str(j)],'dir')==0)
%                     mkdir([FinalPath,'\octaveT_',num2str(k),'_octaveD_',num2str(j),'\']);
%                 end 
%                  figure1 = plot_RMTmotif_on_data(data, MotifOK{Contator}.startIdx, MotifOK{Contator}.depd,MotifOK{Contator}.Tscope);
%                  filename=[FinalPath,'\octaveT_',num2str(k),'_octaveD_',num2str(j),'\TS_',imagename,'_octT_',num2str(k),'_octD_',num2str(j),'_M_',num2str(Contator),'.eps'];%'.jpg'];
%                  saveas(figure1,filename,'epsc');
%              end
%           end