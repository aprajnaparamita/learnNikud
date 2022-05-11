#!/usr/bin/env ruby

require 'sequel'
require 'json'
require 'titleize'

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
all_db.drop_table :letter_nikuds if all_db.table_exists? :letter_nikuds
unless all_db.table_exists? :letter_nikuds
  all_db.create_table :letter_nikuds do
    primary_key :id
    Integer :letter_id
    Integer :nikud_id
    String :combined
    String :name
    Integer :count
  end
end
all_db.drop_table :letters if all_db.table_exists? :letters
unless all_db.table_exists? :letters
  all_db.create_table :letters do
    primary_key :id
    String :letter
    String :name
    Integer :count
  end
end

letters_with_nikud = JSON.parse(File.read("../alephbet_with_nikud.json"))
letters            = JSON.parse(File.read("../full.json"))

puts "Building letters..."
words  = all_db[:words]
out = []
letters.keys.each do |letter|
  em = letters[letter]
  all_db["select count(*) as cnt from words where word like '%#{letter}%'"].each do |row|
    out.push [letter, em, row[:cnt]]
  end
end

# So we need to move yod and vav further in the set
# even though these are the most common letter it is
# because they are stand-ins for the divine name and
# the prefix word "and"
out = out.sort { |a,b| b[2] <=> a[2] }
first2 = out[0 .. 1]
out.shift(2)
next4  = out[0 .. 4]
out.shift(5)
out = [*next4, *first2, *out]
letters_table= all_db[:letters]
i = 0
out.each do |letter|
  i += 1
  letter.push i
  letters_table.insert({ letter: letter[0], name: letter[1]['english_name'], count: letter[2] })
end

out.each do |letter|
  letters_with_nikud.each do |nikud|
    if nikud['letter_english_name'] == letter[1]['english_name']
      all_db["select count(*) as cnt from words where word like '%#{nikud['combined']}%'"].each do |row|
        nikud['count'] = row[:cnt]
        nikud['letter_id'] = letter[3]
      end
    end
  end
end


out = letters_with_nikud.sort { |a,b| b['count'] <=> a['count'] }
letter_nikuds_table= all_db[:letter_nikuds]
out.each do |letter_nikud|
  all_db["select id from nikuds where english_name='#{letter_nikud['nikud_english_name'].titleize}'"].each do |row|
    letter_nikud['nikud_id'] = row['id']
  end
  row = {
    letter_id: letter_nikud['letter_id'],
    nikud_id: letter_nikud['nikud_id'],
    combined: letter_nikud['combined'],
    name: letter_nikud['english_name'],
    count: letter_nikud['count']
  }
  letter_nikuds_table.insert(row)
end

puts "Created letter_nikuds in all_words.db"
