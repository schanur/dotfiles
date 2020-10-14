# Rip CD and encode to FLAC. Stop if CD does not match an entry in
# Freedb database.
alias rip-cd-flac='ripit -o . -c 2 -q 8 --nointeraction --quitnodb 1'

# Start in fullscreen mode and with scale to fit.
# sxiv still has no way to start with anti aliasing disabled.
alias sxiv='sxiv -f -s f'

# Record the sound mix that goes to the speaker.
# Call with WAV64 filename as parameter.
# Example: soundcard_grep soundfile.w64
alias soundcard_grep='parec -d alsa_output.pci-0000_00_1f.3.analog-stereo.monitor --file-format=w64'
