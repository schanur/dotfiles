
# git SVN
alias gs-pull='git svn fetch   && git svn rebase'
alias gs-sync='gs-pull         && git svn dcommit'
alias gs-pull_dirty='git stash && gs-pull &&                    git stash pop'
alias gs-sync_dirty='git stash && gs-pull && git svn dcommit && git stash pop'

# Remove all remotes
alias git-remove-all-remotes='for GIT_REMOTE in $(git remote); do git remote remove ${GIT_REMOTE}; done'

# Dangerous!
alias git-brutal-credential-fix='git-change-credentials -a b.griebenow@web.de "Bjoern Griebenow" && rm -rfv .git/refs/original/refs/heads/master && git push -u github --all  --force'
alias gbcf='git-brutal-credential-fix'

alias git-search-history='git rev-list --all | xargs git grep'
