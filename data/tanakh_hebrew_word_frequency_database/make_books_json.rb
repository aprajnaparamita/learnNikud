require 'sequel'
require 'json'

# NOTE: This script was used to create books_hebrew_to_english.json
# By creating the word frequency database using create_database.rb
# with all the book_english columns set to NULL. Then I manually
# entered the English name to correspond with the Hebrew in the
# book_hebrew column. Now this books_hebrew_to_english.json
# is being used to populate the book_english field for the
# tanakh_word_frequency.db words table.

DB = Sequel.connect('sqlite://tanakh_word_frequency.db')
books = {}
DB['select distinct(book_hebrew) from words order by book_hebrew'].each do |row|
  books[row[:book_hebrew]] = ''
end
File.open("books_hebrew_to_english.json", "w") do |f|
  f.write books.to_json
end
