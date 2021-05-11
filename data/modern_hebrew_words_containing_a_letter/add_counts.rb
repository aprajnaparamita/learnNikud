#!/usr/bin/env ruby

require 'nokogiri'
require 'sequel'

#
# prepare_database.rb: Load words from fequency results.
#
DB = Sequel.connect('sqlite://modern_word_frequency.db')
#DB.run("ALTER TABLE words ADD COLUMN nikuds int")
#DB.run("ALTER TABLE words ADD COLUMN len int")

words_table = DB[:words] # Create a dataset
words_table.each do |row|
  p row
  nikuds = row[:word].scan(/[\u0591-\u05C7]/m).size
  words_table.where(:word => row[:word]).update(:len => row[:word].length)
  words_table.where(:word => row[:word]).update(:nikuds => nikuds)
end

puts "SUCCESS! Added the counts"
