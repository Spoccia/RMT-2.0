function RW = scaleRW (randomwalkData,maxvalueTS,minvalueTS,percentage)
RW=randomwalkData;
maxvalueTS =maxvalueTS*percentage;
maxvalueTS =maxvalueTS*percentage;
    for i=1:length (maxvalueTS)        
        RW(i,:) = (randomwalkData(i,:)*(maxvalueTS(i)-minvalueTS(i)))+minvalueTS(i);
    end
end