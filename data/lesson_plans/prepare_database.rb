#!/usr/bin/env ruby

require 'nokogiri'
require 'sequel'
require 'fileutils'

#
# prepare_database.rb: Load words to common db for creating lesson plans.
#

FileUtils.rm "./all_words.db"
all_db    = Sequel.connect('sqlite://all_words.db')
tanakh_db = Sequel.connect('sqlite://../tanakh_hebrew_word_frequency_database/tanakh_and_sidur_word_frequency.db')
modern_db = Sequel.connect('sqlite://../modern_hebrew_words_containing_a_letter/modern_word_frequency.db')

unless all_db.table_exists? :words
  all_db.create_table :words do
    primary_key :id
    String :word
    Integer :count
    Integer :nikuds
    Integer :len
  end
end

puts "Importing tankh/siddur words..."
all_words = all_db[:words] # Create a dataset
tanakh_db['select * from word_counts'].each do |row|
  all_words.insert(row)
end
puts "Importing modern words..."
modern_db['select * from words'].each do |row|
  found = false
  all_words.where(:word => row[:word]).each do |all_row|
    found = true
    count = row[:count] + all_row[:count]
    all_words.where(:word => row[:word]).update(count: count)
  end
  if found == false
    row.delete :word_bare
    all_words.insert(row)
  end
end
puts "Combined database in all_words.db"
