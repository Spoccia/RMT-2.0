function sd = siftdescriptor(smoothedScale,frame,sigmat0,sigmaD0,St,Sd,minSt,minSd, magnif,NBP_Time,NBP_Depd, NBO) 
% smoothedScale: smoothed scale of the specific image in the octave(downsampled) in the specific scale time and dependency
% frame:  Frame(1,1)= Dependency variate the feature in the octave representation
%         Frame(2,1)= Time index of the feature in the octave representation
%         Frame(3,1)= Scale Dependency of the feature
%         Frame(4,1)= Scale Time of the feature
%         Frame(5,1)= eventual orientation otherwise 0
% sigmat0: the original sigma used to smooth over Time
% sigmaD0: the original sigma used to smooth over Dependency
% St: maximum scale over Time
% Sd: maximum scale over Dependency
% minSt: minimum scale over Time 
% minSd: minimum scale over Dependency 
% magnif: Spatial bin extension factor. usually 3.0 from Lowe
% NBP_Time: number of bin for Time To build a grid
% NBP_Depd: number of bin for Dependency to build a grid
% NBO: Number of Bin for orientation (8 is used in Lowe) 


  magnif = 3.0;  %/* Spatial bin extension factor. */
  NBP_Time = 4 ;      %/* Number of bins for one spatial direction (even). */
  NBP_Depd = 4;
  NBO = 8 ;      %/* Number of bins for the ortientation. */
  mode = 'NOSCALESPACE' ; % We pass just thte specific scale space of the feature
  
  M = size(smoothedScale,1);
  N= size(smoothedScale,2);
  num_levels=1;
  featureInfo= size(frame,1); %K in the original code++
  
 %%    Compute the gradient 
%DERIVATE  ACROSS X DIMENTION 
Dx = 0.5 *(smoothedScale(2:end,:)-smoothedScale(1:end-1,:));
%DERIVATE  ACROSS Y DIMENTION 
Dy =0.5 * (smoothedScale(:,2:end)-smoothedScale(:,1:end-1));
% Dx1=[];
% Dy1=[];
%       for x = 2 : N-1 % // FOR  EACH ROW 
%         for y = 1: M  % // FOR EACH COLUMN
%           %DERIVATE  ACROSS X DIMENTION 
%            Dx(x,y) = 0.5 * ( smoothedScale(x+1,y) - smoothedScale(x-1,y) ) ; %//DERIVATE  ACROSS X DIMENTION 
%            Dy(x,y) = 0.5 * ( smoothedScale(x,y+1) - smoothedScale(x,y-1) ) ; %// DERIVATE ACROSS Y DIMENTION
%         end
%       end
 
 %% /* Compute angles and modules of all the points in the scale*/
Gradient_Scale=  sqrt(Dx*Dx + Dy*Dy) ;% //GRADIENT OF THE POINT
Angles= atan2(Dy, Dx) ; %// ANGLE OF THE 1ST DERIVATE ACROSS x AND y


end