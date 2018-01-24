function D= DistancesTS(TSSection)
     
D=[];

    for i= 1: size(TSSection,3)
        for j= i: size(TSSection,3)
            D(i,j)= TSSection(:,:,i) - TSSection(:,:,j);
            D(j,i)= D(i,j);
        end
    end
end