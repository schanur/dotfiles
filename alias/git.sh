
# git SVN
alias gs-pull='git svn fetch   && git svn rebase'
alias gs-sync='gs-pull         && git svn dcommit'
alias gs-pull_dirty='git stash && gs-pull &&                    git stash pop'
alias gs-sync_dirty='git stash && gs-pull && git svn dcommit && git stash pop'

# Remove all remotes
alias git-remove-all-remotes='for GIT_REMOTE in $(git remote); do git remote remove ${GIT_REMOTE}; done'
