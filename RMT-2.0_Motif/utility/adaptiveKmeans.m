function  [C1,mu1,inertia,startK]=adaptiveKmeans(features1,K_start,saturation)
   isFound=false;
   inertia=[];
   itr=1;
    startK=K_start;
   while(~isFound)
      
       [C1,mu1,SUMD] = kmeans(features1(11:size(features1,1),:)',startK,'Distance','sqeuclidean');%'cosine');%
       %% computeinertia
       if(itr==1)
       inertia=[inertia,sum(SUMD)];
       startK=startK+1;
       end
       if(itr>1)
        inertia=[inertia,sum(SUMD)];
        error = abs(inertia(itr) - inertia(itr-1));
        if error<=saturation
            isFound=true;
        end
        startK=startK+1;        
       end
       if(~isFound)
       itr=itr+1;
       end
   end
end