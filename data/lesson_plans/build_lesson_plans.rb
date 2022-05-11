#!/usr/bin/env ruby

require 'sequel'
require 'json'

#
# build_lesson_plans.rb: Methodically create lesson plans.
#

def pack_complex(code_point)
  combined = ''
  code_point.split(/\s+/).each do |cp|
    combined += [cp.hex].pack("U")
  end
  return combined
end

all_db    = Sequel.connect('sqlite://all_words.db')
all_db.drop_table :questions if all_db.table_exists? :questions
unless all_db.table_exists? :questions
  all_db.create_table :questions do
    primary_key :id
    Integer :lesson_id
    Integer :nikud_id
  end
end
all_db.drop_table :answers if all_db.table_exists? :answers
unless all_db.table_exists? :answers
  all_db.create_table :answers do
    primary_key :id
    Integer :question_id
    Integer :lesson_id
    Integer :nikud_id
    String :answer
    Boolean :correct
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
