
%% read thre motifs from matrix profile 2
clear;
clc;

path_MStamp='D:\Motif_Results\Datasets\Mocap\MStamp\';
pathRMT= 'D:\Motif_Results\Datasets\Mocap\Features_RMT\';
SavingResult='D:\Motif_Results\Datasets\Mocap\Results\';
TsNumber=10;%184;
MstampSize=[29,58];
Num_OD=2;
SplitVariate='SplitVariate\';
AterPruning='AP_VA';%'AP';
RMT_clusterName='Cluster_Akmeans\';
for TS_id = 1: TsNumber
    for sizeid= 1:length(MstampSize)
        TsName= num2str(TS_id);
        load([path_MStamp,TsName,'\Motif_output_',TsName,'Lenght_',num2str(MstampSize(sizeid)),'.mat']);
        %% read the  our clusters related to  this size
        % sizeid is comparable to octave time
        OT=num2str(sizeid);
        for OD =2: Num_OD
            % load the motif stucture that remark the clusters
           
            loadingpathRMT= [pathRMT,TsName,'\DistancesDescriptor\',RMT_clusterName,SplitVariate,AterPruning,'\',RMT_clusterName,...
                             'Motif_',TsName,'_DepO_',num2str(OD),'_DepT_',OT,'.mat'];
            load(loadingpathRMT);
            numRMTMotifBag= size(MotifBag,2);
            numMstampMotif= size(motif_idx,1);
            MatchingStructure=[];
            for idRMTMob=1:numRMTMotifBag
                if isempty(MotifBag{idRMTMob})
                    idRMTMob
                else
                    RMT_SIdx = MotifBag{idRMTMob}.startIdx;
                    RMT_depd = MotifBag{idRMTMob}.depd;
                    RMT_Tscope = MotifBag{idRMTMob}.Tscope;
                    numofinstances = length(RMT_SIdx)
                    for id = 1:numofinstances
                        ThisRMTMotif= [idRMTMob,id,RMT_SIdx(id),RMT_Tscope{id}];
                        Timerange_RMT    = RMT_SIdx(id):RMT_SIdx(id)+RMT_Tscope{id};
                        VaraiteRange_RMT = RMT_depd{id};
                        Overlapping_time_Variate=zeros(2,numMstampMotif);
                        for idMstampMotif = 1 :numMstampMotif
                            Timerange_Mstamp    = motif_idx(idMstampMotif):motif_idx(idMstampMotif)+ MstampSize(sizeid);
                            VaraiteRange_Mstamp = motif_dim{idMstampMotif};

                            TimeScore    = size(intersect(Timerange_RMT,Timerange_Mstamp),2);
                            VariateScore = size(intersect(VaraiteRange_RMT',VaraiteRange_Mstamp),2)/size(union(VaraiteRange_RMT',VaraiteRange_Mstamp),2);

                            Overlapping_time_Variate(1,idMstampMotif) = TimeScore;
                            Overlapping_time_Variate(2,idMstampMotif) = VariateScore ;
                        end
                        IDX_variate = Overlapping_time_Variate(2,:)>0;
                        IDX_time    = Overlapping_time_Variate(1,:)>0;

                        Overlapping_time_Variate1= Overlapping_time_Variate;
                        Overlapping_time_Variate1(:,IDX_variate == 0) = 0;
                        Overlapping_time_Variate1(:,IDX_time    == 0)    = 0;

                        TheBestmatch=[];
                        if(sum(Overlapping_time_Variate1(:))==0)
                            TheBestmatch= [-1,-1,MstampSize(sizeid),...
                                           0,0];
                        else
                        [p,bestsection]= max(Overlapping_time_Variate1(1,:));
                        TheBestmatch= [bestsection,motif_idx(bestsection),MstampSize(sizeid),...
                                       Overlapping_time_Variate(1,bestsection),Overlapping_time_Variate(2,bestsection)];
                        end
                        MatchingStructure=[MatchingStructure;ThisRMTMotif,TheBestmatch];
                    end
                end
            end
            if(exist([SavingResult,TsName],'dir')==0)
               mkdir ([SavingResult,TsName]);
            end        
            col_header={'Class RMT ','ID RMT','Start RMT','TimeScope RMT','ID Mstamp','Start Mstamp','Scope Mstamp','Time Score','Depd Score'}; 
            xlswrite([SavingResult,TsName,'\RMT_Mstamp.xls'],MatchingStructure,[AterPruning,'_OD_',num2str(OD),'_OT_',OT],'A2');
            xlswrite([SavingResult,TsName,'\RMT_Mstamp.xls'],col_header,[AterPruning,'_OD_',num2str(OD),'_OT_',OT],'A1');
        end  
    end
end