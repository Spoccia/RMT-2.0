function fgss = computeFeatureMatrix(octave,sminT,sminD, sigmaDep0, St,Sd,H,directed)
% For each combination of scale  dependency and Time in the octave create a
% structure where  the matrix  represent the neighboorhood of the  specific
% variate V_i

[M_Time, N_variate]= size(octave(:,:,1,1) );

for si_T= sminT:St+1
    for si_D= sminD:SD+1
        ScaleSigma = sigmaDep0 * 2^(si_D/Sd);
        ScopeDependency = floor(3* ScaleSigma);
        for V_i=1:N_variate
            V_i_rearrange= zeros(M_Time,2*ScopeDependency+1);
            StartPos= ScopeDependency+1;
            V_i_rearrange(:,StartPos)= octave(:,V_i,sminD,sminT);
            for i= 1:ScopeDependency
                % construct matrix on right side
                temp = (H^(i)*octave(:,:,si_D,si_T)')';
                V_i_rearrange(:,StartPos+i)= temp(:,V_i);
                if(directed==0) % undirected graph
                  temp1= (pinv(H)^(i)*octave(:,:,si_D,si_T)')';
                  V_i_rearrange(:,StartPos-i)= temp(:,V_i);
                end
            end
            
        end
        
    end
end
    