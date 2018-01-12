function temp = rndWalkGeneration(n,m)
%% this function generate n randomwalk Z-Normalized of lenght m
% n = number of randomWalk
% m = size of each randomwalk
temp = zeros(n,m);%rndWalks = zeros(n,m);
    for i=1:n
        RW= cumsum(randn(m, 1));
        rndWalks = (RW - mean(RW)) ...
                        / std(RW, 1); %znormalization
        temp(i,:)= (rndWalks-min(rndWalks))/(max(rndWalks)-min(rndWalks)) ;           
    end
end