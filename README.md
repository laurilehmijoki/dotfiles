# Dotfiles

<http://lauri.lehmijoki.net/en/nerd/on-importance-of-having-dotfiles-in-github.html>

## Setup

````bash
cd ~ 
git init
git remote add origin https://github.com/laurilehmijoki/dotfiles.git # or git@github.com:laurilehmijoki/dotfiles.git
git pull -u origin master
````

## VIM

### Installing plugins

    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    vim -c 'BundleInstall'

#### Command-T

    cd ~/.vim/bundle/command-t/ruby/command-t
    which rvm && rvm use system # Use the Ruby against which VIM was linked
    ruby extconf.rb
    make

## Cronjobs

### Monitoring

The `.bash_profile` file automatically monitors the `~/.crontab.log` file.
You can benefit from the monitoring by creating cronjobs like this:

    * * * * * normalise-iphone-photo-and-video-names ~/Dropbox/Photos/2012/roadtrip >> ~/.crontab.log

The monitoring means printing the latest cronjob log entries when you log in.
See `bin/crontab_report` for more info.
