require 'sequel'
require 'json'
DB = Sequel.connect('sqlite://tanakh_word_frequency.db')
books = {}
DB['select distinct(book_hebrew) from words order by book_hebrew'].each do |row|
  books[row[:book_hebrew]] = ''
end
File.open("books_hebrew_to_english.json", "w") do |f|
  f.write books.to_json
end
