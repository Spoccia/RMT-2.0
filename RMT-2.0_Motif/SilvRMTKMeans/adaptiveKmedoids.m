function [Cluster Codebook,distance, allpairdistances] = adaptiveKmedoids(data,allMotif,allMotifDepd,sub_len,n_bit)

startK = 3;
split_pt = get_desc_split_pt(n_bit);
%% Discretize the timeseries sections
DataMatrix = [];
DiscreteDataMatrix=[];
for i = 1: size(allMotif,1)
    motif_1= data(allMotif(i):allMotif(i) + sub_len - 1, :);
    DiscreteDataMatrix(:,:,i)= discretization(motif_1, split_pt);
    DataMatrix(:,:,i)=motif_1;
end
   

[C,mu,SUMD, D]=KmedoidsMStamp(DiscreteDataMatrix,allMotifDepd,startK,false,n_bit,DataMatrix);


        
        
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