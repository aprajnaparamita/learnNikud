#!/usr/bin/env ruby

require 'json'
require 'sequel'
require 'nokogiri'
require 'gematria'

book_names = JSON.parse(File.read("books_hebrew_to_english.json"))

Gematria::Tables.set_table :hebrew
DB = Sequel.connect('sqlite://tanakh_and_sidur_word_frequency.db')

unless DB.table_exists? :words
  DB.create_table :words do
    primary_key :id
    String :word
    String :book_hebrew
    String :chapter_hebrew
    String :verse_hebrew
    String :book_english
    String :chapter_english
    String :verse_english
    String :prayer_name
  end
end

words_table = DB[:words] # Create a dataset

Dir['tanakh_utf8/*.htm'].each do |file|
  title = nil
  nok = Nokogiri::HTML(File.open(file).read.gsub(/<P>|<\/P>|<P CLASS="\w+">/, ''))
  nok.xpath("//title").each do |t|
    title = t.inner_text.strip.split(/ - /).last
  end
  book_hebrew, chapter_hebrew = *title.split(/ פרק /)
  next if chapter_hebrew == nil
  book_english = book_names[book_hebrew]
  alephbet = Gematria::Calculator.new chapter_hebrew
  chapter_english = alephbet.converted
  puts "#{file} Book: #{book_hebrew} - #{book_english} Chapter: #{chapter_hebrew} - #{chapter_english}" #: File: #{file}"
  nok.xpath("//b").each do |b|
    verse_english = b.previous_element.attr('name')
    verse_hebrew = b.inner_text.strip
    verse_text = b.next_sibling.inner_text.strip.gsub(/[-.,;:()"'\]\[]+|{[^}]+}/, ' ').gsub("\u00A0", "").strip
    words = verse_text.split(/\s+/)
    words.each do |word|
      words_table.insert(:word => word,
                   :book_hebrew => book_hebrew.to_s,
                   :book_english => book_english.to_s,
                   :chapter_hebrew => chapter_hebrew.to_s,
                   :chapter_english => chapter_english.to_s,
                   :verse_hebrew => verse_hebrew.to_s,
                   :verse_english => verse_english.to_s)
    end
  end
end
puts "SUCCESS! Now import the sidur with 'ruby import_sidur.rb' or create the counts for the tanakh alone with: create_database_counts.rb see README.md"
