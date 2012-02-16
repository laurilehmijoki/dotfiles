export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=$PATH:~/bin

if [ "$(uname)" == "Darwin" ] ; then
  # Mac
  export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home

  # "hh:mm current_dir $"
  export PS1="\[\e[0;35m\]\A\[\e[m\] \[\e[1;32m\]\W\[\e[m\] $ "
fi

