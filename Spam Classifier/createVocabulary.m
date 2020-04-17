function vocabList = createVocabulary(allWords, vocabSize)
% Creates a vocabulary list based on a list of all words used by a dataset
% and writes it to a file
  [fWordList, freq] = frequentWordList(allWords);
  vocabList = (sort(fWordList(1:vocabSize)))';
  fileID = fopen('vocab.txt','wt');
  for i=1:vocabSize
    fprintf(fileID, '%d\t%s\n', i, vocabList{i});
  end
  fclose(fileID);
end