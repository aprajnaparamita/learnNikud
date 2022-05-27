#!/usr/bin/env ruby

require 'translit_kit'
require 'hebrewword'

# build_questions.rb: Take an input.txt file with hebrew words and descriptions.
# 
buf = File.read "input.txt"
questions = buf.strip.split(/\r?\n\r?\n/)
i = 5
questions.each do |question|
  word, desc = *question.split(/\n/)
  STDERR.puts "Got: #{word}: #{desc}"
  word = word.unicode_normalize(:nfd) #.gsub(/[\u0591-\u05c7]/,"")
  heb = HebrewWord.new word
  suggestions = heb.transliterate(:short)
  puts <<EOT;
Question #{i}:
#{word}
#{desc}
How do you pronounce this word?

Answers:
EOT
  j = 1
  entry = suggestions.first
  while j < 5
    entry = suggestions.pop if suggestions.length > 0
    puts "#{j}. #{entry}"
    j += 1
  end
  puts "\n"
  i += 1
end
