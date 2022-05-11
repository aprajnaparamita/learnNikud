#!/usr/bin/env ruby

require 'nokogiri'
require 'sequel'

#
# add_nikud_words.rb: Add nikud_words table
#

def pack_complex(code_point)
  combined = ''
  code_point.split(/\s+/).each do |cp|
    combined += [cp.hex].pack("U")
  end
  return combined
end

all_db    = Sequel.connect('sqlite://all_words.db')
all_db.drop_table :nikuds_words
unless all_db.table_exists? :nikuds_words
  all_db.create_table :nikuds_words do
    primary_key :id
    Integer :word_id
    Integer :nikud_id
  end
end

puts "Building nikuds_words..."
words  = all_db[:words]
nikuds = []
all_db['select * from nikuds'].each do |row|
  row[:nikud] = pack_complex(row[:code_point])
  nikuds.push row
end

nikuds_words_table= all_db[:nikuds_words]
all_db['select * from words'].each do |row|
  nikuds.each do |nikud_row|
    if row[:word] =~ /#{nikud_row[:nikud]}/
      word_id = row[:id]
      nikud_id = nikud_row[:id]
      nikuds_words_table.insert({ word_id: word_id, nikud_id: nikud_id })
    end
  end
end
puts "Created nikuds_words in all_words.db"
puts "Now run: ruby create_letters.rb"
