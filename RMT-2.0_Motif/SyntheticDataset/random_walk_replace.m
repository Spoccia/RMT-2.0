function [rndWalks3] = random_walk_replace(rndWalks1, rndWalks2, injectedVariates1)
num_of_injected_features = size(injectedVariates1, 2);

rndWalks3 = rndWalks1;
time_stamp_1 = size(rndWalks1, 2);
time_stamp_2 = size(rndWalks2, 2);
% min_time_stamp = min(size(rndWalks1, 2), size(rndWalks2, 2));
% max_time_stemp = max(size(rndWalks1, 2), size(rndWalks2, 2));
for i = 1 : num_of_injected_features
    variate_of_interest = nonzeros(injectedVariates1(:, i));
    if(time_stamp_1 ~= time_stamp_2)
        % rndWalks3(variate_of_interest, 1 : min_time_stamp) = rndWalks2(variate_of_interest, 1 : min_time_stamp);
        if(time_stamp_1 < time_stamp_2)
            % rndWalks3(:, :) = rndWalks3(:, :) + rndWalks2(:, time_stamp_1 + 1 : time_stamp_2);
            rndWalks3= [rndWalks3(:, :) rndWalks2(:, time_stamp_1 + 1 : time_stamp_2)];
        end
    else
        rndWalks3(variate_of_interest, :) = rndWalks2(variate_of_interest, :);
    end
end
