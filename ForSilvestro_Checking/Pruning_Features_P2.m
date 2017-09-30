function [TT,remainQOctave,Dist] = Pruning_Features_P2(doctave,toctave)
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
end