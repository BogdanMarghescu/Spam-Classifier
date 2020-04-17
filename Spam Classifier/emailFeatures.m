function x = emailFeatures(word_indices, vocabList)
%EMAILFEATURES takes in a word_indices vector and produces a feature vector
%from the word indices
  x = zeros(size(vocabList'));  % You need to return the following variables correctly.
  x(word_indices) = 1;
end