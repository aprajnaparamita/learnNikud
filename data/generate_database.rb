#!/usr/bin/env ruby

require 'json'
require 'sequel'

nikuds  = JSON.parse(File.read("nikud.json"))
letters = JSON.parse(File.read("full.json"))
modern_db = Sequel.connect('sqlite://modern_hebrew_words_containing_a_letter/modern_word_frequency.db')
tanakh_db = Sequel.connect('sqlite://tanakh_hebrew_word_frequency_database/tanakh_word_frequency.db')


#
# generate_database.rb: Generate a database with every combination.
#

count = 0
elements = []
missing = []
letters.each_key do |letter|
  nikuds.each_key do |nikud_name|
    row = letters[letter].dup
    row['nikud'] = nikud_name
    row['english_name'] = "#{row['english_name']} #{nikud_name.downcase}"
    nikuds[nikud_name].each_key do |key|
      row[key]=nikuds[nikud_name][key]
    end
    row['combined'] = ''
    row['combined'] += letter
    row['code_point'].split(/\s+/).each do |cp|
      row['combined'] += [cp.hex].pack("U")
    end

    # Remove duplicates where both sets have the top
    # result be the same word.
    examples = {}
    modern_db["select * from words where word like '%#{row['combined']}%' order by count desc limit 1"].each do |r|
      examples[ r[:word] ] = true
    end
    tanakh_db["select * from word_counts where word like '%#{row['combined']}%' order by count desc limit 1"].each do |r|
      examples[ r[:word] ] = true
    end
    if examples.keys.length > 0
      row['examples'] = [examples.keys]
      elements.push row
    else
      missing.push row
    end
    count += 1
  end
end

puts "Total: #{count}"
puts "With examples: #{elements.length}"
#puts missing.to_json

File.open("alephbet_with_nikud.json", "w") do |f|
  f.write elements.to_json
end
