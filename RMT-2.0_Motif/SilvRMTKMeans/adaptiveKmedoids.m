function [MotifBag_mstamp] = adaptiveKmedoids(data,allMotif,allMotifDepd,sub_len,n_bit,saturation)

    startK = 3;
    Step =2;
    split_pt = get_desc_split_pt(n_bit);
    %% Discretize the timeseries sections
    DataMatrix = [];
    DiscreteDataMatrix=[];
    for i = 1: size(allMotif,1)
        motif_1= data(allMotif(i):allMotif(i) + sub_len - 1, :);
        DiscreteDataMatrix(:,:,i)= discretization(motif_1, split_pt);
        DataMatrix(:,:,i)=motif_1;
    end

    inertia=[];   
    tryK=[];
    itr=1;
   isFound=false;
   while(~isFound)

    [C,mu,meanKmeans, D]=KmedoidsMStamp(DiscreteDataMatrix,allMotifDepd,startK,false,n_bit,DataMatrix);
% labels of Clusters
    labels= unique(C);
%% computeinertia
       if(itr==1)
         inertia=[inertia,meanKmeans];
         tryK=[tryK,startK];
         startK=startK+Step;
       else
         inertia=[inertia,meanKmeans];
         tryK=[tryK,startK];
         error = abs(inertia(itr) - inertia(itr-1));
            if error<=saturation || startK >= (size(DataMatrix,3)-2)
%             eva = evalclusters(features1(11:end,:)',evaluation,'CalinskiHarabasz');
                isFound=true;
            end
        startK=startK+Step;  
       end
       if(~isFound)
         itr=itr+1;
       end
    end
MotifBag_mstamp=[];
for i=1:startK
IDX = C==i;
MotifBag_mstamp{i}.startIdx = allMotif(IDX);
    for iterator=1:size(IDX,1)
        MotifBag_mstamp{i}.depd{iterator}=allMotifDepd{IDX(iterator)};
        MotifBag_mstamp{i}.Tscope{iterator}=allMotif(IDX(iterator))+ sub_len;
    end

end

'job done'


        
        
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