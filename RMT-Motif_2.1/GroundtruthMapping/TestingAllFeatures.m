clc;
clear;

path='D:/Motif_Results/Datasets/SynteticDataset/BirdSong/BirdSong Motifs 1 2 3 same variate multisize/';
algfolder='Features_RMT/';
featuresName='Motif1_3_instance_1_0.5';

load([path,algfolder,featuresName,'/feature_',featuresName,'.mat']);
depdn= csvread([path,algfolder,featuresName,'/DistancesDescriptor/DepdScale_IM_',featuresName,'_DepO_2_TimeO_2.csv']);
frame=frame1;

groundtruth=csvread([path,'data\IndexEmbeddedFeatures\FeaturePosition_',featuresName,'.csv']);
groundtruth_Dependency = csvread([path,'data\IndexEmbeddedFeatures\dpscale_',featuresName,'.csv']);
setFeatures=[];
setDpd=[];
for i=1:size(frame,2)
    i;
    ismofifFeature=false;
    j=1;
    timescope= frame(4,i)*3;
    timescopeFeature= round(frame(2,i)-timescope) : round(frame(2,i)+timescope);
    VscopeFeatures= depdn(depdn(:,i)>0,i);
    while (ismofifFeature==false & j<=size(groundtruth,1))
        j;
        timescopeinstance = groundtruth(j,3):groundtruth(j,4);
        vscopeinstance    = groundtruth_Dependency(groundtruth_Dependency(:,j)>0,j);
        TimeOverlapping=computeTimeOverlap(timescopeFeature(1),timescopeFeature(end),groundtruth(j,3),groundtruth(j,4));
        variateOverlapping = size(intersect(VscopeFeatures,vscopeinstance),1)/size(VscopeFeatures,1);
        if(TimeOverlapping >0 & variateOverlapping >0)
            ismofifFeature=true
            setFeatures= [setFeatures,frame(:,i)];
            setDpd = [setDpd,depdn(:,i)];
        end
        j=j+1;
    end
end

percentageOverlapping=[10,25,50,75,90,100];
SetDividedbypercentage= [];
SetVaraitesDividedbyPercentage=[];
for i=1:size(percentageOverlapping,2)
    SetDividedbypercentage{i}=[];
    SetVaraitesDividedbyPercentage{i}=[];
end

MappingFeatures=[];
for i=1: size(setFeatures,2)
    timescope= setFeatures(4,i)*3;
    timescopeFeature= round(setFeatures(2,i)-timescope) : round(setFeatures(2,i)+timescope);
    VscopeFeatures= setDpd(setDpd(:,i)>0,i);
    TimeScore=0;
    Varaitescore=0;
    BestInstanceIDX=0;
    for j=1:size(groundtruth,1)
        timescopeinstance = groundtruth(j,3):groundtruth(j,4);
        vscopeinstance    = groundtruth_Dependency(groundtruth_Dependency(:,j)>0,j);
        
        TimeOverlapping=computeTimeOverlap(timescopeFeature(1),timescopeFeature(end),groundtruth(j,3),groundtruth(j,4));
        variateOverlapping = size(intersect(VscopeFeatures,vscopeinstance),1)/size(VscopeFeatures,1);
        
        if(TimeOverlapping >0 & variateOverlapping >0)
            % condition to modify the score
            if (TimeOverlapping *variateOverlapping > TimeScore*Varaitescore)
                TimeScore=TimeOverlapping;
                Varaitescore= variateOverlapping;
                BestInstanceIDX=j;
            end
        end
    end
    Score = TimeScore*Varaitescore;
    if (Score<=0.1)
        idxSET=1;
        SetDividedbypercentage{idxSET}=[SetDividedbypercentage{idxSET},setFeatures(:,i)];
        SetVaraitesDividedbyPercentage{idxSET}=[SetVaraitesDividedbyPercentage{idxSET},setDpd(:,i)];
    elseif(Score <=0.25)
        idxSET=2;
        SetDividedbypercentage{idxSET}=[SetDividedbypercentage{idxSET},setFeatures(:,i)];
        SetVaraitesDividedbyPercentage{idxSET}=[SetVaraitesDividedbyPercentage{idxSET},setDpd(:,i)];
    elseif(Score <=0.5)
        idxSET=3;
        SetDividedbypercentage{idxSET}=[SetDividedbypercentage{idxSET},setFeatures(:,i)];
        SetVaraitesDividedbyPercentage{idxSET}=[SetVaraitesDividedbyPercentage{idxSET},setDpd(:,i)];
    elseif(Score <=0.75)
        idxSET=4;
        SetDividedbypercentage{idxSET}=[SetDividedbypercentage{idxSET},setFeatures(:,i)];
        SetVaraitesDividedbyPercentage{idxSET}=[SetVaraitesDividedbyPercentage{idxSET},setDpd(:,i)];
    elseif(Score <=0.9)
        idxSET=5;
        SetDividedbypercentage{idxSET}=[SetDividedbypercentage{idxSET},setFeatures(:,i)];
        SetVaraitesDividedbyPercentage{idxSET}=[SetVaraitesDividedbyPercentage{idxSET},setDpd(:,i)];
    elseif(Score <= 1)
        idxSET=6;
        SetDividedbypercentage{idxSET}=[SetDividedbypercentage{idxSET},setFeatures(:,i)];
        SetVaraitesDividedbyPercentage{idxSET}=[SetVaraitesDividedbyPercentage{idxSET},setDpd(:,i)];
    end
    MappingFeatures=[MappingFeatures;[i,timescopeFeature(1),timescopeFeature(end),groundtruth(BestInstanceIDX,:),TimeScore,Varaitescore]];
    

end
   Testingpath=[path,algfolder,featuresName,'\TESTALLF\'];
   mkdir(Testingpath);
   csvwrite([Testingpath,'AllMotifsFeatures.csv'],setFeatures);
   csvwrite([Testingpath,'AllMotifsFeaturesDepd.csv'],setDpd);
   csvwrite([Testingpath,'AllMotifsFeaturesMapped.csv'],MappingFeatures);
   save([Testingpath,'AllMotifsFeaturesByscore.mat'],'SetDividedbypercentage','SetVaraitesDividedbyPercentage');

