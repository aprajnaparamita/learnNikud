#!/usr/bin/env ruby

require 'json'
require 'watir-webdriver'

browser = Watir::Browser.new

letters = JSON.parse(File.open("letters.json").read)
letters.each_key do |letter|
  file = "pages/#{letters[letter]}.html"
  next if File.exists? file
  puts "Saving '#{letter}' as #{file}"
  browser.goto 'http://word-freq.mscc.huji.ac.il/wordfreq.asp'
  browser.text_field(name: 'search').value = letter
  browser.button(name: 'submit1').click
  sleep 2
  File.open(file, 'w') do |f|
    f.write browser.html
  end
end
