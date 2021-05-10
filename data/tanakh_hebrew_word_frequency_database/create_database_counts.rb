#!/usr/bin/env ruby

require 'json'
require 'sequel'

DB = Sequel.connect('sqlite://tanakh_and_sidur_word_frequency.db')
unless DB.table_exists? :word_counts
  DB.create_table :word_counts do
    String :word
    Integer :count
  end
end

words_table = DB[:word_counts] # Create a dataset
DB['select word, count(*) as cnt from words group by word order by cnt desc'].each do |row|
  p row
  words_table.insert(:word => row[:word], :count => row[:cnt])
end

puts "SUCCESS! Your database is now prepared in: tanakh_and_sidur_word_frequency.db"
