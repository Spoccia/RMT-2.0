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
