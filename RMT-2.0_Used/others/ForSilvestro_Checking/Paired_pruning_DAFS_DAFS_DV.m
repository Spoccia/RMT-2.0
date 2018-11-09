function [remainQOctave,Dist] = Paired_pruning_DAFS_DAFS_DV(feature1,depdScale1,matches,combineScore,feature2,depdScale2,doctave,toctave )
% pruning considering that two feature overlapping in time should have also
% same variate
    remainQOctave=zeros(doctave,toctave);
    Dist=0;
    for ii = 1 : doctave
        for  jj = 1 : toctave
            index1 = find(feature1(5,:) == ii & feature1(6,:) == jj);
            matches11 = matches(:, index1);
            combineScore11 = combineScore(index1);

            [diagY,I] = sort(combineScore11,2,'descend');
            diagY_1=diagY;
            diagMatch = matches11(:,I);
            diagRemainMatch = diagMatch;
            counter=0;
%             Counteroccurrences= 0
       %     i=1;
            dimention=size(diagRemainMatch,2);
            i=1;
            while i<=dimention
                
                centerc_variate = feature1(1,diagRemainMatch(1,i));
                centerm_variate = feature2(1,diagRemainMatch(2,i));
            
                centerc = feature1(2,diagRemainMatch(1,i));
                centerm = feature2(2,diagRemainMatch(2,i));
                rangec = 3*(feature1(4,diagRemainMatch(1,i))) ;
                rangem = 3*(feature2(4,diagRemainMatch(2,i))) ;
                startc = centerc - rangec ;
                endc = centerc + rangec ;
                startm = centerm - rangem ;
                endm = centerm + rangem ;

                keept = true;
                keepd = true;

                depdin1 = depdScale1(:,diagRemainMatch(1,i));
                depdin1 = depdin1(depdin1~=0);
                depdin2 = depdScale2(:,diagRemainMatch(2,i));
                depdin2 = depdin2(depdin2~=0);
                over = overlap (depdin1,depdin2);
                if(over < 0.5)
                    keepd = false;
                end

                j = 1;
                 
              
                while  (j<=counter) && (keept == true)&& (keepd == true)%(j<=size(diagRemainMatch,2)) && (keept == true)&& (keepd == true)
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
%                         
%                         VariateF1 = feature1(1,diagRemainMatch(1,j));
%                         VariateF2 = feature2(1,diagRemainMatch(2,j));
                        list1 = zeros(4,1);%[];
                        list2 = zeros(4,1);%[];


                        list1(4-3,1) =rem_startc;% [list1;rem_startc;rem_endc];
                        list1(4-2,1) = rem_endc;
                        list2(4-3,1) = rem_startm;%[list2;rem_startm;rem_endm];
                        list2(4-2,1) = rem_endm;
                        list1(4-1,1) = startc;% [list1;startc;endc];
                        list1(4,1)   = endc;%
                        list2 (4-1,1) = startm;%[list2;startm;endm];
                        list2 (4,1) = endm;%

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
%                     diagRemainMatch(i) =1;% [diagRemainMatch diagMatch(:,i)];
                    Dist = Dist + diagY_1(i);
                    counter=counter+1;
                else
                    diagRemainMatch(:,i)=[];
                    diagY_1(:,i)=[];
                    i=i-1;
                    dimention=size(diagRemainMatch,2);
                end
                i=i+1;
            end
            % diagRemainFeature = feature1(:,diagRemainMatch(1,:));
            TT = counter;% size(diagRemainMatch, 2);
            remainQOctave(ii,jj) = TT;%[remainQOctave TT];
        end
    end


function ovr = overlap (depdin1,depdin2)
ov = intersect(depdin1(1,:),depdin2(1,:));
ovr = size(ov,2)/size(depdin1,2);