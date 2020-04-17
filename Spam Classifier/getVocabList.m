function vocabList = getVocabList(vocab_filename)
%GETVOCABLIST reads the fixed vocabulary list in vocab.txt and returns a
%cell array of the words
%   vocabList = GETVOCABLIST() reads the fixed vocabulary list in vocab.txt 
%   and returns a cell array of the words in vocabList.
  fid = fopen(vocab_filename);  %% Read the fixed vocabulary list
  % For ease of implementation, we use a struct to map the strings => integers
  % In practice, you'll want to use some form of hashmap
  vocabList = textscan(fid, "%d %s");  % Store all dictionary words in cell array vocabList{}
  vocabList = vocabList{2};
  fclose(fid);
end