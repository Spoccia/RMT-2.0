function [D] = DistancesTS_MP(TSSection,NumWindows,depd)
alphabet_size=6;
D=[];%zeros(size(TSSection,3),size(TSSection,3),size(TSSection,1));
Kvariate = size(depd{1},1);
 for i= 1: size(TSSection,3)
        variate=[];
        for j= i: size(TSSection,3)
            if(i==j)
                D(i,j) = inf; 
            else
                dist2features=zeros(1,size(TSSection,1));
                for k =1:size(TSSection,1)
                    dist2features(k)= min_dist(TSSection(k,:,i), TSSection(k,:,j), alphabet_size,NumWindows);
%                 D(i,j) = D(i,j)+a;%sum(sum(abs(TSSection(:,:,i) - TSSection(:,:,j))));
                end 
                [values,sortIDX ]= sort (dist2features);
%                 sortIDX = sortIDX(1:Kvariate);
                % get Top k variates how to break the tie
                uniquesortedscore = unique(values);
                top=1;
                fin=false;
                Index=[];
                while fin~=true
                    best = sortIDX (values==uniquesortedscore(top));
                    Index =[Index, best];%sortIDX (values==uniquesortedscore(top))];
                    if(size(Index,1)>= size(depd{i},1))
                        fin=true;
                    else
                        top=top+1;
                    end
                end
                % if  intersection of topk variate contains varaite of the instance similarity = size(intersection variate topk and varaite timeseries) 
                bestvariate= intersect(depd{i},sortIDX(Index));
                % then score of distance for this variates 
                D{i,j}.bestvatiate = bestvariate;%[values,sortIDX];%sum(dist2features)/size(TSSection,1);%D(i,j)/size(TSSection,1);
                D{i,j}.value= sum(dist2features(depd{i}));
                D{j,i} = D{i,j};
            end
        end
 end


end