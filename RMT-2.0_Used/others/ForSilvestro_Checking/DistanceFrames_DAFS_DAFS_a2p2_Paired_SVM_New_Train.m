function [Dist, remainQOctave, time] = DistanceFrames_DAFS_DAFS_a2p2_Paired_SVM_New_Train(gss1, feature1, idm1, gss2, feature2, idm2, descr1, descr2, XuniqueFeature,Ximportance, Xproject, XdescrRange,amp1,amp2, queryTimeSeriesLength)

[depdScale1] = computeDepdScale_unionOnly(feature1, gss1, idm1);
[depdScale2] = computeDepdScale_unionOnly(feature2, gss2, idm2);

time = zeros(1,3);
resolution = 2;
p=tic;

isPaired = 1;
% process descriptors and corresponding weight
[Feature1] = featureOrganize(feature1, descr1, Xproject, XdescrRange, resolution, queryTimeSeriesLength);

for i = 1:size(Feature1, 1)
    % lookup function
    relevantFeatureVector = Feature1(i,:);
    
    % do the look up for both relevant range features and irrelevant range features
    featureCount = featureLookUp(XuniqueFeature, relevantFeatureVector, isPaired);
    featureWeight = 1;
    if(size(featureCount,1) == 0)
        % t = 0.01;
    else
        featureWeight = Ximportance(featureCount);
    end
    featureImp(i) = featureWeight;
end
time(2) = toc(p);


% get rid of featureImp = 0
nonzero_entries = featureImp ~= 0;
descr1 = descr1(:, nonzero_entries);
feature1 = feature1(:, nonzero_entries);
amp1 = amp1(nonzero_entries);
featureImp = featureImp(nonzero_entries);
featureImp(:) = 1;


p = tic;
[matches, VcombineScore]=mySiftMatch_DAFS_DAFS_SameOct( descr1, descr2, feature1, feature2, amp1, amp2, featureImp);
time(1) = toc(p);

combineScore = VcombineScore;

[Y,I] = sort(combineScore,2,'descend');
matches = matches(:,I);

Dist=0;
remainmatch=[];
remainQOctave=[];
p = tic;

doctave = 3;
toctave = 3;
for ii = 1 : doctave
    for  jj = 1 : toctave
        index1 = find(feature1(5,:) == ii & feature1(6,:) == jj);
        matches11 = matches(:, index1);
        combineScore11 = combineScore(index1);
        
        [diagY,I] = sort(combineScore11,2,'descend');
        diagMatch = matches11(:,I);
        diagRemainMatch = [];
        for i=1:size(diagMatch,2)
            centerc = feature1(2,diagMatch(1,i));
            centerm = feature2(2,diagMatch(2,i));
            rangec = 3*(feature1(4,diagMatch(1,i))) ;
            rangem = 3*(feature2(4,diagMatch(2,i))) ;
            startc = centerc - rangec ;
            endc = centerc + rangec ;
            startm = centerm - rangem ;
            endm = centerm + rangem ;
            
            keept = true;
            keepd = true;
            
            depdin1 = depdScale1(:,diagMatch(1,i));
            depdin1 = depdin1(depdin1~=0);
            depdin2 = depdScale2(:,diagMatch(2,i));
            depdin2 = depdin2(depdin2~=0);
            over = overlap (depdin1,depdin2);
            if(over < 0.5)
                keepd = false;
            end
            
            j = 1;
            while  (j<=size(diagRemainMatch,2)) && (keept == true)&& (keepd == true)
                % first step check only time
                rem_centerc = feature1(2,diagRemainMatch(1,j));
                rem_centerm = feature2(2,diagRemainMatch(2,j));
                rem_rangec = 3*(feature1(4,diagRemainMatch(1,j))) ;
                rem_rangem = 3*(feature2(4,diagRemainMatch(2,j))) ;
                rem_startc = rem_centerc - rem_rangec ;
                rem_endc = rem_centerc + rem_rangec ;
                rem_startm = rem_centerm - rem_rangem ;
                rem_endm = rem_centerm + rem_rangem ;
                
                list1 = [];
                list2 = [];
                
                list1 = [list1;rem_startc;rem_endc];
                list2 = [list2;rem_startm;rem_endm];
                list1 = [list1;startc;endc];
                list2 = [list2;startm;endm];
                
                [c d] = sort(list1);
                rankcstart = find(c==startc);
                rankcend = find(c==endc);
                [c d] = sort(list2);
                rankmstart = find(c==startm);
                rankmend = find(c==endm);
                
                if (startc == rem_startc) && (endc==rem_endc) && (startm == rem_startm) && (endm == rem_endm)
                    keept = false;
                    break;
                else
                    if rankcstart(1) == rankmstart(1) && rankcend(1) ==rankmend(1)
                        keept = true;
                    else
                        keept = false;
                        break;
                    end
                end
                
                j = j+1;
            end
            if (keept == true) && (keepd == true)
                diagRemainMatch = [diagRemainMatch diagMatch(:,i)];
                Dist = Dist + diagY(i);
            end
        end
        % diagRemainFeature = feature1(:,diagRemainMatch(1,:));
        TT = size(diagRemainMatch, 2);
        remainQOctave = [remainQOctave TT];
    end
end
time(3) = toc(p);

function ovr = overlap (depdin1,depdin2)
ov = intersect(depdin1(1,:),depdin2(1,:));
ovr = size(ov,2)/size(depdin1,2);
