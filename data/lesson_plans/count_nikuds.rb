#!/usr/bin/env ruby

require 'sequel'
require 'json'

nikuds = JSON.parse(File.read("../nikud.json"))
tanakh_db = Sequel.connect('sqlite://../tanakh_hebrew_word_frequency_database/tanakh_and_sidur_word_frequency.db')
modern_db = Sequel.connect('sqlite://../modern_hebrew_words_containing_a_letter/modern_word_frequency.db')
all_db    = Sequel.connect('sqlite://all_words.db')

def pack_complex(code_point)
  combined = ''
  code_point.split(/\s+/).each do |cp|
    combined += [cp.hex].pack("U")
  end
  return combined
end

puts "Collecting nikud counts..."
counts = {}
[tanakh_db, modern_db].each do |db|
  db['select word, count(*) as cnt from words group by word order by cnt desc'].each do |row|
    nikuds.keys.each do |name|
      nikud = pack_complex(nikuds[name]['code_point'])
      if row[:word] =~ /#{nikud}/
        if counts.has_key? name
          counts[name] += row[:cnt].to_i
        else
          counts[name] = 1
        end
      end
    end
  end
end

unless all_db.table_exists? :nikuds
  all_db.create_table :nikuds do
    primary_key :id
    String :english_name
    String :hebrew_name
    String :code_point
    String :sounds
    String :vowel_sound
    String :description
    Integer :count
  end
end

puts "Creating nikds in all_words.db"
nikuds_table= all_db[:nikuds] # Create a dataset
sorted_keys = counts.sort_by {|k,v| -v}
sorted_keys.each do |english_name|
  english_name = english_name.first
  puts "English name: #{english_name}"
  row          = nikuds[english_name]
  row['count'] = counts[english_name]
  row['english_name'] = english_name
  p row
  nikuds_table.insert(row)
end
puts "Created nikuds in all_words.db"
puts "Now run add_nikud_counts.rb"
