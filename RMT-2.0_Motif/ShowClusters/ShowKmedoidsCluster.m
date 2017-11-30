function [ output_args ] = ShowKmedoidsCluster(TEST,imagepath,specificimagepath,imagename,K_valuesCalc,distanceUsed,typeofCluster,histdataimage,FeaturesRM )
%SHOWKMEDOIDSCLUSTER Summary of this function goes here
%   Detailed explanation goes here

if (strcmp(typeofCluster,'ClusterKmedoids')~=1 & strcmp(typeofCluster,'ClustThresh')~=1)
    'wrong cluster !!!!' 
    typeofCluster
    pause;
        return;
end
    saveFeaturesPath=[imagepath,specificimagepath,'Features_',FeaturesRM,'\',TEST,'\'];
    savepath1 = [saveFeaturesPath,'feature_',imagename,'.mat'];
    savepath2 = [saveFeaturesPath,'idm_',imagename,'.mat'];
    savepath3 = [saveFeaturesPath,'MetaData_',imagename,'.mat'];  
    ClusterPath = [saveFeaturesPath,'DistancesDescriptors\Cluster_',K_valuesCalc,'\',distanceUsed,'\',typeofCluster];
    ImageSavingPath = [saveFeaturesPath,'DistancesDescriptors\Cluster_',SizeofK,'\',distanceUsed,'\beforePruning\imageMotifs\',imagename];
    RebSeriesPath = [saveFeaturesPath,'DistancesDescriptors\Cluster_',SizeofK,'\',distanceUsed,'\beforePruning\rebClusters\RebSeries_',imagename];
    load(savepath1);
    load(savepath2);
    load(savepath3);    
    colours= ['b';'g';'r';'c';'m';'y';'k';'w'];
    symbols= ['.';'o';'x';'+';'*';'s';'d';'v'];
    symbComb=[];
    for i =1: length(symbols)
        for j = 1:length(colours)
            symbComb = [symbComb;strcat(colours(j,1),symbols(i,1))];
        end
    end
    clustindfix=0;
    for k=1:DeOctTime
       for j=1:DeOctDepd
           clustindfix=clustindfix+1;
           indexfeatureGroup = (frame1(6,:)==k & frame1(5,:)==j);     
           X=frame1(:,indexfeatureGroup);
%            DictionarySizeApplied= floor(abs(size(X,2))/10);
%                if(DictionarySizeApplied == 0)
%                  DictionarySizeApplied=1;
%                end
           %DictionarySizeApplied = DictionarySize(clustindfix);
           DictionarySizeApplied=0;
           if(strcmp(SizeofK,'Computed')==1)
               DictionarySizeApplied= floor(abs(size(X,2))/10);
               if(DictionarySizeApplied == 0)
                   DictionarySizeApplied=1;
               end
           elseif(strcmp(SizeofK,'Fixed')==1)
               DictionarySizeApplied = DictionarySize(clustindfix);
           end
           if(abs(size(X,2))>=DictionarySizeApplied & abs(size(X,2))>0)
                dpscale = csvread(strcat(saveFeaturesPath,'DistancesDescriptors\DepdScale_IM_',imagename,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));%_',imagename,'_',num2str(p),'.csv'));
                %dpscale = csvread(strcat(saveFeaturesPath,'DistancesDescriptors\afterPruning\PrunedDepScaleFeatures_',imagename,'_',num2str(p),'.csv'));
                C = csvread(strcat(ClusterPath,'\Cluster_IM_',imagename,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));%_',imagename,'_',num2str(p),'.csv'));
                mu = csvread(strcat(ClusterPath,'\Centroids_IM_',imagename,'_DepO_',num2str(j),'_TimeO_',num2str(k),'.csv'));%_',imagename,'_',num2str(p),'.csv'));
                clusterLabel = unique(C);
                nCluster     = length(clusterLabel);
                %plotLabel = symbComb(1:nCluster,:);
                dataid=zeros(size(data,1),size(data,2),nCluster);
                histdataid=zeros(size(data,1),size(data,2),nCluster);
                for ii=1:nCluster
                    A = X(:, C == clusterLabel(ii));
                    B =dpscale(:,C == clusterLabel(ii));
                    timescope= A(4,:)*3;

%                     %% use overlapping to prune  the feature selected
%                     [A1,B1]=pruneoverlap(A,B);
%                     A=A1;
%                     B=B1;
                    if (size(A,2)>0)
                        timescope= A(4,:)*3;
                    end
                    %% close  this portion of code

                    for iii=1: size(A,2)
                        intervaltime=(round((A(2,iii)-timescope(iii))) : (round((A(2,iii)+timescope(iii)))));
                        dataid(B((B(:,iii)>0),iii),intervaltime((intervaltime>0 & intervaltime<=size(data,2))),ii)= data(B(B(:,iii)>0,iii),intervaltime((intervaltime>0 & intervaltime<=size(data,2))));
                        histdataid(B((B(:,iii)>0),iii),intervaltime((intervaltime>0 & intervaltime<=size(data,2))),ii)= histdataimage(B(B(:,iii)>0,iii),intervaltime((intervaltime>0 & intervaltime<=size(data,2))));
                    end
                    if(size(A,2)>1)
                        if(exist([ImageSavingPath,'\octaveT_',num2str(k),'_octaveD_',num2str(j),],'dir')==0)
                            mkdir ([ImageSavingPath,'\octaveT_',num2str(k),'_octaveD_',num2str(j),'\']);
                        end
                        imwrite(uint8(dataid(:,:,ii)),[ImageSavingPath,'\octaveT_',num2str(k),'_octaveD_',num2str(j),'\Im_',imagename,'_octT_',num2str(k),'_octD_',num2str(j),'_Cl_',num2str(ii),'.jpg'])
                        imwrite(uint8(histdataid(:,:,ii)),[ImageSavingPath,'\octaveT_',num2str(k),'_octaveD_',num2str(j),'\HistIm_',imagename,'_octT_',num2str(k),'_octD_',num2str(j),'_Cl_',num2str(ii),'.jpg']);
                    end
                end
                if(exist(RebSeriesPath,'dir')==0)
                    mkdir (RebSeriesPath);
                end
                save(strcat(RebSeriesPath,'_Toctave_',num2str(k),'_Doctave_',num2str(j),'_dic_',num2str(nCluster),'.m'),'dataid');    
            end
    %end
       end
    end

end

