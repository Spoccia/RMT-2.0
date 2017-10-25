function [ idx,idx_Entropy ] = siftlocalmax_directed_MAT_Sil_EntropyConvolutionToPrune( input,threshold, N, M, Stime, Sdepd,sigmaTime,otime)
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
idx_Entropy=[];
timeStep = size(input{2}, 1);
depdStep = size(input{2}, 2);
timeScale = Stime-1;
depdScale = Sdepd-1;
tmax = 1;
TD_CurrentScale_M=zeros(size(input{2}));
TD_CurrentScale_N=zeros(size(input{2}));
VD_CurrentScale_M=zeros(size(input{1}));
VD_CurrentScale_N=zeros(size(input{1}));
BD_CurrentScale_M=zeros(size(input{3}));
BD_CurrentScale_N=zeros(size(input{3}));
%tic
for i=1:timeScale
    TD_CurrentScale_M(:,:,i) = input{2}(:, :, i)*M(:, :)';
    TD_CurrentScale_N(:,:,i) = input{2}(:, :, i)*N(:, :)';
    
    VD_CurrentScale_M(:,:,i) = input{1}(:, :, i)*M(:, :)';
    VD_CurrentScale_N(:,:,i) = input{1}(:, :, i)*N(:, :)';
    
    BD_CurrentScale_M(:,:,i) = input{3}(:, :, i)*M(:, :)';
    BD_CurrentScale_N(:,:,i) = input{3}(:, :, i)*N(:, :)';
    
end
%toc

for i = 2 : timeScale-1
    %   for j = 1 : depdScale
    i
    for y = 2 : depdStep - 1
        for x = 2 : timeStep - 1
        
             if(x==207 & y== 3 )
                 'check'
             end
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
                
                ktime = 2^(1/(Stime-3));
                
                timeScale=i;
                sigmaT      = (sigmaTime*2^(otime-1))*ktime.^(timeScale -1-1);
                sigmaT_Pre  = (sigmaTime*2^(otime-1))*ktime.^(timeScale-1 -1-1);
                sigmaT_Post = (sigmaTime*2^(otime-1))*ktime.^(timeScale+1 -1-1);
                TimeIntervalPre = (round((x-1)-3*sigmaT_Pre):round((x-1)+3*sigmaT_Pre));               
                TimeIntervalPre=TimeIntervalPre(TimeIntervalPre>0 &TimeIntervalPre<timeStep-1);
                
                TimeInterval=(round((x)-3*sigmaT):round((x)+3*sigmaT));
                TimeInterval=TimeInterval(TimeInterval>0 &TimeInterval<timeStep-1);
                TimeIntervalPost=(round((x+1)-3*sigmaT_Post):round((x+1)+3*sigmaT_Post));
                TimeIntervalPost=TimeIntervalPost(TimeIntervalPost>0 &TimeIntervalPost<timeStep-1);
                
                temp = [(input{1}(x, y, i)), (input{2}(x, y, i)), (input{3}(x, y, i))];%[abs(input{1}(x, y, i, j)), abs(input{2}(x, y, i, j)), abs(input{3}(x, y, i, j))];
                % temp = [input{1}(x, y, i, j), input{2}(x, y, i, j), input{3}(x, y, i, j)];
                temp_Entropy=[EntropySingVariate_mex(input{1}(TimeInterval, y, i),threshold), EntropySingVariate_mex(input{2}(TimeInterval, y, i),threshold), EntropySingVariate_mex(input{3}(TimeInterval, y, i),threshold)];
                tmax = max(temp);
                tmax_Entropy=max(temp_Entropy);
                
                neighbour = zeros(1,69);
                neighbour_Entropy=zeros(1,69);
                
                startNeigh=0;
                startNeighEntr=0;
                
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
%                     if(iii==0)
%                         TS_Interval=TimeInterval;
%                     elseif(iii==1)
%                         TS_Interval=TimeIntervalPost;
%                     end
                    sigmaT = (sigmaTime*2^(otime-1))*ktime.^(timeScale -1-1 + iii);
                    TimeIntervalPre = (round((x-1)-3*sigmaT):round((x-1)+3*sigmaT));               
                    TimeIntervalPre=TimeIntervalPre(TimeIntervalPre>0 &TimeIntervalPre<timeStep-1);
                    TimeInterval=(round((x)-3*sigmaT):round((x)+3*sigmaT));
                    TimeInterval=TimeInterval(TimeInterval>0 &TimeInterval<timeStep-1);
                    TimeIntervalPost=(round((x+1)-3*sigmaT_Post):round((x+1)+3*sigmaT_Post));
                    TimeIntervalPost=TimeIntervalPost(TimeIntervalPost>0 &TimeIntervalPost<timeStep-1);
