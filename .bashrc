# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

TOOLS=$HOME/Dropbox/Tools/bin
NPM=/usr/local/share/npm/bin
export PATH=/usr/local/sbin:~/bin:~/bin/local:/opt/local/bin:/opt/local/sbin:$RVM:$TOOLS:$NPM:$PATH
