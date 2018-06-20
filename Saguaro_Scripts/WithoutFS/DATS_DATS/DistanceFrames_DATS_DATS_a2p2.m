function [Dist, remainQOctave] = DistanceFrames_DATS_DATS_a2p2(gss1, feature1, idm1, gss2, feature2, idm2, descr1, descr2, maxTime1, minTime1, maxTime2, minTime2, amp1,amp2)
remainQOctave = [];

[depdScale1] = computeDepdScale_unionOnly(feature1, gss1, idm1);
[depdScale2] = computeDepdScale_unionOnly(feature2, gss2, idm2);
MVariateSize = size(gss1.octave{1,1},2);

TtempMinScope1 = min(3*feature1(4, :));
TtempMinScope2 = min(3*feature2(4, :));

TtempMaxScope1 = max(3*feature1(4, :));
TtempMaxScope2 = max(3*feature2(4, :));


DtempMinScope1 = min(3*feature1(3, :));
DtempMinScope2 = min(3*feature2(3, :));

DtempMaxScope1 = max(3*feature1(3, :));
DtempMaxScope2 = max(3*feature2(3, :));

minScope = (TtempMinScope1 + TtempMinScope2)/2;


[matches, VcombineScore, CheckValues]=mySiftMatch_DATS_DATS_SameOct( descr1, descr2, feature1, feature2, maxTime1, minTime1, maxTime2, minTime2, minScope,amp1, amp2,DtempMinScope1,DtempMinScope2,DtempMaxScope1, DtempMaxScope2, TtempMinScope1,TtempMinScope2,TtempMaxScope1, TtempMaxScope2, MVariateSize);

combineScore = CheckValues(2,:);
doctave = max(feature1(5,:));
toctave = max(feature1(6,:));
Dist = 0;
for ii = 1 : doctave
    for  jj = 1 : toctave
        index1 = find(feature1(5,:) == ii & feature1(6,:) == jj);
        matches11 = matches(:, index1);
        combineScore11 = combineScore(index1);
        [diagY,I] = sort(combineScore11,2,'descend');
        diagMatch = matches11(:,I);
        diagRemainMatch = [];
        for i=1:size(diagMatch,2)
            centerc_variate = feature1(1,diagMatch(1,i));
            centerm_variate = feature2(1,diagMatch(2,i));
            
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
                rem_variatec = feature1(1,diagRemainMatch(1,j));
                rem_variatem = feature2(1,diagRemainMatch(2,j));
                
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
                    if(centerc_variate == rem_variatec)
                        keept = false;
                        break;
                    else
                        keept = true;
                    end
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



function ovr = overlap (depdin1,depdin2)
ov = intersect(depdin1(1,:),depdin2(1,:));
ovr = size(ov,2)/size(depdin1,2);

function depdin = depdscale(gss1, feature1, idm1)
ttScale1 = gss1.ds{feature1(6,1),feature1(5,1)};
tScale1 = ttScale1(1);
dScale1 = ttScale1(2);

tScale = gss1.octave{tScale1, dScale1};
si = min(size(tScale,4),floor(feature1(5,1)+0.5) +1);
si = max(si,1);
S1 = gss1.smoothmatrix{feature1(5,1)}(:,:,si);
temp(1,:) = find(S1(max(1,floor(feature1(1,1))),:)>0.01);
temp(2,:) = max(1,floor(feature1(2,1)));
depdin = temp;



