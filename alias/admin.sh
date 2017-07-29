# 'du space' Show first 30 folders that use most space.
alias dus='du -h --max-depth=1 2>/dev/null | sort -r -h | head -n 30'
