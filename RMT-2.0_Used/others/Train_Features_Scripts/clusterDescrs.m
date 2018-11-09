function Xdescrs = clusterDescrs(descrs, descrRange, resolution)
% descrRange 2 x 128  matrix -- 128 descriptor dimension
% return matrix is the descriptor with resolution information
% resolution is the number of grouped time series
Xdescrs = zeros(size(descrs));
descrBucket = zeros(resolution+1, size(descrRange, 2));
delta = (descrRange(2, :) - descrRange(1, :))/resolution;
for i = 1: resolution+1
   if(i == 1)
       descrBucket (i, :) = descrRange(1, :);
   else
       descrBucket (i, :) = descrBucket(i-1, :) + delta; 
   end
end

for i = 1 : size(descrs, 1)
% row by row to make sure descr fall into bucket
  for j = 1 : size(descrs, 2)
  % column dimension
      for k = 1 : size(descrBucket, 1)-1
      % resolution level
          if(descrs(i, j) >= descrBucket(k, j) && descrs(i, j) < descrBucket(k+1, j))
              Xdescrs(i, j) = k;
              break;
          else
              Xdescrs(i, j) = 0;
          end
      end
  end
end

end

