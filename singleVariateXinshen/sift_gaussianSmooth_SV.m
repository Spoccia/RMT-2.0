function [frames1,descr1,gss1,dogss1,depd1,idm1, time, timee, timeDescr] = sift_gaussianSmooth_SV(I, Ot, St, sigmaTime, NBP, gthresh, r,sBoundary, eBoundary)
featureTimeScale = [];
featureDepdScale = [];
% thresh = 0.04 / St / 2 ;
thresh = 0.04 / 3 / 2 ; %value picked from the vivaldi code
NBO    = 8;
NBP_Time = 4;
NBP_Depd = 4;
magnif = 3.0;
% frames      = [] ;
tempFrames = [];
ktime = 2^(1/(St-3));

% Compute scale spaces
% Try this function
stmin=0;%-1;
otmin=0;

[gss,dogss] = gaussianss_time(I, Ot,St,otmin,stmin,St+1, sigmaTime,-1);

for otime = 1: size(gss.octave,1)
    scaleDiff = St - 1;
    forwardIdx = siftlocalmax_directed_100(dogss.octave{otime}, 0.8*thresh, NormalizeF(depd{odepd}), NormalizeB(depd{odepd}'), scaleDiff);
end


'end'



                                                              
                                                              
                                                              