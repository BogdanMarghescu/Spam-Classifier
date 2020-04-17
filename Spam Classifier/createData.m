function [features, labelList] = createData(wordMatrixSpam, wordMatrixtNonSpam, vocabList)
% Based on 2 labeled word matrixes, creates the features and labels for the
% dataset, using vocabList
% 
  features = zeros((length(wordMatrixSpam) + length(wordMatrixtNonSpam)), size(vocabList, 1));
  fprintf('Creating features for the spam category...\n\n');
  for i=1:length(wordMatrixSpam)
    word_indices_spam = processWordList(wordMatrixSpam{i}, vocabList);
    features(i,:) = emailFeatures(word_indices_spam, vocabList);  
  end
  
  fprintf('Creating features for the non-spam category...\n\n');
  for i=1:length(wordMatrixtNonSpam)
    word_indices_non_spam = processWordList(wordMatrixtNonSpam{i}, vocabList);
    features(i + length(wordMatrixSpam),:) = emailFeatures(word_indices_non_spam, vocabList);  
  end
  
  % Create label list
  labelList = ones(length(wordMatrixSpam), 1);
  labelList = [labelList; zeros(length(wordMatrixtNonSpam), 1)];
  
  % Shuffle data
  permutation = randperm(size(labelList, 1));
  features = features(permutation, :);
  labelList = labelList(permutation);
end