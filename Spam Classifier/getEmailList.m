function EmailList = getEmailList(path)
# returns a list of all email text files from a specified path
  EmailList = dir(fullfile(path,'**/*'));
end