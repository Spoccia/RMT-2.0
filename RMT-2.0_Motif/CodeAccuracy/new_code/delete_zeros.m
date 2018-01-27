function [precisionMatrix, recallMatrix, FScoreMatrix] = delete_zeros(precisionMatrix, recallMatrix, FScoreMatrix)
% MotifEntropy: precisionEntropy, recallEntropy, FScoreEntropy
identified_class = size(precisionMatrix, 1);
injected_class = size(precisionMatrix, 2);

target_rows = [];

% scan each identified class
for i = 1 : identified_class
    temp_precision = precisionMatrix(i, :);
    temp_recall = recallMatrix(i, :);
    
    nonzeros_precision = nonzeros(temp_precision);
    nonzeros_recall = nonzeros(temp_recall);
    if(size(nonzeros_precision, 1) == 0 && size(nonzeros_recall, 1) == 0)
        target_rows = [target_rows; i];
    end
end
precisionMatrix(target_rows, :) = [];
recallMatrix(target_rows, :) = [];
FScoreMatrix(target_rows, :) = [];

fprintf('process done. \n');
end