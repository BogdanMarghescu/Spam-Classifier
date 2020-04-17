function saveData(features, labelList)
% save the datase into 3 files: train, validation and test  
  X = features(1:(end-1700), :);
  y = labelList(1:(end-1700), :);
  save spamTrain.mat X y;
  
  Xtest = features((end-1699):end, :);
  ytest = labelList((end-1699):end, :);
  save spamTest.mat Xtest ytest;  
end