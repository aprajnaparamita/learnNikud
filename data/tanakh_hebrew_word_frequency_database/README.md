# Tanakh Word Frequency Database

I needed a database of words in the Tanakh with nikud ordered by count.
This way our nikud education software can use as an example the most
commonly used Hebrew words with a certain nikud/letter combination.
The raw Hebrew text is from Mechon Mamre's Complete Hebrew Bible See:

https://www.mechon-mamre.org/

You can find the completed database in Sqlite3 format in this
repository in the file tanakh_word_frequency.db.

Schema:
```
-- Database of all words and their location in the Tanakh.
CREATE TABLE `words` (
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `word` varchar(255),
  `book_hebrew` varchar(255),
  `chapter_hebrew` varchar(255),
  `verse_hebrew` varchar(255),
  `book_english` varchar(255),
  `chapter_english` varchar(255),
  `verse_english` varchar(255)
);

-- Cache of word counts in the Tanakh
CREATE TABLE `word_counts` (
  `word` varchar(255),
  `count` integer
);
```

# Re-create This Data Set

In accordance with the Mechon Mamre site license this script needs you
to visit the page and download the Torah.

Please visit:
https://www.mechon-mamre.org/dlt.htm

Place it in the directory containing this README and you can run the
following command to prepare the UTF-8 Torah text.

```
cd $THE_DIRECTORY_CONTAINING_THIS_README
bundle
ruby prepare_tanakh.rb
```

This script will exit with a SUCCESS message and a directory called
tanakh_utf8 containing the text of the Tanakh in UTF8. You can ignore
iconv error messages.

Now create the words table in the tanakh_word_frequency.db database
by running.

```
ruby create_database.rb
```

Finally create word_counts table by running.

```
ruby create_database_counts.rb
```
