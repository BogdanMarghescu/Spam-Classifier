function p = spamClassify (labelList, filenameList, vocabList, model) 
% Read and predict email text files based on a trained model, and compares the
% accuracy with the labels provided by the user
  filenameCount = length(filenameList);
  features = zeros(filenameCount, size(vocabList, 1));
  for i=1:filenameCount
    word_indices  = processEmail(filenameList{i}, vocabList);
    features(i,:) = emailFeatures(word_indices, vocabList);  
  end
  p = svmpredict(labelList, features, model);
end