function v --description "Edit recently opened files in vim"
    grep "^>" ~/.cache/vim/viminfo | cut -c3- | while read line; set line (string replace -r "~" $HOME $line); if [ -f $line ]; echo $line; end; end | fzf -m --header="vim recently opened" | xargs -o vim --
end
