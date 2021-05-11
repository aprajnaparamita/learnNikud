#!/usr/bin/env ruby

require 'nokogiri'
require 'sequel'

#
# prepare_database.rb: Load words from fequency results.
#
DB = Sequel.connect('sqlite://modern_word_frequency.db')

unless DB.table_exists? :words
  DB.create_table :words do
    String :word
    String :word_bare
    Integer :count
    Integer :nikuds
    Integer :len
  end
end

words_table = DB[:words] # Create a dataset

Dir['pages/*.html'].each do |file|
  puts "Opening #{file}..."
  nok = Nokogiri::HTML( File.read(file) )
  nok.xpath('//table/tbody/tr').each do |tr|
    word = nil
    count = nil
    tr.xpath('.//td').each do |td|
      if word == nil
        word = td.inner_text.strip
      elsif count == nil
        count = td.inner_text.strip
      end
    end
    unless words_table.where(:word_bare => word).count > 0
      words_table.insert(:word_bare => word,
                         :word => nil,
                         :count => count)
    else
      puts "Word exists: #{word}"
    end
    puts [word,count].join("\t")
  end
end

puts "SUCCESS! Now load the nikud for the words using get_database_nikud.rb: See README.md"
