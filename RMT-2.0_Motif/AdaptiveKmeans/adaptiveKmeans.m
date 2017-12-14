function  [C1,mu1,inertia,tryK,startK]=adaptiveKmeans(features1,K_start,saturation,Step,distance)
   isFound=false;
   inertia=[];
   
   if Step==0
       Step=2;
   end
   itr=1;
    startK=K_start;
    tryK=[];
   while(~isFound)
      
       [C1,mu1,SUMD] = kmeans(features1(11:size(features1,1),:)',startK,'Distance',distance);%'sqeuclidean');%'cosine');%
       %% computeinertia
       if(itr==1)
       inertia=[inertia,sum(SUMD)];
       tryK=[tryK,startK];
       startK=startK+1;
       end
       if(itr>1)
        inertia=[inertia,sum(SUMD)];
        tryK=[tryK,startK];
        error = abs(inertia(itr) - inertia(itr-1));
        if error<=saturation
            isFound=true;
        end
        startK=startK+Step;        
       end
       if(~isFound)
       itr=itr+1;
       end
   end
end