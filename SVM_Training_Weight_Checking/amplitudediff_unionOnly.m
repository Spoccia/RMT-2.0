function amp = amplitudediff_unionOnly(I1,frame1,gss1,idm1)
amp = zeros(size(frame1, 2),1);
[depdin1] = computeDepdScale_unionOnly(frame1,gss1,  idm1);
for i=1:size(frame1,2)
    % calculate amplitude in each feature of one match
    % feature 1
    % k1 = 3*4*sqrt(2)*2^(frame1(4,matches(1,i))-1) ;
    k1 = 3*(frame1(4,i));
    dia1 = 0;
    som1 = 0;
    mininv1 =  floor(max(frame1(2,i)-k1,1));
    maxinv1 =  floor(min(frame1(2,i)+k1,size(I1,2)));
    tempDepd = depdin1(:, i);
    tempDepd = tempDepd(tempDepd~=0);
    for j=1:size(tempDepd,1)
        som1 = som1+sum(I1(tempDepd(j),mininv1:maxinv1));
        dia1 = dia1+maxinv1-mininv1+1;
    end
    % amp(i) = abs(som1/dia1);
    % amp(i) = som1/dia1;    
    amp(i) = som1;    
    % feature 2
    %     k2 = 3*4*sqrt(2)*2^(frame2(4,matches(2,i))-1) ;
    %     depdin2 = depdscale(gss2, frame2(:,matches(2,i)), idm2);
    %     avgamp2 = 0;
    %     dia2 = 0;
    %     som2 = 0;
    %     mininv2 = floor(max(frame2(2,matches(2,i))-k2,1));
    %     maxinv2 = floor(min(frame2(2,matches(2,i))+k2,size(I2,1)));
    %     for j=1:size(depdin2,2)
    %         som2 = som2+sum(I2(mininv2:maxinv2,depdin2(1,j)));
    %         dia2 = dia2+maxinv2-mininv2+1;
    %     end
    %     avgamp2 = som2/dia2;
    % ampdiff(i) = abs(avgamp1-avgamp2);%/(avgamp1+avgamp2);
end