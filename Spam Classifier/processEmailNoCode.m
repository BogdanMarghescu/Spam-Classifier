function word_list = processEmailNoCode(filename)
% PROCESSEMAIL preprocesses a the body of an email and
% returns a list of words contained in the email.
%
  email_contents = readFile(filename);
  word_list = {};  % Init return value
  i = 1;
  % ========================== Preprocess Email ===========================
  hdrstart = strfind(email_contents, ([char(10) char(10)]));  % Find the Headers ( \n\n and remove )
  email_contents = email_contents(hdrstart(1):end);
  email_contents = lower(email_contents); % Lower case
  % Strip all HTML: looks for any expression that starts with < and ends with > 
  % and does not have any < or > in the tag and replace it with a space
  email_contents = regexprep(email_contents, '<[^<>]+>', ' ');
  email_contents = regexprep(email_contents, '[0-9]+', 'number'); % Handle Numbers
  email_contents = regexprep(email_contents, '(http|https)://[^\s]*', 'httpaddr');  % Handle URLS, look for strings starting with http:// or https://
  email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr'); % Handle Email Addresses, look for strings with @ in the middle
  email_contents = regexprep(email_contents, '[$]+', 'dollar'); % Handle $ sign

  % ========================== Tokenize Email ===========================
  while ~isempty(email_contents)
    [str, email_contents] = strtok(email_contents, [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);  % Tokenize and also get rid of any punctuation
    str = regexprep(str, '[^a-zA-Z0-9]', ''); % Remove any non alphanumeric characters
    % Stem the word(the porterStemmer sometimes has issues, so we use a try catch block)
    try str = porterStemmer(strtrim(str)); 
    catch str = ''; continue;
    end;
    if length(str) < 2    % Skip the word if it is too short
       continue;
    end
    if length(str) > 40    % Skip the word if it is too long
       continue;
    end
    word_list{i, 1} = str;
    i = i + 1;
  end
  word_list{:};
end