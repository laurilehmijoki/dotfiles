export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=$PATH:~/bin

# "hh:mm current_dir $"
export PS1="\[\e[0;35m\]\A\[\e[m\] (\[\e[4;33m\]\h\[\e[m\]) \[\e[1;32m\]\W\[\e[m\] $ "

if [ "$(uname)" == "Darwin" ] ; then
  # Mac

  export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
else
  alias ls="ls --color"
  alias ack=ack-grep
fi

alias du-sum="du --max-depth=1 . | sort -n"

$(which ruby > /dev/null)
if [ $? -eq 0 ]; then
  HAS_RUBY=1
fi

if [ -z $HAS_RUBY ]; then
  echo ""
  ~/.yogasutras/echo-sutras 1 2
  echo ""
else
  # print some yoga sutras from the bookmarks
  echo ""
  ~/.yogasutras/bookmark-reader.rb
  echo ""
fi
