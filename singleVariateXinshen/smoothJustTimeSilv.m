function [Y]=smoothJustTimeSilv(I,sigma)
% convolution of time
Y = imsmooth(I,sigma) ;
Y = [zeros(size(Y)), Y ,zeros(size(Y))];
    
end