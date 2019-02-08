
clc; 
clear;
depd=[];
for i=1:184
depd1 = csvread(['D:\Motif_Results\Datasets\Mocap\Features_RMT\',num2str(2),'\DistancesDescriptor\DepdScale_IM_',num2str(2),'_DepO_2_TimeO_2.csv']);
depd =[depd,depd1];
end
% load ('D:\Motif_Results\Datasets\Mocap\Features_RMT\2\feature_2.mat');
% load ('D:\Motif_Results\Datasets\Mocap\Features_RMT\2\idm_2.mat');

[uniquedepd, featuresid,rows] = unique(depd','rows');
uniquedepd = uniquedepd';
% frame  =frame1(:,frame1(5,:)==2 & frame1(6,:)==2);
% UniqueFrames = frame(:,featuresid);
sizedepd = zeros(1,size(uniquedepd,2));
for i=1:size(uniquedepd,2)
sizedep(i)=size(uniquedepd(uniquedepd(:,i)>0,i),1);
end
AllpossibleSize = unique(sizedep);

orderedDepdBySize=[];%zeros(size(sizedep));
for i =1 : size(AllpossibleSize,2);
    orderedDepdBySize{AllpossibleSize(i)} = uniquedepd(:,sizedep == AllpossibleSize(i));%[orderedDepdBySize,uniquedepd(:,sizedep == AllpossibleSize(i))];
end

save('D:\Motif_Results\Datasets\SynteticDataset\Mocap\Coherent Shift Variate 1M Mocap\allPossibleVariatesGroups.mat','orderedDepdBySize');
%temp=idm1{1,2}(uniquedepd(uniquedepd(:,1)>0,1));
