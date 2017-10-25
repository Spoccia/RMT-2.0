function [features,dependency] = PruningOverlappingFeaturesSize(A,dpscale,overTime,overDep,data)
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
            timerangeF1 = CandidateTimerange;
            timerangeF2 = (round((A(2,jjj)-timescope(1,jjj))) : (round((A(2,jjj)+timescope(1,jjj)))));
            if(size(intersect(timerangeF1,timerangeF2),2)>0)
                Dep_Score_F_i=size(dpscale(dpscale(:,jjj)>0,jjj),1);
                Dep_Score_Cand=size(CandidateDepScale(CandidateDepScale>0,1),1);
                Time_Score_Cand = size(timerangeF1,2);
                Time_Score_F_i =size(timerangeF2,2);
                Time_inter_Score = size(intersect(timerangeF1,timerangeF2),2)/min(Time_Score_Cand,Time_Score_F_i);%Time_Score_Cand
                Dep_inter_Score = size(intersect(CandidateDepScale(CandidateDepScale>0,1),dpscale(dpscale(:,jjj)>0,jjj)),1)/min(Dep_Score_Cand,Dep_Score_F_i)%Dep_Score_Cand;
                Dep_Inter_Score_F_i = size(intersect(CandidateDepScale(CandidateDepScale>0,1),dpscale(dpscale(:,jjj)>0,jjj)),1)/Dep_Score_F_i;
                Time_inter_Score_F_i=size(intersect(timerangeF1,timerangeF2),2)/Time_Score_F_i;
                F_i = A(:,jjj);
                %if(Time_inter_Score>=overTime & Dep_inter_Score>=overDep)%(Time_inter_Score*Dep_inter_Score) >=(0.8*0.8))
                if(Time_inter_Score*Dep_inter_Score >= overTime * overDep)     
                    Fi_Score   = Time_Score_F_i  * Dep_Score_F_i; % Size of feature
                    Cand_Score = Time_Score_Cand * Dep_Score_Cand;% Size of feature
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
        iii=iii+1;
     end
     features=A;
     dependency=dpscale;
end