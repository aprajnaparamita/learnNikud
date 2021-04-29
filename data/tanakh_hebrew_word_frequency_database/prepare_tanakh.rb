#!/usr/bin/env ruby
require 'fileutils'

# Check for dependencies
if `which iconv` =~ /not found/i
  puts "Error: iconv is not installed\n"
  puts "Install it with:"
  if RUBY_PLATFORM =~ /mac/i
    puts "brew install plan9port\n"
  else
    puts "apt-get install libc-bin\n"
  end
  puts "Then run this script again."
  exit
end

if `which unzip` =~ /not found/i
  puts "Error: unzip is not installed\n"
  puts "Install it with:"
  if RUBY_PLATFORM =~ /mac/i
    puts "brew install unzip\n"
  else
    puts "apt-get install unzip\n"
  end
  puts "Then run this script again."
  exit
end

unless File.exists? 't002.zip'
  puts <<"END"
  Error: Torah zip file not found!

  In accordance with the Mechon Mamre site license this script needs you to visit the page and download the Torah.
  Please visit:
  https://www.mechon-mamre.org/dlt.htm

  Once the file t002.zip has downloaded please move it to this directory:
  #{Dir.pwd}

  Run this script again when it is in place.
END
  exit
end

unless File.exists? 't'
  system "unzip 't002.zip'"
  FileUtils.rm 'readme.txt' if File.exists? 'readme.txt'
end
FileUtils.mkdir 'tanakh_utf8' unless File.exists? 'tanakh_utf8'
Dir['t/*.htm'].each do |file|
  filename = file.split("/").last
  puts "Processing: #{file} -> tanakh_utf8/#{filename}"
  system "iconv -f WINDOWS-1255 -t UTF-8 #{file} > tanakh_utf8/#{filename}"
end
FileUtils.rm_rf 't'

puts "SUCCESS! You can now run the other database preparation scripts. See README.md"
