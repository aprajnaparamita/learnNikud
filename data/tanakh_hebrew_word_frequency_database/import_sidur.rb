#!/usr/bin/env ruby

require 'json'
require 'sequel'
require 'nokogiri'
require 'gematria'

DB = Sequel.connect('sqlite://tanakh_and_sidur_word_frequency.db')

$words_table = DB[:words] # Create a dataset

sidur = JSON.parse(File.read("Siddur Ashkenaz - he - merged.json"))

def add_string(str, title)
  if str.is_a? String
    if str =~ /[\u0590-\u05F4]/
      nok = Nokogiri::HTML(str)
      verse_text = nok.inner_text.strip.gsub(/[-.,;:()"'0-9\[\]]+|{[^}]+}/,     ' ').gsub("\u00A0", "").strip
      words = verse_text.split(/\s+/)
      puts "#{title}: #{verse_text}"
      words.each do |word|
        $words_table.insert(:word => word, :prayer_name => title)
      end
    end
  else
    puts "Something else: #{title}: #{str}: #{str.inspect}"
    exit
  end
end

def process_array(arr, title)
  arr.each do |str|
    add_string(str, title)
  end
end

def descend(hash, title)
  title = '' if title =~ /^\s*text\s*$/
  hash.each_key do |key|
    next if key == "schema"
    next if key == "versions"
    new_title = "#{title} #{key}"
    if hash[key].is_a? Array
      process_array(hash[key], new_title)
    elsif hash[key].is_a? Hash
      descend(hash[key], new_title)
    elsif hash[key].is_a? String
      add_string(hash[key], new_title)
    else
      puts "Encountered something else: #{hash[key].inspect}"
      exit
    end
  end
end

descend(sidur, "")
puts "SUCCESS! Now create the counts with: create_database_counts.rb see README.md"
