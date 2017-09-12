function [ idx,idx_Entropy ] = siftlocalmax_directed_MAT_Sil_EntropyAverage( input,threshold, N, M, sminD, sminT, Stime, Sdepd)%,sigmaTime,otime)
%% compute local extrema
% Stime --- row
% Sdepd --- column
% N  -- outgoing neighbours
% M -- incoming neighbours

% nneighbours = 3^size(size(input),1)-1; % in this case 26
% Skip the first and the last

% dss.octave{OTime, ODepd}{1} = RowVector; % depd difference
% dss.octave{OTime, ODepd}{2} = ColumnVector; % time difference
% dss.octave{OTime, ODepd}{3} = DiaVectorDown; % both directions

% input{1} -- depd diff
% input{2} -- time diff
% input{3} -- both diff

%     ttScale = size(input{2}, 3);
%     tdScale = size(input{2}, 4);
%
%     dtScale = size(input{1}, 3);
%     ddScale = size(input{1}, 4);
%
%     btScale = size(input{3}, 3);
%     bdScale = size(input{3}, 4);

idx = [];
timeStep = size(input{2}, 1);
depdStep = size(input{2}, 2);
numT_scale = Stime+1 - sminT;
numD_scale = Sdepd+1 - sminD;
timeScale = numT_scale-1;%Stime-1;
depdScale = numD_scale-1;%Sdepd-1;
tmax = 1;

% Precompute convolutions across dimensions
TD_CurrentScale_M=zeros(size(input{2}));
TD_CurrentScale_N=zeros(size(input{2}));
VD_CurrentScale_M=zeros(size(input{1}));
VD_CurrentScale_N=zeros(size(input{1}));
BD_CurrentScale_M=zeros(size(input{3}));
BD_CurrentScale_N=zeros(size(input{3}));
%tic
% scale Dependency
for i=1:size(input{1},3)
    VD_CurrentScale_M(:,:,i) = input{1}(:, :, i)*M(:, :)';
    VD_CurrentScale_N(:,:,i) = input{1}(:, :, i)*N(:, :)';
end
% scale Time
for i=1:size(input{2},3)
    TD_CurrentScale_M(:,:,i) = input{2}(:, :, i)*M(:, :)';
    TD_CurrentScale_N(:,:,i) = input{2}(:, :, i)*N(:, :)';    
end
% scale Both
for i=1:size(input{3},3)
    BD_CurrentScale_M(:,:,i) = input{3}(:, :, i)*M(:, :)';
    BD_CurrentScale_N(:,:,i) = input{3}(:, :, i)*N(:, :)';
end
[combinationScale,minidx]= min([numT_scale,numD_scale]);

for i = 2 : combinationScale-1
    for y = 2 : depdStep - 1
        for x = 2 : timeStep - 1        
            % key points index: (x, y, i, j)
            is_greaterDepd=true;
            is_greaterTime=true;
            is_greaterBoth=true;
            if(threshold ~= -inf )
                is_greaterDepd= input{1}(x, y, i)>=threshold;
                is_greaterTime= input{2}(x, y, i)>=threshold;
                is_greaterBoth= input{3}(x, y, i)>=threshold;
            end
            if(is_greaterDepd & is_greaterTime & is_greaterBoth)
                
                M_mask=M(y, :)>0;
                N_mask=N(y, :)>0;            
                temp = [(input{1}(x, y, i)), (input{2}(x, y, i)), (input{3}(x, y, i))];
                [tmax,idxmax] = max(temp);
                neighbour = zeros(1,69);                
                startNeigh=0;

                
                %% current scale on time direction
%                 TS_Interval=TimeIntervalPre;
                for iii=-1:1
                    
                    neighbour(startNeigh+1) = TD_CurrentScale_M(x-1,y,i+iii);
                    startNeigh= startNeigh+1;
                    %input{2}((x-1), :, i)*M(y, :)';
                    neighbour(startNeigh+1) = TD_CurrentScale_M(x,y,i+iii);%input{2}(x, :, i)*M(y, :)';
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = TD_CurrentScale_M(x+1,y,i+iii);%input{2}((x+1), :, i)*M(y, :)';
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = input{2}((x-1), y, i+iii);
                    startNeigh = startNeigh+1;
                    if(iii~=0)
                        neighbour(startNeigh+1) = input{2}(x, y, i+iii);
                        startNeigh = startNeigh+1;
                    end
                    neighbour(startNeigh+1) = input{2}((x+1), y, i+iii);
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = TD_CurrentScale_N(x-1,y,i+iii);%input{2}((x-1), :, i)*N(y,:)';
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = TD_CurrentScale_N(x,y,i+iii);%input{2}(x, :, i)*N(y,:)';
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = TD_CurrentScale_N(x+1,y,i+iii);%input{2}((x+1), :, i)*N(y,:)';
                    startNeigh = startNeigh+1 ;
                end
                
                for iii=-1:1
                    %% current scale on dependency direction
                    neighbour(startNeigh+1) = VD_CurrentScale_M(x-1,y,i+iii);
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = VD_CurrentScale_M(x,y,i+iii);%input{2}(x, :, i)*M(y, :)';
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = VD_CurrentScale_M(x+1,y,i+iii);%input{2}((x+1), :, i)*M(y, :)';
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = input{1}((x-1), y, i+iii);
                    startNeigh = startNeigh+1;
                    if(iii~=0)
                        neighbour(startNeigh+1) = input{1}(x, y, i+iii);
                        startNeigh = startNeigh+1;
                    end
                    neighbour(startNeigh+1) = input{1}((x+1), y, i+iii);
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = VD_CurrentScale_N(x-1,y,i+iii);%input{2}((x-1), :, i)*N(y,:)';
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = VD_CurrentScale_N(x,y,i+iii);%input{2}(x, :, i)*N(y,:)';
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = VD_CurrentScale_N(x+1,y,i+iii);%input{2}((x+1), :, i)*N(y,:)';
                    startNeigh = startNeigh+1;
                end
                
                
                for iii=-1:1
                    %% current scale on Both direction
                    neighbour(startNeigh+1) = BD_CurrentScale_M(x-1,y,i+iii);
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = BD_CurrentScale_M(x,y,i+iii);
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = BD_CurrentScale_M(x+1,y,i+iii);
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = input{3}((x-1), y, i+iii);
                    startNeigh = startNeigh+1;
                    if(iii~=0)
                        neighbour(startNeigh+1) = input{3}(x, y, i+iii);
                        startNeigh = startNeigh+1;
                    end
                    neighbour(startNeigh+1) = input{3}((x+1), y, i+iii);
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = BD_CurrentScale_N(x-1,y,i+iii);
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = BD_CurrentScale_N(x,y,i+iii);
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = BD_CurrentScale_N(x+1,y,i+iii);
                    startNeigh = startNeigh+1;                    
                end
                
                if(tmax>neighbour(:))% this is a key point(tmax>threshold*abs(neighbour(:)))% this is a key point
                    % if(tmax>abs(neighbour(:)))% this is a key point
                    % if(tmax>neighbour(:))% this is a key point
                    idx = cat(1, idx, [y, x, i, tmax]);
                end
                clear neighbour
            end
        end
    end
