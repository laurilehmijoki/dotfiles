# Load RVM into a shell session *as a function*

TOOLS=$HOME/Dropbox/Tools/bin
NPM=/usr/local/share/npm/bin
RVM=$HOME/.rvm/bin
CABALBIN=$HOME/Library/Haskell/bin

export ANDROID_HOME=/usr/local/opt/android-sdk # brew install android-sdk

export PATH=/usr/local/sbin:~/bin:~/bin/local:/opt/local/bin:/opt/local/sbin:$RVM:$CABALBIN:$TOOLS:$NPM:$ANDROID_SDK:$PATH

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export NVM_DIR="/Users/llehmijo/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
