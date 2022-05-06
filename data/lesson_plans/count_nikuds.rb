#!/usr/bin/env ruby

require 'sequel'
require 'json'

nikuds = JSON.parse(File.read("../nikud.json"))
tanakh_db = Sequel.connect('sqlite://../tanakh_hebrew_word_frequency_database/tanakh_and_sidur_word_frequency.db')
modern_db = Sequel.connect('sqlite://../modern_hebrew_words_containing_a_letter/modern_word_frequency.db')

def pack_complex(code_point)
  combined = ''
  code_point.split(/\s+/).each do |cp|
    combined += [cp.hex].pack("U")
  end
  return combined
end

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

p counts
