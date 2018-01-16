function [A,dpscale] = pruningEntropyThresh(A,dpscale,EntropyTHR,data)
    timescope= A(4,:)*3;
    iii=1;
    while iii <= size(A,2)
        CandidateEntropicFeature=A(:,iii);
        CandidateDepScale=dpscale(:,iii);
        CandidateTimerange=(round((CandidateEntropicFeature(2,1)-timescope(1,iii))) : (round((CandidateEntropicFeature(2,1)+timescope(1,iii)))));
        dataF1 = data(CandidateDepScale(CandidateDepScale>0,1),CandidateTimerange((CandidateTimerange>0 & CandidateTimerange<=size(data,2))));
        EntropyF1 = EntropySingVariate_mex(dataF1',-Inf);
        if(EntropyF1<EntropyTHR)
            A(:,iii)=[];
            dpscale(:,iii)=[];
            timescope(:,iii)=[];
            iii=iii-1;
        end
        iii=iii+1;
    end
end