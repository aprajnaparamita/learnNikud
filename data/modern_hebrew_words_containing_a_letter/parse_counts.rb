#!/usr/bin/env ruby

require 'nokogiri'

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
    #word = tr.children.select(&:element?)[0].inner_text
    #count = tr.children.select(&:element?)[1].inner_text
    puts [word,count].join("\t")
  end
end
