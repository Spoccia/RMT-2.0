function [Y]=smoothJustTimeSilv(I,sigma)
% convolution of time
Y = imsmooth(I,sigma) ;
end