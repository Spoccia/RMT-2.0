function rndWalks = rndWalkGeneration(n,m)
%% this function generate n randomwalk Z-Normalized of lenght m
% n = number of randomWalk
% m = size of each randomwalk
rndWalks = zeros(n,m);
    for i=1:n
        RW= cumsum(randn(m, 1));
        rndWalks (i,:)= (RW - mean(RW)) ...
                        / std(RW, 1);
    end
end