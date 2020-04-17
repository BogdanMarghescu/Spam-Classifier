function word_indices = processEmail(filename, vocabList)
%PROCESSEMAIL preprocesses a the body of an email and
%returns a list of word_indices of the words contained in the email.
%
  email_contents = readFile(filename);
  word_indices = [];  % Init return value
  % ========================== Preprocess Email ===========================
  % Find the Headers ( \n\n and remove )
  % Uncomment the following lines if you are working with raw emails with the full headers

  %hdrstart = strfind(email_contents, ([char(10) char(10)]));
  %email_contents = email_contents(hdrstart(1):end);

  email_contents = lower(email_contents); % Lower case
  % Strip all HTML: looks for any expression that starts with < and ends with > 
  % and does not have any < or > in the tag and replace it with a space
  email_contents = regexprep(email_contents, '<[^<>]+>', ' ');
  email_contents = regexprep(email_contents, '[0-9]+', 'number'); % Handle Numbers
  email_contents = regexprep(email_contents, '(http|https)://[^\s]*', 'httpaddr');  % Handle URLS, look for strings starting with http:// or https://
  email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr'); % Handle Email Addresses, look for strings with @ in the middle
  email_contents = regexprep(email_contents, '[$]+', 'dollar'); % Handle $ sign

  % ========================== Tokenize Email ===========================
  fprintf('\n==== Processed Email ====\n%s\n\n', filename); % Output the email to screen as well
  l = 0;  % Process file

  while ~isempty(email_contents)
    [str, email_contents] = strtok(email_contents, [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);  % Tokenize and also get rid of any punctuation
    str = regexprep(str, '[^a-zA-Z0-9]', ''); % Remove any non alphanumeric characters
    % Stem the word(the porterStemmer sometimes has issues, so we use a try catch block)
    try str = porterStemmer(strtrim(str)); 
    catch str = ''; continue;
    end;
    if length(str) < 1    % Skip the word if it is too short
       continue;
    end
    if length(str) > 40    % Skip the word if it is too long
       continue;
    end
    % Look up the word in the dictionary and add to word_indices if found
    index = find(strcmp(str, vocabList), 1);
    word_indices = [word_indices; index];
    % Print to screen, ensuring that the output lines are not too long
    if (l + length(str) + 1) > 78
        fprintf('\n');
        l = 0;
    end
    fprintf('%s ', str);
    l = l + length(str) + 1;
  end
  fprintf('\n\n=========================\n\n'); % Print footer
end