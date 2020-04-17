function [wordList freq] = frequentWordList (wordArray)
# Returns a list of all unique words from an array of words, 
# ordered by their frequency   
  [uniqueWords, ~, J]=unique(wordArray); 
  freq = histc(J, 1:numel(uniqueWords));
  [freq, idx] = sort(freq, 'descend');
  for i=1:length(freq)
    wordList{i} = uniqueWords{idx(i)};
  end
end