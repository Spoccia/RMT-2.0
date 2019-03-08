clear;
clc;
DS_List ={'MoCap','BirdSong','Energy'};
DestPath= 'F:\Motif_Results\Motif 1 2 3 multisize\';

num_of_motif = [1:3];%
strategy = [1, 3, 4, 6, 7, 9];
amp_scale = [0, 0.1, 0.25, 0.5, 0.75, 1, 2];
BaseName='Motif';
algorithm_type = {'RMT','MStamp'};


Num_SyntSeries=10;

for DSIdx =1:3
    Ds_Name= DS_List{DSIdx};%F:\Motif_Results\Motif 1 2 3 multisize\MoCap\
    Path =['F:\Motif_Results\Motif 1 2 3 multisize\',Ds_Name,'\'];
    load([Path,'data\FeaturesToInject\allTSid.mat']);
    Name_OriginalSeries = AllTS;
    for kk = 1 : size(algorithm_type, 2)
        strategynum= size(strategy, 2);
        PathAlg='Features_RMT\';
        if kk==2
            strategynum=2;
            PathAlg='MStamp\';
        end
        
        cur_algorithm_type=[];
        cur_strategy=0;
        for i = 1 : size(num_of_motif, 2)
            AggregateTimeforScales= zeros(6,size(amp_scale, 2));
            if kk==2
                AggregateTimeforScales= zeros(3,size(amp_scale, 2));
            end
            for j = 1: strategynum                
                for aa = 1 : size(amp_scale, 2)
                    TimeSum=zeros(6,1);
                    if kk==2
                        TimeSum=zeros(3,1);
                    end
                    cur_algorithm_type = algorithm_type{kk};
                    cur_strategy = strategy(j);
                    cur_num_of_motif = num_of_motif(i);
                    curr_ampScale= amp_scale(aa);
                    CountSuccess=0;
                    for pip=1:30%size(Name_OriginalSeries,2)
                        for NAME = 1:Num_SyntSeries
                            nameTS=[BaseName,num2str(num_of_motif(i)),'_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME),'_',num2str(curr_ampScale)];
                            Timepath=[Path,PathAlg,nameTS,'\','Strategy_',num2str(cur_strategy),'_TIME1.csv'];
                            if kk==2 %Time_Motif1_17_instance_1_0BoM_0+1iLenght_59
                                if(DSIdx==1)
                                    Timepath=[Path,PathAlg,nameTS,'\','Time_',nameTS,'BoM_0+1iLenght_59.xls'];
                                elseif(DSIdx==2)
                                    Timepath=[Path,PathAlg,nameTS,'\','Time_',nameTS,'BoM_0+1iLenght_32.xls'];
                                else
                                    Timepath=[Path,PathAlg,nameTS,'\','Time_',nameTS,'BoM_0+1iLenght_58.xls'];
                                end
                                try
                                Time =csvread(Timepath);
                                CountSuccess=CountSuccess+1;
                                catch
                                    [Path,PathAlg,nameTS,'\','Time_',nameTS,'BoM_0+1iLenght_58.xls']
                                end
                            else
                                Time = csvread(Timepath);
                                
                                CountSuccess=CountSuccess+1;
                            end
                            TimeSum=TimeSum+Time;
                            %% somma  tutti i tempi
                        end
                    end
                    AggregateTimeforScales(:,aa)=(TimeSum/(CountSuccess));
                end
                csvwrite([DestPath,'AggregateTime_',Ds_Name,'_M_',num2str(i),'_',cur_algorithm_type,'_STR_',num2str(cur_strategy),'.csv'],AggregateTimeforScales);
            end
            
            
        end
    end
end

