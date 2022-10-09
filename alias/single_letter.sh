
# Check that no single letter abbr is already in use.

for letter in {a..z}
do
    IN_USE=1
    which ${letter} > /dev/null || IN_USE=0
    if [ ${IN_USE} -eq 1 ]; then
        echo "${letter} already in use."
    fi
done
unset IN_USE


function single-letter-abbr-list() {
    local IN_USE
    for letter in {a..z}
    do
        IN_USE=1
        which ${letter} > /dev/null || IN_USE=0
        if [ ${IN_USE} -eq 1 ]; then
            which ${letter}
        fi
    done
}


which tmux > /dev/null
alias a='tmux attach'

which batcat > /dev/null
alias b='batcat'

# Compare
alias c='delta'

alias d='du --max-depth=1'

# Modern ls replacement. git options are currently only compatible
# with Cargo version. Not with Debian repo version.
which exa > /dev/null
alias e='exa -lagb -@ --git --color=always'

# alias f=''

which git > /dev/null
alias g='git'

# alias h=''

# alias i=''

# alias j=''

# alias k=''

# Show hidden files only.
alias l='echo "Use exa."'
# alias l='ls -l'

# alias m=''

# alias n=''

# alias o=''

# alias p='ping'

# alias q=''

# alias r=''

which skim > /dev/null
alias s='sk'

which tmux > /dev/null
alias t='tmux -2'

# alias u=''

# alias v=''

# alias w=''

# alias x=''

# alias y=''

alias z='zoxide'
