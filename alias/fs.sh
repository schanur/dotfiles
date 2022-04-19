
# List number of all files in all sub directories.
alias sumfa='du -a | cut -d/ -f2 | sort | uniq -c | sort -nr'

# List number of files in all sub directories but ignore hidden files
# and files matched by .gitignore
alias sumfi='fdfind | cut -d/ -f1 | sort | uniq -c | sort -nr'
