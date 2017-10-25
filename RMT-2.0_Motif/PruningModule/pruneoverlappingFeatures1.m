function [A,B]=pruneoverlappingFeatures(A,dpscale,Centroid_desriptor)
    timescope= A(4,:)*3;
    iii=1;
    kindofCriteria=3;
    %% kindofcriteria:
    % 1 for distance from centroid
    % 2 for overlapping size larger feature larger importance
    % 3 mixed in case of equal size store the nearest to the centroid
    while iii <= size(A,2)
        CandidateEntropicFeature=A(:,iii);
        CandidateDepScale=dpscale(:,iii);
        CandidateTimerange=(round((CandidateEntropicFeature(2,1)-timescope(1,iii))) : (round((CandidateEntropicFeature(2,1)+timescope(1,iii)))));
        CandidateIDX= iii;
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
                if((Time_inter_Score*Dep_inter_Score) >=(0.8*0.8))%(Time_inter_Score>= 0.8 & Dep_inter_Score >= 0.8)
                    %% condition to determine  what feature we like to store:
                    % min distance from centroid
                    if(kindofCriteria==1)
                        dist= pdist2(Centroid_desriptor',[CandidateEntropicFeature(11:138,1),F_i(11:138,1)]');
                        [~,idxmin]= min(dist);
                        if(idxmin==2)
                             A(:,CandidateIDX)=[];
                            dpscale(:,CandidateIDX)=[];
                            timescope(:,CandidateIDX)=[];
                            jjj=CandidateIDX;%jjj-1;
                            CandidateEntropicFeature=A(:,CandidateIDX);
                            CandidateDepScale=dpscale(:,CandidateIDX);
                            CandidateTimerange=(round((A(2,CandidateIDX)-timescope(1,CandidateIDX))) : (round((A(2,CandidateIDX)+timescope(1,CandidateIDX)))));
                        else
                            A(:,jjj)=[];
                            dpscale(:,jjj)=[];
                            timescope(:,jjj)=[];
                            if(jjj>=1)
                                jjj=jjj-1;
                            end
                        end
                    elseif(kindofCriteria==2)
                        % larger feature
                        Fi_Score   = Time_Score_F_i  * Dep_Score_F_i;
                        Cand_Score = Time_Score_Cand * Dep_Score_Cand;
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
                    elseif(kindofCriteria==3)
                        % larger feature
                        Fi_Score   = Time_Score_F_i  * Dep_Score_F_i;
                        Cand_Score = Time_Score_Cand * Dep_Score_Cand;
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
                        elseif(Fi_Score==Cand_Score)
                            dist= pdist2(Centroid_desriptor',[CandidateEntropicFeature(11:138,1),F_i(11:138,1)]');
                            [~,idxmin]= min(dist);
                            if(idxmin==2)
                                 A(:,CandidateIDX)=[];
                                dpscale(:,CandidateIDX)=[];
                                timescope(:,CandidateIDX)=[];
                                jjj=CandidateIDX;%jjj-1;
                                CandidateEntropicFeature=A(:,CandidateIDX);
                                CandidateDepScale=dpscale(:,CandidateIDX);
                                CandidateTimerange=(round((A(2,CandidateIDX)-timescope(1,CandidateIDX))) : (round((A(2,CandidateIDX)+timescope(1,CandidateIDX)))));
                            else
                                A(:,jjj)=[];
                                dpscale(:,jjj)=[];
                                timescope(:,jjj)=[];
                                if(jjj>=1)
                                    jjj=jjj-1;
                                end
                        end
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
            jjj=jjj+1;
        end
        iii=iii+1;
    end
    B=dpscale;
end

