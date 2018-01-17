clear;
clc;

% iterate file to for upload
testCaseIndex = 1 : 10;
GroundTruthFilePath = [];
MatrixProfileFilePath = [];
RMTMotifFilePath = [];

MatrixProfileEntropy = [];
RMTMotifEntropy = [];
for ii = 1 : size(fileSize, 1)
    GroundTruthFile = [GroundTruthFilePath];
    MatrixProfileFile = [MatrixProfileFilePath];
    RMTMotifFile = [RMTMotifFilePath];
    
    [currentMatrixProfileEntropy] = motifEvaluation(GroundTruthFile, MatrixProfileFile);
    [currentRMTMotifEntropy] = motifEvaluation(GroundTruthFile, RMTMotifFile);
    
    MatrixProfileEntropy = [MatrixProfileEntropy ; currentMatrixProfileEntropy];
    RMTMotifEntropy = [RMTMotifEntropy ; currentRMTMotifEntropy];
end

csvwrite('./MatrixProfileEntropy.csv', MatrixProfileEntropy);
csvwrite('./RMTMotifEntropy.csv', RMTMotifEntropy);
% potentially save entropy values to files
fprintf('All done .\n');