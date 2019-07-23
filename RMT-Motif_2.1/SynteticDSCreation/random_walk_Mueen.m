%(c)Eamonn Keogh and Abdullah Mueen
%this code generate a set of multivariate RandomWalks without bounding
function data = random_walk_Mueen(length_of_ts,number_of_ts)
 
% Creates some test data.
 
data(length_of_ts*number_of_ts)  =  1;
 
 
for i = 1 : number_of_ts
    
    data(i) = 0; 
    p = 0;
    for j = 2 : length_of_ts
        r= randn;
        c = p + r;
        data((j-1)*number_of_ts+i) = c;
        p = c;
    end;
      
end;
data = reshape(data,number_of_ts,length_of_ts);


