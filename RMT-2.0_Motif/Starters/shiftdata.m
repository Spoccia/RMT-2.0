path = 'D:\BirdSong\data\'
destpath = 'D:\BirdSong\data1\';

for i= 1:154
    data= csvread([path,num2str(i),'.csv']);
    
    data1= zeros(size(data));
    data1(:,1:floor(size(data,2)/2))=data(:,2:floor(size(data,2)/2)+1);
    data1(:,floor(size(data,2)/2)+1) =data(:,1);
    data1(:,floor(size(data,2)/2)+2:size(data,2))=data(:,floor(size(data,2)/2)+2:size(data,2));
    csvwrite([destpath,num2str(i),'.csv'],data1);
end