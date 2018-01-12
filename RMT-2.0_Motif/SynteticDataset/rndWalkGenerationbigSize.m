function [temp,temp1] = rndWalkGenerationbigSize(n,m,data)
%% this function generate n randomwalk Z-Normalized of lenght m
% n = number of randomWalk
% m = size of each randomwalk
minimumV = min(data');
maximumV = max(data');
temp = zeros(n,m);%rndWalks = zeros(n,m);
temp1=temp;
    for i=1:n
        RW= cumsum(randn(m, 1));
        rndWalks = (RW - mean(RW)) ...
                        / std(RW, 1); %znormalization
        temp(i,:)  = (rndWalks-min(rndWalks))/(max(rndWalks)-min(rndWalks)) ;
        
        temp1(i,:) = (temp(i,:)*(maximumV(i)-minimumV(i)))-minimumV(i);
    end
end