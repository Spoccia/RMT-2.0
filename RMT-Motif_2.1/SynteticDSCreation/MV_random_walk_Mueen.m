function data = MV_random_walk_Mueen(length_of_ts,number_of_variates,statistics)
%%Statistics:
% Statistics(1,variate)= minimum average value
% Statistics(2,variate)= maximum average value
% Statistics(3,variate)= STD average value
% Statistics(4,varaite)= Average displacement for variates across all dataset
% Statistics(5,variate)= Mean of all the  timeseries varaites
% Statistics(6,vatriate) =  interval  between max and min for each series

%% Put the max as min+ minimuminteval
statistics(2,:)= statistics(1,:)+statistics(6,:);
statistics (5,:)= mean([statistics(1,:);statistics(2,:)]);
data(number_of_variates,length_of_ts)  =  1;
data(:,1)= statistics(5,:)';
c=zeros(number_of_variates,length_of_ts);
p=data;
for timeid =2: length_of_ts
    r= rand(1)*statistics(3,1);
%     r= randn;%statistics(3,1)*
    if ((p(1,timeid-1) + r) <= statistics(2,1)) & ((p(1,timeid-1) + r) >= statistics(1,1)); %band of random walk
        c(1,timeid) = p(1,timeid-1) + r;
        data(1,timeid) = c(1,timeid);
    elseif ((p(1,timeid-1) - r) >= statistics(1,1)) & ((p(1,timeid-1) - r) <= statistics(2,1));%band of random walk
        c(1,timeid) = p(1,timeid-1) - r;
        data(1,timeid) = c(1,timeid);
    elseif ((p(1,timeid-1) + r) >= statistics(1,1)) & ((p(1,timeid-1) + r) <= statistics(2,1));%band of random walk
        c(1,timeid) = p(1,timeid-1) + r;
        data(1,timeid) = c(1,timeid);
    else
        temp =(p(1,timeid-1) + r);
        temp2=(p(1,timeid-1) - r);
         if abs(temp-statistics(2,1))<abs(temp2-statistics(1,1))
                r= statistics(2,1) - p(1,timeid-1);
                c(1,timeid) = p(1,timeid-1) + r;
                data(1,timeid) = c(1,timeid);
            else
                r= p(1,timeid-1)-statistics(1,1);
                c(1,timeid) = p(1,timeid-1) - r;
                data(1,timeid) = c(1,timeid);
            end
        'WTF no values suitable'
    end
    p(1,timeid) = c(1,timeid);
    for variateid=2: number_of_variates
        r= rand(1)*statistics(3,variateid);
%   r= randn;%statistics(3,variateid)*
        if ((p(variateid,timeid-1) + r) <= statistics(2,variateid)) & ((p(variateid,timeid-1) + r) >= statistics(1,variateid));%band of random walk
            c(variateid,timeid) = p(variateid,timeid-1) + r;
            data(variateid,timeid) = c(variateid,timeid);
        elseif ((p(variateid,timeid-1) - r )>= statistics(1,variateid)) &(( p(variateid,timeid-1) - r )<= statistics(2,variateid));%band of random walk
            c(variateid,timeid) = p(variateid,timeid-1) - r;
            data(variateid,timeid) = c(variateid,timeid);
        elseif ((p(variateid,timeid-1) + r )>= statistics(1,variateid)) &(( p(variateid,timeid-1) + r )<= statistics(2,variateid));%band of random walk
            c(variateid,timeid) = p(variateid,timeid-1) + r;
            data(variateid,timeid) = c(variateid,timeid);
        else            
            temp =(p(variateid,timeid-1) + r);            
            temp2=(p(variateid,timeid-1) - r);
            if abs(temp-statistics(2,variateid))<abs(temp2-statistics(1,variateid))
                r= statistics(2,variateid) - p(variateid,timeid-1);
                 c(variateid,timeid) = p(variateid,timeid-1) + r;
                data(variateid,timeid) = c(variateid,timeid);
            else
                r= p(variateid,timeid-1)-statistics(1,variateid);
                c(variateid,timeid) = p(variateid,timeid-1) - r;
            data(variateid,timeid) = c(variateid,timeid);
            end
            'WTF no values suitable'
        end
        p(variateid,timeid) = c(variateid,timeid);
        
    end
end
'End'
% for i = 1 : number_of_ts
%     data(i) = 0;
%     p = 0;
%     for j = 2 : length_of_ts
%         c = p + randn;
%         data((j-1)*number_of_ts+i) = c;
%         p = c;
%     end;
%
% end;
% data = reshape(data,number_of_ts,length_of_ts);
% end