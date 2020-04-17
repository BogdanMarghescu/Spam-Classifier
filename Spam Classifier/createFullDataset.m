function createFullDataset(emailDirectory, vocabSize)
% Creates the full dataset(spamTrain.mat, spamtest.mat, vocab.txt)
%  
  [wordMatrixSpam, wordMatrixtNonSpam, vocabList] = extractData(emailDirectory, vocabSize);
  [features, labelList] = createData(wordMatrixSpam, wordMatrixtNonSpam, vocabList);
  saveData(features, labelList);
end