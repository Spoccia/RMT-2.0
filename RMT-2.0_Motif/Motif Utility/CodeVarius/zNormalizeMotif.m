function motifback =zNormalizeMotif(motif)
    meanB =mean(motif');
    stdB = std(motif');
     motifback=zeros(size(motif));
     [rows,colmn]= size(motif);
   for k=1:rows
       motifback(k,:)= (motif(k,:)-meanB(k))/stdB(k);
   %    TS_D(k,:)= (TS(k,:)-minim(k))/(maxim(k)-minim(k));
   end
end