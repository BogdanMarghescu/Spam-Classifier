function word_indices = processWordList(wordList, vocabList)
% translates a word list into its position in the vocabList
  word_indices = [];  % Init return value
  for i = 1:length(wordList)
    index = find(strcmp(wordList(i), vocabList), 1);
    word_indices = [word_indices; index];
  end
end