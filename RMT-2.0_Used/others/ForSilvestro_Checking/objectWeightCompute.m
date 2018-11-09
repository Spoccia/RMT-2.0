%% normalize matching score with post-pruned matched size
function [pWeightX, nWeightX] = objectWeightCompute(Xfeature2, Xdescr2, XuniqueFeature, Ximportance, Xproject, XdescrRange )

resolution = 4;
% process descriptors and corresponding weight
Xfeature1 = Xfeature2;
Xdescr1 = Xdescr2;

[XFeature1, XFeature2] = featureOrganizeFixed(Xfeature1, Xfeature2, Xdescr1, Xdescr2,Xproject, XdescrRange,resolution);
% find unique features and assign weight for both feature1 and feature2


pWeightX = 1;
nWeightX = 1;



% combine importance score with matching weight
for i = 1:size(XFeature2, 1)
        tempFeature1 = find(all(bsxfun(@eq, XuniqueFeature, XFeature1(i, :)), 2));
        if(size(tempFeature1,1) == 0)
            t1 = 0;
        else
            t1 = Ximportance(tempFeature1);
            if(t1 > 0)
                pWeightX = pWeightX + t1;
                % pWeightX = pWeightX + 1;
            else
                nWeightX = nWeightX + t1;
                % nWeightX = nWeightX + 1;
            end
        end
end


