
# Show all clang versions available as Debian package.
alias debian-version-list-clang='apt-cache search clang | cut -f 1 -d " " | sort | grep -e "^clang-[0-9].[0-9]$"'

# Show all Emacs versions available as Debian package.
alias debian-version-list-emacs='apt-cache search emacs | cut -f 1 -d " " | sort | grep -e "^emacs[0-9][0-9]$"'
