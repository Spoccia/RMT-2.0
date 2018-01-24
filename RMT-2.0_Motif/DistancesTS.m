function D= DistancesTS(TSSection)
     
D=zeros(size(TSSection,3));

    for i= 1: size(TSSection,3)
        for j= i: size(TSSection,3)
            if(i==j)
                D(i,j) = inf; 
            else
                D(i,j) = sum(sum(abs(TSSection(:,:,i) - TSSection(:,:,j))));
                D(j,i) = D(i,j);
            end
        end
    end
end