% %% No convolution                    
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(input{2}(TimeIntervalPre, M_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(input{2}(TimeInterval, M_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{2}(TimeIntervalPost, M_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{2}(TimeIntervalPre, y, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     if(iii~=0)
%                         neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(input{2}(TimeInterval, y, i+iii),threshold);
%                         startNeighEntr = startNeighEntr+1;
%                     end
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{2}(TimeIntervalPost, y, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{2}(TimeIntervalPre, N_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{2}(TimeInterval, N_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{2}(TimeIntervalPost, N_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
 %% Convolutionof neighboors                    
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(TD_CurrentScale_M(TimeIntervalPre, y, i+iii),threshold); 
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(TD_CurrentScale_M(TimeInterval,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(TD_CurrentScale_M(TimeIntervalPost,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{2}(TimeIntervalPre, y, i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    if(iii~=0)
                        neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(input{2}(TimeInterval, y, i+iii),threshold);
                        startNeighEntr=startNeighEntr+1;
                    end
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{2}(TimeIntervalPost, y, i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( TD_CurrentScale_N(TimeIntervalPre,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( TD_CurrentScale_N(TimeInterval,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( TD_CurrentScale_N(TimeIntervalPost,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                end
                
%                 TS_Interval=TimeIntervalPre;
                for iii=-1:1
                    %% current scale on dependency direction
                    neighbour(startNeigh+1) = VD_CurrentScale_M(x-1,y,i+iii);
                    startNeigh = startNeigh+1;
                    %input{2}((x-1), :, i)*M(y, :)';
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

                    sigmaT = (sigmaTime*2^(otime-1))*ktime.^(timeScale -1-1 + iii);
                    TimeIntervalPre = (round((x-1)-3*sigmaT):round((x-1)+3*sigmaT));               
                    TimeIntervalPre=TimeIntervalPre(TimeIntervalPre>0 &TimeIntervalPre<timeStep-1);
                    TimeInterval=(round((x)-3*sigmaT):round((x)+3*sigmaT));
                    TimeInterval=TimeInterval(TimeInterval>0 &TimeInterval<timeStep-1);
                    TimeIntervalPost=(round((x+1)-3*sigmaT_Post):round((x+1)+3*sigmaT_Post));
                    TimeIntervalPost=TimeIntervalPost(TimeIntervalPost>0 &TimeIntervalPost<timeStep-1);
% %% No convolution                    
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(input{1}(TimeIntervalPre, M_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(input{1}(TimeInterval, M_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{1}(TimeIntervalPost, M_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{1}(TimeIntervalPre, y, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     if(iii~=0)
%                         neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(input{1}(TimeInterval, y, i+iii),threshold);
%                         startNeighEntr = startNeighEntr+1;
%                     end
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{1}(TimeIntervalPost, y, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{1}(TimeIntervalPre, N_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{1}(TimeInterval, N_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{1}(TimeIntervalPost, N_mask, i+iii),threshold);

%% Convolutionof neighboors                    
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(VD_CurrentScale_M(TimeIntervalPre, y, i+iii),threshold); 
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(VD_CurrentScale_M(TimeInterval,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(VD_CurrentScale_M(TimeIntervalPost,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{1}(TimeIntervalPre, y, i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    if(iii~=0)
                        neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(input{1}(TimeInterval, y, i+iii),threshold);
                        startNeighEntr=startNeighEntr+1;
                    end
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{1}(TimeIntervalPost, y, i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( VD_CurrentScale_N(TimeIntervalPre,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( VD_CurrentScale_N(TimeInterval,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( VD_CurrentScale_N(TimeIntervalPost,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;

                end
                
                
                for iii=-1:1
                    %% current scale on Both direction
                    neighbour(startNeigh+1) = BD_CurrentScale_M(x-1,y,i+iii);
                    startNeigh = startNeigh+1;%input{2}((x-1), :, i)*M(y, :)';
                    neighbour(startNeigh+1) = BD_CurrentScale_M(x,y,i+iii);%input{2}(x, :, i)*M(y, :)';
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = BD_CurrentScale_M(x+1,y,i+iii);%input{2}((x+1), :, i)*M(y, :)';
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = input{3}((x-1), y, i+iii);
                    startNeigh = startNeigh+1;
                    if(iii~=0)
                        neighbour(startNeigh+1) = input{3}(x, y, i+iii);
                        startNeigh = startNeigh+1;
                    end
                    neighbour(startNeigh+1) = input{3}((x+1), y, i+iii);
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = BD_CurrentScale_N(x-1,y,i+iii);%input{2}((x-1), :, i)*N(y,:)';
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = BD_CurrentScale_N(x,y,i+iii);%input{2}(x, :, i)*N(y,:)';
                    startNeigh = startNeigh+1;
                    neighbour(startNeigh+1) = BD_CurrentScale_N(x+1,y,i+iii);%input{2}((x+1), :, i)*N(y,:)';
                    startNeigh = startNeigh+1;
                    
                    sigmaT = (sigmaTime*2^(otime-1))*ktime.^(timeScale -1-1 + iii);
                    TimeIntervalPre = (round((x-1)-3*sigmaT):round((x-1)+3*sigmaT));               
                    TimeIntervalPre=TimeIntervalPre(TimeIntervalPre>0 &TimeIntervalPre<timeStep-1);
                    TimeInterval=(round((x)-3*sigmaT):round((x)+3*sigmaT));
                    TimeInterval=TimeInterval(TimeInterval>0 &TimeInterval<timeStep-1);
                    TimeIntervalPost=(round((x+1)-3*sigmaT_Post):round((x+1)+3*sigmaT_Post));
                    TimeIntervalPost=TimeIntervalPost(TimeIntervalPost>0 &TimeIntervalPost<timeStep-1);
% %% No convolution 
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(input{3}(TimeIntervalPre, M_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(input{3}(TimeInterval, M_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{3}(TimeIntervalPost, M_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{3}(TimeIntervalPre, y, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     if(iii~=0)
%                         neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(input{3}(TimeInterval, y, i+iii),threshold);
%                         startNeighEntr = startNeighEntr+1;
%                     end
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{3}(TimeIntervalPost, y, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{3}(TimeIntervalPre, N_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{3}(TimeInterval, N_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
%                     neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{3}(TimeIntervalPost, N_mask, i+iii),threshold);
%                     startNeighEntr=startNeighEntr+1;
                    
%% Convolutionof neighboors                    
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(BD_CurrentScale_M(TimeIntervalPre, y, i+iii),threshold); 
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(BD_CurrentScale_M(TimeInterval,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(BD_CurrentScale_M(TimeIntervalPost,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{3}(TimeIntervalPre, y, i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    if(iii~=0)
                        neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex(input{3}(TimeInterval, y, i+iii),threshold);
                        startNeighEntr=startNeighEntr+1;
                    end
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( input{3}(TimeIntervalPost, y, i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( BD_CurrentScale_N(TimeIntervalPre,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( BD_CurrentScale_N(TimeInterval,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    neighbour_Entropy(startNeighEntr+1) = EntropySingVariate_mex( BD_CurrentScale_N(TimeIntervalPost,y,i+iii),threshold);
                    startNeighEntr=startNeighEntr+1;
                    
                end
                
%                     if( tmax_Entropy>=neighbour_Entropy(:))
%                         idx_Entropy=cat(1, idx_Entropy, [y, x, i, sigmaT]);
%                     end

                if(tmax>neighbour(:))% this is a key point(tmax>threshold*abs(neighbour(:)))% this is a key point
                    % if(tmax>abs(neighbour(:)))% this is a key point
                    % if(tmax>neighbour(:))% this is a key point
                    idx = cat(1, idx, [y, x, i, tmax]);
                     if( tmax_Entropy>=neighbour_Entropy(:))
                        idx_Entropy=cat(1, idx_Entropy, [y, x, i, sigmaT]);
                     end                  

                end
                clear neighbour
                clear neighbour_Entropy
            end
        end
    end
end
idx_Entropy=idx_Entropy';
idx = idx';
end
