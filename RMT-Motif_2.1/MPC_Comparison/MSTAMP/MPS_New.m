%%
% Chin-Chia Michael Yeh
%
% C.-C. M. Yeh, N. Kavantzas, and E. Keogh, "Matrix Profile VI: Meaningful
% Multidimensional Motif Discovery," IEEE ICDM 2017.
% https://sites.google.com/view/mstamp/
% http://www.cs.ucr.edu/~eamonn/MatrixProfile.html
%
close all;
clear
clc

saveMotifImages=0;
% load('toy_data.mat');

%% compute the multidimensional matrix profile
% here we provided three variation of the mSTAMP algorithm
% The script will only run when only one of the alternatives is uncomment

%% alternative 1.a: the basic version
DS_List ={'Mocap','Energy','BirdSong'};

numofMethod=1;
for DSIdx =1:3
    Ds_Name= DS_List{DSIdx};
    for definitiveindex =1:1
        experimentFolder= '';
        numInstancesinjected=10;
        if definitiveindex==1
            experimentFolder=' Motifs 1 2 3 same variate multisize\';%%'CoherentShift\MultiSize\';
            numMotifs=3;
            numInstancesinjected=10;
        elseif definitiveindex==2
            experimentFolder= ' Motif1 inst5-15\';
            numInstancesinjected=5;
            numMotifs=1;
        elseif definitiveindex==3
            experimentFolder= ' Motif1 inst5-15\';
            numInstancesinjected=15;
            numMotifs=1;
        elseif definitiveindex==4
            experimentFolder= ' Motif 1 same length\';
            numMotifs=1;
        elseif definitiveindex==5
            experimentFolder='RandomShift\SameSize\';
            numMotifs=1;
        elseif definitiveindex==6
            experimentFolder='RandomShift\MultiSize\';
            numMotifs=1;
        elseif definitiveindex==7
            experimentFolder='CoherentShift\SameSize\';
            numMotifs=1;
        elseif definitiveindex==8
            experimentFolder='CoherentShift\MultiSize\';
            numMotifs=1;
        end
        datasetPath= ['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\',Ds_Name,experimentFolder];
        
        %     for MSvsSS=1:1
        %         datasetPath= ['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\',Ds_Name,' Motif 1 same length\'];%' Motifs 1 2 3 same variate multisize\'];%'CoherentShift\SameSize\'];
        %         if MSvsSS==2
        %             datasetPath= ['D:\Motif_Results\Datasets\SynteticDataset\',Ds_Name,'\',Ds_Name,'CoherentShift\MultiSize\'];
        %         end
        %' Motif1 inst5-15\'];
        %
        
        ImageSavingPath=[datasetPath,'MStamp\'];
        
        load([datasetPath,'data\FeaturesToInject\allTSid.mat']);
        Name_OriginalSeries = sort(AllTS(1:30));%[1,3,6,7];%ENERGY %[23,35,86,111];% MOCap Motif10[64,70,80,147];BirdSong %[35,85,127,24];%Mocap
        
        percent=[0; 0.1;0.25;0.5;0.75;1;2];
        BaseName='Motif';%'MV_Sync_Motif';%'Motif1numInst_10';%
        for numMotifInjected =1:numMotifs%3%10:10%3
            for prcentid=1:7%4%6%6%size(percent,1)
                percentagerandomwalk=percent(prcentid);
                for pip=1:30
                    for NAME = 1:10
                        MotifBag_mstamp=[];
                        %      try
                        FeaturesRM='MStamp';
                        sublenght = 58; % Energy dataset configuration
                        if strcmp(Ds_Name,'BirdSong')==1
                            sublenght = 32; % BirdSong configuration
                        end
                        TEST=[BaseName,num2str(numMotifInjected),'_',num2str(Name_OriginalSeries(pip)),'_',num2str(numInstancesinjected),'_instance_',num2str(NAME),'_',num2str(percentagerandomwalk)]
                        TSbaseRandom= [BaseName,num2str(numMotifInjected),'_',num2str(Name_OriginalSeries(pip)),'_',num2str(numInstancesinjected),'_instance_',num2str(NAME),'_',num2str(0)];
                        if definitiveindex>4
                            TEST=[BaseName,num2str(numMotifInjected),'_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME),'_',num2str(percentagerandomwalk),'NoShift']
                            TSbaseRandom= [BaseName,num2str(numMotifInjected),'_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME),'_',num2str(0),'NoShift'];
                        end
                        %TEST=[BaseName,'_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME),'_',num2str(percentagerandomwalk)]
                        
                        TS_name=num2str(TEST);
                        %                     TSbaseRandom= [BaseName,'_',num2str(Name_OriginalSeries(pip)),'_instance_',num2str(NAME),'_',num2str(0)];
                        
                        data=csvread([datasetPath,'data\',TS_name,'.csv'])';%csvread('D:\Motif_Results\Datasets\SynteticDataset\data\Mocap_test1.csv');
                        data(isnan(data))=0;
                        if strcmp(Ds_Name,'Mocap')==1
                            data1= csvread([datasetPath,'data\',TSbaseRandom,'.csv'])';
                            data(:,[34,46]) = data1(:,[34,46]);%
                        elseif strcmp(Ds_Name,'Energy')==1
                            sanitycheck= std(data);
                            idxVariate= sanitycheck==0;
                            data1= csvread([datasetPath,'data\',TSbaseRandom,'.csv'])';
                            data(:,idxVariate) = data1(:,idxVariate);
                        end
                    end
                    
                    Time=[];
                    pro_mul=[];
                    pro_idx=[];
                    motif_idx=[];
                    motif_dim=[];
                    MotifBag=[];
                    
                    sub_len=sublenght+1;%+2;
                    must_dim = [];
                    exc_dim =[];%[34,46]; %[];%[];%% for mocap we have o exclude flat timeseries
                    % if big portion of the timeseries is flat we have perhaps to exclude that variates
                    
                    if(exist([ImageSavingPath,TS_name,'\Lenght_',num2str(sublenght),'\'],'dir')==0)
                        mkdir([ImageSavingPath,TS_name,'\Lenght_',num2str(sublenght),'\']);
                    end
                    datasave= [ImageSavingPath,TS_name,'\'];
                    tic;
                    [pro_mul, pro_idx] = ...
                        mstamp(data, sub_len, must_dim, exc_dim);
                    TIME(1)= toc;
                    %             pro_mul = pro_mul(:, 1:end-length(exc_dim));
                    %             pro_idx = pro_idx(:, 1:end-length(exc_dim));
                    save([datasave,'mstampStep1_',TS_name,'.mat'],'pro_mul','pro_idx','sub_len','data','TIME');
                    
                    %% alternative 1.b: the inclusion
                    % in the toy data, the first dimension only consist of random walk.
                    % Forcing the algorithm to consider the first dimension worsen the result.
                    
                    % must_dim = [1];
                    % exc_dim = [];
                    % [pro_mul, pro_idx] = ...
                    %     mstamp(data, sub_len, must_dim, exc_dim);
                    
                    %% alternative 1.c: the exclusion
                    % We can also do exclusion. By blacklist one of the dimension that contains
                    % meaningful motif, we no longer can find a meaningful 2-dimensional motif.
                    % However, the MDL-based unconstrained search method will correctly provide
                    % us the 1-dimensional motif
                    
                    % must_dim = [];
                    % exc_dim = [3];
                    % [pro_mul, pro_idx] = ...
                    %     mstamp(data, sub_len, must_dim, exc_dim);
                    % pro_mul = pro_mul(:, 1:2);
                    % pro_idx = pro_idx(:, 1:2);
                    % data = data(:, 1:2);
                    
                    %% alternative 2: using Parallel Computing Toolbox
                    
                    % n_work = 4;
                    % [pro_mul, pro_idx] = ...
                    %     mstamp_par(data, sub_len, n_work);
                    
                    %% alternative 3: using the anytime version stop at 10%
                    % the guided search is able to find the motif mostly
                    % however, the MDL-based method's output is less stable due to both method
                    % are approximated method
                    
                    % pct_stop = 0.1;
                    % [pro_mul, pro_idx] = mstamp_any(data, sub_len, pct_stop);
                    
                    
                    %% guided search for 2-dimensional motif
                    % n_dim = 2; % we want the top 2-dimensional motif
                    % [motif_idx, motif_dim] = guide_serach(...
                    %     data, sub_len, pro_mul, pro_idx, n_dim);
                    % plot_motif_on_data(data, sub_len, motif_idx, motif_dim);
                    
                    
                    %% extract motif using the MDL-based unconstrained search method
                    n_bit = 4; % number of bit for discretization
                    k = inf;%2; % number of motif to retrieve
                    
                    tic
                    [motif_idx, motif_dim] = unconstrain_search(...
                        data, sub_len, pro_mul, pro_idx, n_bit, k);%,2);
                    %         plot_motif_on_data(data, sub_len, motif_idx, motif_dim);
                    TIME(2)=toc;
                    save([datasave,'mstampStep2_',TS_name,'.mat'],'motif_idx', 'motif_dim','TIME');
                    %% bag of motifs using MDL unconstrained search
                    tic;
                    if(size(motif_idx,1)~=0)
                        [allStartingMotifs,allMotifDepd] = unifyAllInstances (motif_idx,motif_dim,pro_idx);
                        
                        for methodid=1:numofMethod
                            if methodid==1
                                MotifBag_mstamp = adaptiveKmedoids(data,allStartingMotifs,allMotifDepd,sub_len,n_bit,0.02);%0.003);%data,motif_idx,motif_dim,sub_len,n_bit, k,pro_idx);
                                
                                TIME(3)=toc;
                                MotifBag=MotifBag_mstamp;
                                
                                if(saveMotifImages==1)
                                    for i=1:size(MotifBag,2)
                                        figure1 = plot_RMTmotif_on_data(data', MotifBag{i}.startIdx, MotifBag{i}.depd,MotifBag{i}.Tscope);
                                        %plot_motif_on_data(data, sub_len, MotifBag{i}.idx, MotifBag{i}.depd);
                                        
                                        filename=[ImageSavingPath,TS_name,'\Lenght_',num2str(sublenght),'\TS_',TS_name,'BoM_',num2str(i),'.eps'];
                                        saveas(figure1,filename,'epsc');
                                    end
                                    close all;
                                    
                                end
                                
                                save ([datasave,'Motif_output_',TS_name,'Lenght_',num2str(sublenght),'.mat'],'pro_mul','pro_idx','motif_dim','motif_idx','MotifBag_mstamp');
                                csvwrite([datasave,'Time_',TS_name,'BoM_',num2str(i),'Lenght_',num2str(sublenght),'.xls'],TIME');
                                
                                clear('MotifBag_mstamp');
                            elseif methodid==2
                                MotifBag_mstamp = adaptiveKmedoidsAdvanced(data,allStartingMotifs,allMotifDepd,sub_len,n_bit,0.02);%0.003);%data,motif_idx,motif_dim,sub_len,n_bit, k,pro_idx);
                                
                                TIME(3)=toc;
                                MotifBag=MotifBag_mstamp;
                                
                                if(saveMotifImages==1)
                                    for i=1:size(MotifBag,2)
                                        figure1 = plot_RMTmotif_on_data(data', MotifBag{i}.startIdx, MotifBag{i}.depd,MotifBag{i}.Tscope);
                                        %plot_motif_on_data(data, sub_len, MotifBag{i}.idx, MotifBag{i}.depd);
                                        
                                        filename=[ImageSavingPath,TS_name,'\Lenght_',num2str(sublenght),'\TS_',TS_name,'BoM_',num2str(i),'.eps'];
                                        saveas(figure1,filename,'epsc');
                                    end
                                    close all;
                                    
                                end
                                
                                save ([datasave,'Method2_Motif_output_',TS_name,'Lenght_',num2str(sublenght),'.mat'],'pro_mul','pro_idx','motif_dim','motif_idx','MotifBag_mstamp');
                                %                                         csvwrite([datasave,'Time_',TS_name,'BoM_',num2str(i),'Lenght_',num2str(sublenght),'.xls'],TIME');
                                
                            end
                        end
                        clear('pro_mul','pro_idx','motif_dim','motif_idx','motif_idx', 'motif_dim','TIME','data');
                    else
                        xlswrite([ImageSavingPath,'Problem_',TS_name,'Lenght_',num2str(sublenght),'.xls'],'Problem with this file');
                        
                    end
                end
            end
        end
    end
end
