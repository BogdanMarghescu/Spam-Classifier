function [wordMatrixSpam, wordMatrixtNonSpam, vocabList] = extractData(emailDirectory, vocabSize)
% Extracts data from a directory, converts the emails into 2 word matrices
% and creates a vocabulary of size vocabSize
%
  fprintf('Extracting all the words from the spam category...\n\n');
  [wordMatrixSpam, allWordsSpam] = fullWordList([emailDirectory '/Spam']);
  fprintf('Extracting all the words from the non-spam category...\n\n');
  [wordMatrixtNonSpam, allWordsNonSpam] = fullWordList([emailDirectory '/Non-spam']);
  allWords = cat(1, allWordsNonSpam, allWordsSpam);
  fprintf('Creating vocabulary list...\n\n');
  vocabList = createVocabulary(allWords, vocabSize);
end