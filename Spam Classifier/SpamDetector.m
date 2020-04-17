clear ; close all; clc
vocab_filename = 'vocab.txt'; % Text file containing the words used to process the emails
vocabList = getVocabList(vocab_filename);

fprintf('Training Linear SVM (Spam Classification)\n')
load('spamTrain.mat');
C = 0.1;
model = svmtrain(y, X, cstrcat("-t 0 -c ", num2str(C)));
fprintf('\nEvaluating the training accuracy ...\n');
p = svmpredict(y, X, model);

fprintf('\nEvaluating the accuracy of the model using k-folds validation for C = %d...\n', C);
acc = svmtrain(y, X, cstrcat("-t 0 -v 25 -c ", num2str(C)));
fprintf('\nAccuracy using k-folds validation for C = %d:\t%f%%', C, acc);

load('spamTest.mat');
fprintf('\nEvaluating the trained Linear SVM on a test set ...\n');
ptest = svmpredict(ytest, Xtest, model);

weight = model.SVs' * model.sv_coef;
[weight, idx] = sort(weight, 'descend');% Sort the weights and obtain the vocabulary list
fprintf('\nTop predictors of spam: \n');
for i = 1:20
    fprintf(' %-15s (%f) \n', vocabList{idx(i)}, weight(i));
end
fprintf('\n\nProgram paused. Press enter to continue.\n\n');  pause;

% Set the files to be read in
filenameList = {'spamSample1.txt', 'spamSample2.txt', 'emailSample1.txt', 'emailSample2.txt'};
labelList = [1; 1; 0; 0];
spamMessage = {'NOT SPAM', 'SPAM'};
pred = spamClassify(labelList, filenameList, vocabList, model);
for i=1:length(filenameList)
  fprintf('\nProgram paused. Press enter to continue.\n\n\n');  pause; 
  fprintf('\nProcessed Email: %s\nSpam Classification: %s\n', filenameList{i}, spamMessage{pred(i) + 1});
end