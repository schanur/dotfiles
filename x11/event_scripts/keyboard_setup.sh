#!/bin/bash


# The IBM Model M keyboard has no "win" key. We map caps lock to "win"
# key instead. Using "alt" key is no alternative as too many programs
# (Emacs) rely on it.
setxkbmap -option caps:super