end

% neighbour=zeros(1,26); 
% if(minidx==1) % we have other dependency scale
%     is_greaterDepd=true;
%     if(threshold ~= -inf )
%         is_greaterDepd= input{1}(x, y, i)>=threshold;
%     end
%     startNeigh=0;
%     if(is_greaterDepd)
%         for iii=-1:1
%             %% current scale on dependency direction
%             neighbour(startNeigh+1) = VD_CurrentScale_M(x-1,y,i+iii);
%             startNeigh = startNeigh+1;
%             neighbour(startNeigh+1) = VD_CurrentScale_M(x,y,i+iii);%input{2}(x, :, i)*M(y, :)';
%             startNeigh = startNeigh+1;
%             neighbour(startNeigh+1) = VD_CurrentScale_M(x+1,y,i+iii);%input{2}((x+1), :, i)*M(y, :)';
%             startNeigh = startNeigh+1;
%             neighbour(startNeigh+1) = input{1}((x-1), y, i+iii);
%             startNeigh = startNeigh+1;
%             if(iii~=0)
%                 neighbour(startNeigh+1) = input{1}(x, y, i+iii);
%                 startNeigh = startNeigh+1;
%             end
%             neighbour(startNeigh+1) = input{1}((x+1), y, i+iii);
%             startNeigh = startNeigh+1;
%             neighbour(startNeigh+1) = VD_CurrentScale_N(x-1,y,i+iii);%input{2}((x-1), :, i)*N(y,:)';
%             startNeigh = startNeigh+1;
%             neighbour(startNeigh+1) = VD_CurrentScale_N(x,y,i+iii);%input{2}(x, :, i)*N(y,:)';
%             startNeigh = startNeigh+1;
%             neighbour(startNeigh+1) = VD_CurrentScale_N(x+1,y,i+iii);%input{2}((x+1), :, i)*N(y,:)';
%             startNeigh = startNeigh+1;
%         end
%     end
% else % we have more scale
%     is_greaterTime=true;
%     if(threshold ~= -inf )
%         is_greaterTime= input{1}(x, y, i)>=threshold;
%     end
%     startNeigh=0;
%     if(is_greaterTime)
%         for iii=-1:1
%             %% current scale on dependency direction
%             neighbour(startNeigh+1) = VD_CurrentScale_M(x-1,y,i+iii);
%             startNeigh = startNeigh+1;
%             neighbour(startNeigh+1) = VD_CurrentScale_M(x,y,i+iii);%input{2}(x, :, i)*M(y, :)';
%             startNeigh = startNeigh+1;
%             neighbour(startNeigh+1) = VD_CurrentScale_M(x+1,y,i+iii);%input{2}((x+1), :, i)*M(y, :)';
%             startNeigh = startNeigh+1;
%             neighbour(startNeigh+1) = input{1}((x-1), y, i+iii);
%             startNeigh = startNeigh+1;
%             if(iii~=0)
%                 neighbour(startNeigh+1) = input{1}(x, y, i+iii);
%                 startNeigh = startNeigh+1;
%             end
%             neighbour(startNeigh+1) = input{1}((x+1), y, i+iii);
%             startNeigh = startNeigh+1;
%             neighbour(startNeigh+1) = VD_CurrentScale_N(x-1,y,i+iii);%input{2}((x-1), :, i)*N(y,:)';
%             startNeigh = startNeigh+1;
%             neighbour(startNeigh+1) = VD_CurrentScale_N(x,y,i+iii);%input{2}(x, :, i)*N(y,:)';
%             startNeigh = startNeigh+1;
%             neighbour(startNeigh+1) = VD_CurrentScale_N(x+1,y,i+iii);%input{2}((x+1), :, i)*N(y,:)';
%             startNeigh = startNeigh+1;
%         end
%     end
% end

idx = idx';
end