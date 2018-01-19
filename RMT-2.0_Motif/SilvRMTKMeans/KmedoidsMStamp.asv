function [C,mu,SUMD, D] = KmedoidsMStamp(DiscreteDataMatrix,mDepd,startK,  verbose,n_bit,DataMatrix)% distFunction, verbose,n_bit)
 % Description
    %   K-medoids clustering
    %
    % Inputs ([]s are optional)
    %   (matrix) X        M,N,C matrix representing a set of count subsequence of
    %                     the original timeseries each one of size M*N
    %   (scalar) K        The number of clusters.
    %   (scalar) [stopIter = .05]
    %                     A scalar between [0, 1]. Stop iterations if the
    %                     improved rate is less than this threshold value.
    %   (func)   [distFunc = @cvEucdist]
    %                     A function handle for distance measure. The function
    %                     must have two arguments for matrix X and Y. See
    %                     cvEucdist.m (Euclidean distance) as a reference.
    %   (bool)   [verbose = false]
    %                     Show progress or not.
    %   (mDepd)  for each timeseries there is the set of dependency on who it is found  the motif 
    %   (n_bit)  numbers of bit for the disctetized representation
%     if ~exist('stopIter', 'var') || isempty(stopIter)
%         stopIter = .05;
%     end
%     if ~exist('distFunc', 'var') || isempty(distFunc)
%         %'not distance input'
%         distFunc = @Distance_RMT_DESC;% @cvEucdist;
%         %distFunc = @Distance_RMT_DESC_AMPL;
%     end
    if ~exist('verbose', 'var') || isempty(verbose)
        verbose = false;
    end
    
    [M N,count] = size(DiscreteDataMatrix);
    if startK > count,
        error('K must be less than or equal to the number of vectors N');
    end
    
    Dist = MstampDfunction(DiscreteDataMatrix,mDepd,n_bit,DiscreteDataMatrix);
    
    MaximumValue = max(Dist);
    
    improvedRatio = Inf;
    distortion = Inf;
    iter = 0;
    numiteration =100;
    idxcentroid = randi([1 size(DataMatrix,3)],1,startK)
    Discrete_Centroids = DiscreteDataMatrix(:,:,idxcentroid);
    Centroid =DataMatrix(:,:,idxcentroid);
    while true
        % Assign each sample to the nearest codeword (centroid)
        d=MstampDfunction(DiscreteDataMatrix,mDepd,n_bit,Discrete_Centroids);
        [dataNearClusterDist, Cluster] = min(d', [], 1);
        
        old_distortion = distortion;
        distortion = mean(dataNearClusterDist); 
        
        % If no more improved, break;
        improvedRatio = 1 - (distortion / old_distortion);
        
        if verbose
            fprintf('%d: improved ratio = %f\n', iter, improvedRatio);
        end
        iter = iter + 1;

        if improvedRatio <= stopIter, break, end;
        if numiteration == iter, break, end;
        
        % Renew Codebook
        for i=1:startK
            idx = find(Cluster == i);
            RealIndex = 1:size(DataMatrix,3);
            RealIndex = RealIndex(idx); 
            
            AllRealsequncesC = DataMatrix(:,:,idx);
            AllQuantizedSeqC = DiscreteDataMatrix(:,:,idx);
            AllCdepd = [];
            averagealllTS = sum(AllRealsequncesC,3)/size(AllRealsequncesC,3);
            split_pt = get_desc_split_pt(n_bit);
            disctrretizeaveragealllTS = discretization(averagealllTS, split_pt);
            for j=1: size(RealIndex,1)
                AllCdepd{j} = mDepd{RealIndex(j)};
            end
            localDistances= MstampDfunction(AllQuantizedSeqC,AllCdepd,n_bit,disctrretizeaveragealllTS);
            [~,newCentroidID] = min(localDistances);
            Discrete_Centroids(:,:,i) = AllQuantizedSeqC(:,:,i);
            Centroid(:,:,i) = AllRealsequncesC(:,:,newCentroidID);
        end
    end
    

    function disc = discretization(motif, split_pt)
    for i = 1:size(motif, 2)
        motif(:, i) = (motif(:, i) - mean(motif(:, i))) / ...
            std(motif(:, i), 1);
    end
    disc = zeros(size(motif));
    for i = 1:length(split_pt)
        disc(motif < split_pt(i) & disc == 0) = i;
    end
    disc(disc == 0) = length(split_pt) + 1;


    function split_pt = get_desc_split_pt(n_bit)
    split_pt = norminv((1:(2^n_bit)-1)/(2^n_bit), 0, 1);

