#!/usr/bin/env ruby

require 'json'
require 'sequel'

nikuds  = JSON.parse(File.read("nikud.json"))
letters = JSON.parse(File.read("full.json"))
$modern_db = Sequel.connect('sqlite://modern_hebrew_words_containing_a_letter/modern_word_frequency.db')
$tanakh_db = Sequel.connect('sqlite://tanakh_hebrew_word_frequency_database/tanakh_and_sidur_word_frequency.db')

#
# generate_database.rb: Generate a database with every combination.
#

$used_words = {}

def get_next_word(nikud, handle, query, after_word=nil)
  return nil if after_word =~ /^\s*$/
  found_word = 1 if after_word == nil
  #count = 0
  handle[query].each do |r|
    #count += 1
    #puts "Count: #{count}"
    #return nil if count > 330 # If this is true then something has went wrong
    if found_word == 1
      puts "get_next_word(): Returning: #{r[:word].strip}"
      return r[:word].strip
    else
      puts "get_next_word(): Second: #{r[:word].strip}"
      if r[:word].strip == after_word.strip
        found_word = 1
        next
      end
    end
  end
  return nil
end

def get_next(nikud, handle, query)
  found_word = nil
  used_word = nil
  while found_word == nil
    word = get_next_word(nikud, handle, query, used_word)

    return nil if word == nil
    puts "get_next(): Word: \"#{word}\": #{used_word}"
    # Don't include the divine name, it is not pronounced.
    if word == 'יְהוָה' # occurs 4578 times in the sources
      $used_words['יְהוָה'] = true
      used_word = 'יְהוָה'
      next
    elsif $used_words.has_key? word
      puts "Yup has the key: #{word.inspect}"
      used_word = word
      next
    else
      found_word = true # No matter
      $used_words[word] = true
      return word
    end
  end
  return nil
end

def get_word_examples(nikud)
  modern_query = "select * from words where word like '%#{nikud}%' order by count desc, len asc, nikuds asc"
  tanakh_query = "select * from word_counts where word like '%#{nikud}%' order by count desc, len asc, nikuds asc"
  # In the first pass we build the database without uniqueness so it is most complete.
  m1word = get_next_word(nikud, $modern_db, modern_query)
  t1word = get_next_word(nikud, $tanakh_db, tanakh_query)
  # In the second pass we require uniqeuness for every word to increase the variety of words
  # that show up in the final mix.
  m2word = get_next(nikud, $modern_db, modern_query)
  t2word = get_next(nikud, $tanakh_db, tanakh_query)
  examples = []
  # We want more variety so we priorities those chosen with unqieness first
  # Tanakh/Sidur data is added first so words from the Shema can be added here without fear
  # of removing the modern words.
  tword = t2word || t1word
  tword = tword.strip if tword != nil
  mword = m2word || m1word
  mword = mword.strip if mword != nil

  examples.push tword if tword != nil
  examples.push mword if mword != nil
  return examples
end


count = 0
elements = []
missing = []
letters.each_key do |letter|
  nikuds.each_key do |nikud_name|
    l = letters[letter]
    row = {}
    row["letter_english_name"]    = l["english_name"]       # "aleph",
    row["letter_hebrew_name"]     = l["hebrew_name"]        # "אָלֶף",
    row["letter_description"]     = l["english_equivalent"] # "always spoken at the beginning of words with vocal anlaut",
    row["letter_pronunciation"]   = l["pronunciation"]      # "/ʔalɛf/",
    row["letter_english_letter"]  = l["english_letter"]     # "∅",
    row["letter_numerical_value"] = l["numerical_value"].to_i    # 1
    row['english_name']           = "#{row['letter_english_name']} #{nikud_name.downcase}"
    nikuds[nikud_name].each_key do |key|
      row["nikud_#{key}"]=nikuds[nikud_name][key]
    end
    row['nikud_english_name']     = nikud_name.downcase
    row['hebrew_name']            = "#{row['letter_hebrew_name']} #{row['nikud_hebrew_name']}"
    row['combined']               = ''
    row['combined']              += letter
    row['nikud_code_point'].split(/\s+/).each do |cp|
      row['combined'] += [cp.hex].pack("U")
    end

    examples = get_word_examples(row['combined'])
    puts "#{row['combined']}: Examples: #{examples.inspect}"
    if examples.length > 0
      row['examples'] = examples
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
  f.write JSON.pretty_generate(elements)
end
