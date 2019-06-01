# dotfiles

## All my config files. Tested with Debian stable and Debian testing.

It uses the [bivalvia](https://github.com/schanur/libbivalvia) bash library for some more complex scripts.

Currently contains:
   * A lot of aliases and scripts to make the output of programs more useful/colorful
   * A dark theme for following GUI toolkits: Qt5/Qt4/GTK3/GTK2 (Adwaita-dark)
   * Load same config files with and without login manager
   * Nice default config for git
   * Dark theme for the command line music player moc
   * Dark theme for midnight commander
   * Config file for the music player MOC
   * Config file for rofi application launcher
   * rc files for Bash and Zsh
   * software package group manager with similar functionality to Debians tasksel
   * i3 config
   * tmux config
   * More than 40 scripts that makes your life easier.

Multible subrepositories are used for additional features:
   * schanur/aftermath gives a nice terminal status line after each command
   * schanur/emacs.d as Emacs config
   * schanur/libbivalvia is a Bash library which features are used in many scripts
   * robbyrussell/oh-my-zsh as a solid base for our zsh config
   * github.com/rubo77/rsync-homedir-excludes for more network resource friendly rsync operations
