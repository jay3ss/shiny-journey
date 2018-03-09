function [deadTrain_norm, deadTest_norm] =  dataPrep(deadData, sampleSplit)


% Split data, let 40 samples be training set data
deadTrain = deadData(1:sampleSplit, :);
deadTest = deadData(sampleSplit+1:end, :);



end