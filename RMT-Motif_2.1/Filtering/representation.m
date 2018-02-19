function timeseries = representation(data,startIndex,depd,timescope,NumWindows)
endinstance = startIndex+timescope;
if endinstance >= size(data,2)
    endinstance =size(data,2)-1;
end
if startIndex < 1
    'WTF'
end
alphabet_size=6;
MotifInstance = data(:,startIndex:endinstance);%data(depd,startIndex:endinstance);%
[rowquest, data_len]      = size(MotifInstance);

sizewindow = floor(data_len/NumWindows);
cuttedlength = sizewindow*NumWindows;
% MotifInstance = reshape(MotifInstance,[size(MotifInstance,1), cuttedlength]);
MotifInstance = (MotifInstance(:,1:cuttedlength));
[rowquest, data_len]      = size(MotifInstance);
timeseries=zeros(rowquest,NumWindows);

       for i = 1:rowquest
        %* Calculation of normaized the data *%
            variatenormdata = (MotifInstance(i,:) - mean(MotifInstance(i,:)))/std(MotifInstance(i,:));
            % special case: no dimensionality reduction
%             if data_len == NumWindows
%                    PAA = variatenormdata ;
%             % Convert to PAA.  Note that this line is also in timeseries2symbol, which will be
%             % called later.  So it's redundant here and is for the purpose of plotting only.
%             else
%                 % if data is nt divisible for nseg then  calculate the size we can
%                 % represent and  apply the sax on the sub-timeseries.
%                 PAA = [mean(reshape(variatenormdata,sizewindow,NumWindows))];                     
%             end                
%                    
%             localsax =SAXIMPL(TS(i,:),symbols,nseg);
%             if(isempty(localsax))
%                 for k=1:nseg%length(localsax)    
%                     localsax= [localsax,0];
%                    
%                 end
%             end
            str = timeseries2symbol(variatenormdata, data_len, NumWindows, alphabet_size);
            if size(str,1)==0
                str=ones(1,NumWindows);
            end
            timeseries(i,:) = str;%PAA;
        end

end