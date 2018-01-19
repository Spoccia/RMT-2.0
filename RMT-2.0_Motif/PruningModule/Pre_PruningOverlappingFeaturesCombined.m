function [features,dependency] = Pre_PruningOverlappingFeaturesCombined(A,dpscale,overTime,overDep,data,criteria)
%% Criteria==1 Entropy; 2 dependency; 3 size
    timescope= A(4,:)*3;
    iii=1;
     while iii <= size(A,2)
        CandidateEntropicFeature=A(:,iii);
        CandidateDepScale=dpscale(:,iii);
        CandidateTimerange=(round((CandidateEntropicFeature(2,1)-timescope(1,iii))) : (round((CandidateEntropicFeature(2,1)+timescope(1,iii)))));
        CandidateIDX= iii;
        limitIndex=iii;
        jjj=iii+1;
        while jjj <= size(A,2)
            timerangeF1 = CandidateTimerange(CandidateTimerange>0 & CandidateTimerange<=size(data,2));
            timerangeF2 = (round((A(2,jjj)-timescope(1,jjj))) : (round((A(2,jjj)+timescope(1,jjj)))));
            timerangeF2 = timerangeF2(timerangeF2>0 & timerangeF2<=size(data,2));
            if(size(intersect(timerangeF1,timerangeF2),2)>0)
                Dep_Score_F_i=size(dpscale(dpscale(:,jjj)>0,jjj),1);
                Dep_Score_Cand=size(CandidateDepScale(CandidateDepScale>0,1),1);
                Dep_intersect_score=0;
                if(size(intersect(CandidateDepScale(CandidateDepScale>0,1),dpscale(dpscale(:,jjj)>0,jjj)),2)~=0)
                    Dep_intersect_score=size(intersect(CandidateDepScale(CandidateDepScale>0,1)',dpscale(dpscale(:,jjj)>0,jjj))',2);
                end
                Time_Score_Cand = size(timerangeF1,2);
                Time_Score_F_i =size(timerangeF2,2);
                Time_inter_Score = size(intersect(timerangeF1,timerangeF2),2)/min(Time_Score_Cand,Time_Score_F_i);%Time_Score_Cand
                Dep_inter_Score = Dep_intersect_score/min(Dep_Score_Cand,Dep_Score_F_i);%Dep_Score_Cand;
                Dep_Inter_Score_F_i = Dep_intersect_score/Dep_Score_F_i;
                Time_inter_Score_F_i=size(intersect(timerangeF1,timerangeF2),2)/Time_Score_F_i;
                F_i = A(:,jjj);
                %if(Time_inter_Score>=overTime & Dep_inter_Score>=overDep)%(Time_inter_Score*Dep_inter_Score) >=(0.8*0.8))
                if(Time_inter_Score*Dep_inter_Score >= overTime * overDep)     
                    Fi_Score   = Time_Score_F_i  * Dep_Score_F_i; % Size of feature
                    Cand_Score = Time_Score_Cand * Dep_Score_Cand;% Size of feature
                    if(criteria==3)
                        if(Fi_Score>Cand_Score)%(Dep_Inter_Score_F_i<Dep_inter_Score )
                                % second feature contains  more variate than the original one
                                % and for sure it contain 80% of the data of the first one
                            A(:,CandidateIDX)=[];
                            dpscale(:,CandidateIDX)=[];
                            timescope(:,CandidateIDX)=[];
                            jjj=CandidateIDX;%jjj-1;
                            CandidateEntropicFeature=A(:,CandidateIDX);
                            CandidateDepScale=dpscale(:,CandidateIDX);
                            CandidateTimerange=(round((A(2,CandidateIDX)-timescope(1,CandidateIDX))) : (round((A(2,CandidateIDX)+timescope(1,CandidateIDX)))));%timerangeF2;
                            CandidateTimerange=CandidateTimerange(CandidateTimerange>0);
                        else
                            A(:,jjj)=[];
                            dpscale(:,jjj)=[];
                            timescope(:,jjj)=[];
                            if(jjj>=1)
                                jjj=jjj-1;
                            end
                        end
                    elseif(criteria==2)
