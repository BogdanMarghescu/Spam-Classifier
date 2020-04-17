function [wordMatrix allWords] = fullWordList(filename)
% creates a matrix of all words met in all emails and a long array of them  
  emailList = getEmailList(filename);
  for i = 1:length(emailList)
    fprintf('Iteration: %d\tFile:%s\n', i, emailList(i).name);
    wordMatrix{i} = processEmailNoCode([emailList(i).folder '\' emailList(i).name]);
  end
  allWords=cat(1, wordMatrix{:});
end