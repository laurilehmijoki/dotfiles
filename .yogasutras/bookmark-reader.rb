#!/usr/bin/env ruby
#Print one or more bookmarked yoga sutras at random

require 'yaml'

def random_bookmark
  sutra_bookmarks = YAML::load(File.open(File.dirname(__FILE__)+'/sutra-bookmarks.yml')) # Read the bookmarks from the YAML file

  bookmark = sutra_bookmarks[rand(sutra_bookmarks.length)]
  case bookmark
    when /^(\d),\s*(\d+)$/
      pada = $1
      sutra = $2
      echo_bookmark(pada, sutra)
    when /^(\d),\s*(\d+)-(\d+)$/
      pada = $1
      start = $2
      stop = $3
      echo_bookmark(pada, start, stop)
    else 
      abort("Illegal bookmark: #{bookmark}")
  end
end

def echo_bookmark(pada, start, stop=nil)
 puts `#{File.dirname(__FILE__)}/echo-sutras #{pada} #{start} #{stop}` 
end

random_bookmark
