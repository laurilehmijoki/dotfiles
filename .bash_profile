export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=$PATH:~/bin:~/Install/scala/bin

export HISTFILESIZE=10000 # Record last 10,000 commands
export HISTSIZE=10000 # Record last 10,000 commands per session

export EDITOR=vim

# "hh:mm current_dir $"
export PS1="\[\e[0;35m\]\A\[\e[m\] (\[\e[4;33m\]\h\[\e[m\]) \[\e[1;32m\]\w\[\e[m\] $ "

if [ "$(uname)" == "Darwin" ] ; then
  # Mac

  export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
else
  alias ls="ls --color"
  alias ack=ack-grep
fi

alias du-sum="du --max-depth=1 . | sort -n"
alias grep="grep --color"
alias egrep="egrep --color"
alias rspec="rspec --color"

# Dir shortcuts
alias gproj="cd ~/Dropbox/Projects"
alias gdocs="cd ~/Dropbox/Docs"

$(which ruby > /dev/null)
if [ $? -eq 0 ]; then
  HAS_RUBY=1
fi

# Fink
test -r /sw/bin/init.sh && . /sw/bin/init.sh
