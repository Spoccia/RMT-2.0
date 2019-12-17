




%'D:\Motif_Results\Datasets\Mocap\Features_RMT\';
Dset='BirdSong';%'Mocap';%'Energy';%
DestDataPath = ['D:\Motif_Results\Datasets\SynteticDataset\',Dset,'\',Dset,' Motifs 1 2 3 same variate multisize\data\'];
%' Motif 10 multilength\data\'];%,Coherent Shift Variate 1M ',Dset,'\instancemultisize\'];
FeaturePath = ['D:\Motif_Results\Datasets\',Dset,'\Features_RMT\'];
%DestDataPath = 'D:\Motif_Results\Datasets\BirdSong\';%Energy\';%Mocap\';
DepO=2;
DepT=2;
nummotifs=3;

load([DestDataPath,'\FeaturesToInject\allTSid.mat']);
TSCOnsidered=length(AllTS);
%AllTS=sort(AllTS);
%AllTS= AllTS(1:80);%randperm(184,TSCOnsidered);%randi([1,154],1,TSCOnsidered);
addTS=[]
for numberofTS=1:150%TSCOnsidered
    TsNumber=numberofTS;%AllTS(numberofTS);
    TS_name = num2str(numberofTS);%AllTS(numberofTS));
    
    savepath1 = [FeaturePath,TS_name,'/feature_',TS_name,'.mat'];
    savepath2 = [FeaturePath,TS_name,'/idm_',TS_name,'.mat'];
    savepath3 = [FeaturePath,TS_name,'/MetaData_',TS_name,'.mat'];
    load(savepath1);
    load(savepath2);
    load(savepath3);
    
    indexfeatureGroup = (frame1(6,:)==2 & frame1(5,:)==2);
    X=frame1(:,indexfeatureGroup);
%% DeComment this
%     Check= sum(X(11:end,:)>eps);
%     X(:,Check<=64)=[];

    [rows,colmn]= size(X);
    dpscale = csvread(strcat(FeaturePath,TS_name,'/DistancesDescriptor\DepdScale_IM_',TS_name,'_DepO_',num2str(DepO),'_TimeO_',num2str(DepT),'.csv'));
    maxSigmaT= max(X(4,:));
    indexmaxsigmaT= X(4,:)==maxSigmaT;
    X=X(:,indexmaxsigmaT);
    dpscale =dpscale (:,indexmaxsigmaT);
%% DeComment this
%     dpscale(:,Check<=64)=[];
%     indexfeatureGroup= (X(4,:)==max(X(4,:)));
%     X=X(:,indexfeatureGroup) ;
%    dpscale=(dpscale(:,indexfeatureGroup)); 
%% Comment this for notrmal feature selection this section is for  multi variate groups    
%     depcount = sum(dpscale>0);
%     dpscale=dpscale(:,depcount==3);
%     X=X(:,depcount==3);
%%
    Features=[];
    Dependency=[];
    i=1;
    if size(X,2)==0
     TS_name
    end

    try
    while i<=nummotifs %& size(X,2)>nummotifs %for i=1:nummotifs
        random= randi([1,size(X,2)],1,1);
        A = X(:, random);
        B =dpscale(:,random);
        
        
        isokthefeature=0;
        if(size(Dependency,2)~=0)
            isokthefeature=zeros(1,size(Dependency,2));
            for actDEPD=1:size(Dependency,2)
%                 checkfor10motifs= size(intersect(Dependency(Dependency(:,actDEPD)>0,actDEPD),B(B(:,1)>0,1)),1)/...
%                                   size(union(Dependency(Dependency(:,actDEPD)>0,actDEPD),B(B(:,1)>0,1)),1);
%                 isokthefeature(actDEPD)= checkfor10motifs>0.6 | size(B(B(:,1)>0,1),1)== size(intersect(Dependency(Dependency(:,actDEPD)>0,actDEPD),B(B(:,1)>0,1)),1);
%                 %size(intersect(Dependency(Dependency(:,actDEPD)>0,actDEPD),B(B(:,1)>0,1)),1); %For everithing
                %% if else for Birdsong
                if size(intersect(Dependency(Dependency(:,actDEPD)>0,actDEPD),B(B(:,1)>0,1)),1) ~= size(B(B(:,1)>0,1),1)%  size(union(Dependency(Dependency(:,actDEPD)>0,actDEPD),B(B(:,1)>0,1)),1)
                    isokthefeature(actDEPD)=0;
                else
                    isokthefeature(actDEPD)=1;
                end
            end
        end
        isokthefeature=sum(isokthefeature);
        if isokthefeature==0
        Features =[Features,A];
        Dependency= [Dependency,B];
        i=i+1;
        end
        index = X(1,:)==A(1,1);
        dpscale(:,index) =[];
        X(:,index) =[];
        
    end

    if(exist([DestDataPath,'\FeaturesToInject\'],'dir')==0)
        mkdir([DestDataPath,'\FeaturesToInject\']);
    end
    addTS=[addTS,TsNumber];
    csvwrite([DestDataPath,'\FeaturesToInject\','Depd',TS_name,'.csv'],Dependency);
    csvwrite([DestDataPath,'\FeaturesToInject\','Features',TS_name,'.csv'],Features);
    catch
        TS_name
        'Problems'
    end
end
idx= randperm(length(addTS));
idx=idx(1:30);
AllTS=addTS(1,idx);
save([DestDataPath,'\FeaturesToInject\allTSid.mat'],'AllTS');
