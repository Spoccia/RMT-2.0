function data=NormalizeRandomWalk(RW,NormInterval,znorm)
data = RW;
    for variateID =1: size(RW,1);
        
        if(znorm ==1)
            %znormalization
            RW(variateID,:) = (RW(variateID,:) - mean(RW(variateID,:))) ...
                                  / std(RW(variateID,:), 1);
        end
        %0-1 normalization
        data(variateID,:)=(RW(variateID,:)-min(RW(variateID,:)))/(max(RW(variateID,:))-min(RW(variateID,:)));
        
        %interval normalization
        ampnorm = NormInterval(variateID,2)-NormInterval(variateID,1);
        data(variateID,:)=data(variateID,:)*ampnorm +NormInterval(variateID,1);
    end
end