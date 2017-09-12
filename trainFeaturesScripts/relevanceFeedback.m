function tempG = relevanceFeedback(appCount, Relevence, InRelevence)
% compute relevance feedback importance value
% input:    appCount -- nx2 matrix,
%           R -- relevant objects
%           X -- irrelevant objects
% output: importance -- nx1 matrix

% tempD = appCount(:, 1) + appCount(:, 2); %totAL RELEVANT AND IRRELEVANT
tempH = abs(appCount(:,1)/Relevence - appCount(:, 2)/InRelevence);
tempI = repmat(InRelevence, size(appCount, 1), 1);
tempR = repmat(Relevence, size(appCount, 1), 1);
% tempG = appCount(:,1)*(I-appCount(:,2)+0.01)/((appCount(:, 2)+0.01)*(R-appCount(:,1)+0.01));
tempG = (appCount(:,1).*(tempI-appCount(:,2)+0.01))./((appCount(:, 2)+0.01).*(tempR-appCount(:,1)+0.01));
tempG = log(tempG);
tempG = tempG.*tempH;
end

