function [allmotif,allmotifdepd] = unifyAllInstances (motif_idx,motif_dim,pro_idx)
count=1;
allmotif=[];
allmotifdepd=[];
for i = 1: size(motif_idx,1)
    allmotif=[allmotif;motif_idx(i)];
    allmotifdepd{count}=motif_dim{i};
    count=count+1;
    mappedid=pro_idx(motif_idx(i),size(motif_dim{i},2));
    if(size(intersect(mappedid,motif_idx),1)==1)
    else
        allmotif=[allmotif;mappedid];
        allmotifdepd{count}=motif_dim{i};
        count=count+1;
    end
end
end