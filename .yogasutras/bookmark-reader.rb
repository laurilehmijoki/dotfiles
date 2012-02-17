#!/usr/bin/env ruby
#Print one or more bookmarked yoga sutras at random

require 'yaml'

def random_bookmark
  sutra_bookmarks = YAML::load(File.open(File.dirname(__FILE__)+'/sutra-bookmarks.yml')) # Read the bookmarks from the YAML file
  pada = 1 + rand(sutra_bookmarks.length) # Pick a random pada
  bookmarks = sutra_bookmarks["Pada #{pada}"]
  bookmark = bookmarks[rand(bookmarks.length)] # Pick a random bookmark within the pada
  
  if bookmark.to_s.match(/^\d+$/) 
    # The bookmark is an integer, which refers to a sutra
    sutra_number = bookmark.to_i 
    puts `#{File.dirname(__FILE__)}/echo-sutras #{pada} #{sutra_number}`
  else
    # The bookmark is a range of yoga sutras
    bookmark.scan(/(\d+)-(\d+)/) { |start, stop|
      puts `#{File.dirname(__FILE__)}/echo-sutras #{pada} #{start} #{stop}`
    }
  end
end

random_bookmark
