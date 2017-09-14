function  Training_rangeFeatures = ComposeFeatures(training_Relevant_Features,timeSeriesLength)
    timeStart = training_Relevant_Features(2, :) - training_Relevant_Features(4, :);%, 1
    timeStart(timeStart>1)= 1;
    timeEnd = training_Relevant_Features(2, :) + training_Relevant_Features(4, :);%, timeSeriesLength
    timeEnd(timeEnd>timeSeriesLength) = timeSeriesLength;

    Training_rangeFeatures = zeros(16,size(training_Relevant_Features,2));
    Training_rangeFeatures(1,:)=timeStart;
    Training_rangeFeatures(2,:)=timeEnd;
    Training_rangeFeatures(3,:)=training_Relevant_Features(2, :);
    Training_rangeFeatures(4,:)=training_Relevant_Features(1, :);
    Training_rangeFeatures(5,:)=training_Relevant_Features(5, :);
    Training_rangeFeatures(6,:)=training_Relevant_Features(6, :);

    %         featureDepd = trainingFeatures(1, :);
    %         featureTime = trainingFeatures(2, :);
    %         featureDepdOctave = trainingFeatures(5, :);
    %         featureTimeOctave = trainingFeatures(6, :);
    trainingDescriptors = training_Relevant_Features(8:135, :)';
    % train SVD on training dataset, use SVD on descriptors only
    options = [];
    options.ReducedDim = 10;
    % PCA, trainVector is the project matrix

    [trainedVector, trainValues] = PCA(trainingDescriptors,options);
    trainingDescriptors = trainingDescriptors*trainedVector;
    Training_rangeFeatures(7:16,:) = trainingDescriptors';

end