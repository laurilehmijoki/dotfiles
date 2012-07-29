export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export HISTFILESIZE=10000 # Record last 10,000 commands
export HISTSIZE=10000 # Record last 10,000 commands per session
export HISTCONTROL=ignoredups

export REBEL_HOME=~/Dropbox/Tools/jrebel-5.0.0

export EDITOR=vim

# Git stuff
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
source ~/bin/git-completion.bash

# Prompt
export PS1='\[\e[0;35m\]\A\[\e[m\] (\[\e[4;33m\]\h\[\e[m\] @ $(__git_ps1 '%s')) \[\e[1;32m\]\w\[\e[m\] $ '

if [ "$(uname)" == "Darwin" ] ; then
  # Mac
  export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
  alias du-sum="du -skc *"
  source ~/.osx
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
alias greak="cd ~/ReaktorCode"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

[[ -r ~/.bashrc ]] && source ~/.bashrc
