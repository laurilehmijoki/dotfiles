export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export TERM=xterm-256color

export HISTFILESIZE=10000 # Record last 10,000 commands
export HISTSIZE=10000 # Record last 10,000 commands per session
export HISTCONTROL=ignoredups
shopt -s histappend # Append history
PROMPT_COMMAND='history -a' # Flush history on new prompt

export EDITOR=vim
LC_ALL="en_US.UTF-8"
export LC_ALL

# Git stuff
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
source ~/bin/git-completion.bash

# Prompt
if [ `tput cols` -ge 120 ]; then
  export PS1='\[\e[0;35m\]\A\[\e[m\] (\[\e[4;33m\]\h\[\e[m\] @ $(__git_ps1 '%s')) \[\e[1;32m\]\w\[\e[m\] $ '
else
  export PS1='\[\e[0;35m\]\A\[\e[m\] (\[\e[4;33m\]\h\[\e[m\] @ $(__git_ps1 '%s')) \[\e[1;32m\]\w\[\e[m\] $\n> '
fi

if [ "$(uname)" == "Darwin" ] ; then
  # Mac
  alias du-sum="du -skc * | sort -n"
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
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
      || complete -o default -o nospace -F _git g # Enable git auto-complete for g

alias ed='ed -p "ed> "'

# Dir shortcuts
alias gproj="cd ~/Dropbox/Projects"
alias gp=gproj
alias gdocs="cd ~/Dropbox/Docs"
alias greak="cd ~/ReaktorCode"
alias gr=greak

alias aa="ack --all"

[[ -r ~/.bashrc ]] && source ~/.bashrc
[[ -r ~/.javaconfigs ]] && source ~/.javaconfigs
[[ -r ~/Dropbox/Security/aws.credentials ]] && source ~/Dropbox/Security/aws.credentials
~/bin/crontab_report

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
