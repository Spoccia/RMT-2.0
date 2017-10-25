function [A,dpscale]=pruneOverlappingFeaturesTimeandDepEntropy(A,dpscale,overTime,overDep,data)
    iii=1;
    timescope= A(4,:)*3;
    while iii <= size(A,2)
        CandidateEntropicFeature=A(:,iii);
        CandidateDepScale=dpscale(:,iii);
        CandidateTimerange=(round((CandidateEntropicFeature(2,1)-timescope(1,iii))) : (round((CandidateEntropicFeature(2,1)+timescope(1,iii)))));
        CandidateIDX= iii;
        limitIndex=iii;
        jjj=iii+1;
        while jjj <= size(A,2)
            timerangeF1 = CandidateTimerange;
            timerangeF2 = (round((A(2,jjj)-timescope(1,jjj))) : (round((A(2,jjj)+timescope(1,jjj)))));
            if(size(intersect(timerangeF1,timerangeF2),2)>0)
                %Dep_inter_Score  = size(intersect(CandidateDepScale(CandidateDepScale>0,1),dpscale(dpscale(:,jjj)>0,jjj)),1)/(size(union(CandidateDepScale(CandidateDepScale>0,1),dpscale(dpscale(:,jjj)>0,jjj)),2));
                Time_inter_Score = size(intersect(timerangeF1,timerangeF2),2)/min(size(timerangeF1,2),size(timerangeF2,2));%size(timerangeF1,2);%(size(union(timerangeF1,timerangeF2),2));
                Dep_inter_Score = size(intersect(CandidateDepScale(CandidateDepScale>0,1),dpscale(dpscale(:,jjj)>0,jjj)),1)/min(size(CandidateDepScale(CandidateDepScale>0,1),1),size(dpscale(dpscale(:,jjj)>0,jjj),1));%size(CandidateDepScale(CandidateDepScale>0,1),1);%union(CandidateDepScale(CandidateDepScale>0,1),dpscale(dpscale(:,jjj)>0,jjj)),1);
                Dep_Inter_Score_F_i = size(intersect(CandidateDepScale(CandidateDepScale>0,1),dpscale(dpscale(:,jjj)>0,jjj)),1)/size(dpscale(dpscale(:,jjj)>0,jjj),1);
                Time_inter_Score_F_i=size(intersect(timerangeF1,timerangeF2),2)/size(timerangeF2,2);%(size(union(timerangeF1,timerangeF2),2));
                Overlapping_Score =  Time_inter_Score * Dep_inter_Score;

                %if(Time_inter_Score>= overTime & Dep_inter_Score >= overDep)%((size(intersect(CandidateDepScale(CandidateDepScale>0,1),dpscale(dpscale(:,jjj)>0,jjj)),1)> 0.5 *max([size(CandidateDepScale(CandidateDepScale>0,1),1),size(dpscale(dpscale(:,jjj)>0,jjj),1)])) & ~isempty(intersect(CandidateDepScale(CandidateDepScale>0,1),dpscale(dpscale(:,jjj)>0,jjj)))||(Time_inter_Score == 1))
                 if(Time_inter_Score*Dep_inter_Score >= overTime * overDep)
                    dataF1 = data(CandidateDepScale(CandidateDepScale>0,1),timerangeF1((timerangeF1>0 & timerangeF1<=size(data,2))));
                    dataF2 = data(dpscale(dpscale(:,jjj)>0,jjj),timerangeF2((timerangeF2>0 & timerangeF2<=size(data,2))));
                    EntropyF1 = EntropySingVariate_mex(dataF1',-Inf);
                    EntropyF2 = EntropySingVariate_mex(dataF2',-Inf);
                    %                                     Xf = fft(dataF1'); % compute the DFT (using the Fast Fourier Transform)
                    %                                     EnergyF1 = sum(abs(Xf).^2) / length(Xf); % Get the energy using Parseval's theorem
                    %                                     Xf = fft(dataF2');
                    %                                     EnergyF2 =  sum(abs(Xf).^2) / length(Xf);
                    %if(Dep_Inter_Score_F_i<Dep_inter_Score)
                    if( EntropyF2>EntropyF1)%(Dep_Inter_Score_F_i<Dep_inter_Score | EntropyF2>EntropyF1)
                        A(:,CandidateIDX)=[];
                        dpscale(:,CandidateIDX)=[];
                        timescope(:,CandidateIDX)=[];

                        jjj=CandidateIDX;%jjj-1;
                        CandidateEntropicFeature=A(:,CandidateIDX);
                        CandidateDepScale=dpscale(:,CandidateIDX);
                        CandidateTimerange=(round((A(2,CandidateIDX)-timescope(1,CandidateIDX))) : (round((A(2,CandidateIDX)+timescope(1,CandidateIDX)))));%timerangeF2;

                    else
                        A(:,jjj)=[];
                        dpscale(:,jjj)=[];
                        timescope(:,jjj)=[];
                        if(jjj>=1)
                            jjj=jjj-1;
                        end
                    end
                end
            end
            jjj=jjj+1;
        end
        %                         NewFeatures=[NewFeatures,CandidateEntropicFeature];
        %                         NewDependency= [NewDependency,CandidateDepScale];
        iii=iii+1;
    end

end