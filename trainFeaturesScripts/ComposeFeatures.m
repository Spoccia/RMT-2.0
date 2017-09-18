function  Training_rangeFeatures = ComposeFeatures(training_Relevant_Features)%,timeSeriesLength)
Training_rangeFeatures = zeros(16,size(training_Relevant_Features,2));    
%     for i=1: size(training_Relevant_Features,2)
%         timeStart = training_Relevant_Features(2, i) - training_Relevant_Features(4, i);%, 1
%         timeStart(timeStart>1)= 1;
%         timeEnd = training_Relevant_Features(2, i) + training_Relevant_Features(4, i);%, timeSeriesLength
%         timeEnd(timeEnd>timeSeriesLength(i)) = timeSeriesLength(i);
% 
% 
%         Training_rangeFeatures(1,:)=timeStart;
%         Training_rangeFeatures(2,:)=timeEnd;
%         Training_rangeFeatures(3,:)=training_Relevant_Features(2, i);
%         Training_rangeFeatures(4,:)=training_Relevant_Features(1, i);
%         Training_rangeFeatures(5,:)=training_Relevant_Features(5, i);
%         Training_rangeFeatures(6,:)=training_Relevant_Features(6, i);
% 
%         %         featureDepd = trainingFeatures(1, :);
%         %         featureTime = trainingFeatures(2, :);
%         %         featureDepdOctave = trainingFeatures(5, :);
%         %         featureTimeOctave = trainingFeatures(6, :);
%         % train SVD on training dataset, use SVD on descriptors only
%     end
        trainingDescriptors = training_Relevant_Features(8:135, :)';
        options = [];
        options.ReducedDim = 10;
        % PCA, trainVector is the project matrix

        [trainedVector, trainValues] = PCA(trainingDescriptors,options);
        trainingDescriptors = trainingDescriptors*trainedVector;
        Training_rangeFeatures = trainingDescriptors';
end