%                         dataF1 = data(CandidateDepScale(CandidateDepScale>0,1),timerangeF1((timerangeF1>0 & timerangeF1<=size(data,2))));
%                         dataF2 = data(dpscale(dpscale(:,jjj)>0,jjj),timerangeF2((timerangeF2>0 & timerangeF2<=size(data,2))));
                        Dep_Cand_Score = size(intersect(CandidateDepScale(CandidateDepScale>0,1),dpscale(dpscale(:,jjj)>0,jjj)),1)/Dep_Score_Cand;
                        if(Dep_Inter_Score_F_i<Dep_Cand_Score)
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
                    elseif(criteria==1)
                        dataF1 = data(CandidateDepScale(CandidateDepScale>0,1),timerangeF1((timerangeF1>0 & timerangeF1<=size(data,2))));
                        dataF2 = data(dpscale(dpscale(:,jjj)>0,jjj),timerangeF2((timerangeF2>0 & timerangeF2<=size(data,2))));
                        EntropyF1 = EntropySingVariate_mex(dataF1',-Inf);
                        EntropyF2 = EntropySingVariate_mex(dataF2',-Inf);
                        if(EntropyF2>EntropyF1)
                                % second feature contains  more variate than the original one
                                % and for sure it contain 80% of the data of the first one
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
                    elseif(criteria==4)
                        Fi_Score   = Time_Score_F_i  * Dep_Score_F_i; % Size of feature
                        Cand_Score = Time_Score_Cand * Dep_Score_Cand;% Size of feature
                        dataF1 = data(CandidateDepScale(CandidateDepScale>0,1),timerangeF1((timerangeF1>0 & timerangeF1<=size(data,2))));
                        dataF2 = data(dpscale(dpscale(:,jjj)>0,jjj),timerangeF2((timerangeF2>0 & timerangeF2<=size(data,2))));
                        EntropyF1 = EntropySingVariate_mex(dataF1',-Inf);
                        EntropyF2 = EntropySingVariate_mex(dataF2',-Inf);
                        Dist = pdist2(A(11:138,CandidateIDX)',A(11:138,jjj)','cosine')/2;
                        if(Dist<=0.1)
                            if(Fi_Score>Cand_Score)%(Dep_Inter_Score_F_i<Dep_inter_Score )
                                % second feature contains  more variate than the original one
                                % and for sure it contain 80% of the data of the first one
                                A(:,CandidateIDX)=[];
                                dpscale(:,CandidateIDX)=[];
                                timescope(:,CandidateIDX)=[];
                                jjj=CandidateIDX;%jjj-1;
                                CandidateEntropicFeature=A(:,CandidateIDX);
                                CandidateDepScale=dpscale(:,CandidateIDX);
                                CandidateTimerange=(round((A(2,CandidateIDX)-timescope(1,CandidateIDX))) : (round((A(2,CandidateIDX)+timescope(1,CandidateIDX)))));%timerangeF2;
                                CandidateTimerange=CandidateTimerange(CandidateTimerange>0);
                             elseif(EntropyF2>EntropyF1)
                                    % second feature contains  more variate than the original one
                                    % and for sure it contain 80% of the data of the first one
                                A(:,CandidateIDX)=[];
                                dpscale(:,CandidateIDX)=[];
                                timescope(:,CandidateIDX)=[];
                                jjj=CandidateIDX;%jjj-1;
                                CandidateEntropicFeature=A(:,CandidateIDX);
                                CandidateDepScale=dpscale(:,CandidateIDX);
                                CandidateTimerange=(round((A(2,CandidateIDX)-timescope(1,CandidateIDX))) : (round((A(2,CandidateIDX)+timescope(1,CandidateIDX)))));%timerangeF2;
                                CandidateTimerange=CandidateTimerange(CandidateTimerange>0);
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
                end
            end
            jjj=jjj+1;
        end
        iii=iii+1;
     end
     features=A;
     dependency=dpscale;
end