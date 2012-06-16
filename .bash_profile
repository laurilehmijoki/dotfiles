export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export PATH=~/bin:/opt/local/bin:/opt/local/sbin:$PATH

export HISTFILESIZE=10000 # Record last 10,000 commands
export HISTSIZE=10000 # Record last 10,000 commands per session

export EDITOR=vim

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ @ \1/'
}
export PS1='\[\e[0;35m\]\A\[\e[m\] (\[\e[4;33m\]\h\[\e[m\]$(parse_git_branch)) \[\e[1;32m\]\w\[\e[m\] $ '

if [ "$(uname)" == "Darwin" ] ; then
  # Mac
  export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
  # Set a shorter Delay until key repeat (requires OS restart to take effect)
  defaults write NSGlobalDomain InitialKeyRepeat -int 12
  # Set a blazingly fast keyboard repeat rate (requires OS restart to take effect)
  defaults write NSGlobalDomain KeyRepeat -int 0.02
  defaults write com.apple.finder AppleShowAllFiles TRUE
  alias du-sum="du -skc *"
else
  # Linux
  alias ls="ls --color"
  alias ack=ack-grep
  alias du-sum="du --max-depth=1 . | sort -n"
  export TZ=Europe/Helsinki
fi

alias grep="grep --color"
alias egrep="egrep --color"
alias rspec="rspec --color"
alias sb="source ~/.bash_profile; echo Sourced .bash_profile"
alias g=git
alias ed='ed -p "ed> "'

# Dir shortcuts
alias gproj="cd ~/Dropbox/Projects"
alias gdocs="cd ~/Dropbox/Docs"
alias greak="cd ~/Dropbox/Projects/Reaktor"

$(which ruby > /dev/null)
if [ $? -eq 0 ]; then
  HAS_RUBY=1
fi
