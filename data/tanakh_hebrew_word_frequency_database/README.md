# Tanakh Word Frequency Database

I needed a database of words in the Tanakh and Sidur with nikud ordered
by count. This way our nikud education software can teach the most
commonly used Hebrew words with a certain nikud/letter combination.
The raw Hebrew text is from Mechon Mamre's Complete Hebrew Bible See:

https://www.mechon-mamre.org/

The Ashkenazi Sidur is from Sefaria's JSON of the Sidur provided here:
https://www.sefaria.org/Siddur_Ashkenaz?lang=he

You can find the completed database in Sqlite3 format in this
repository in the file tanakh_and_sidur_word_frequency.db. The table
"words" is populated with 72,489 words from the Sidur and 251,436 from
the Tanakh. 63,670 total unique words from both sources are in the
"word_counts" table. Here is the schema.

Schema:
```
CREATE TABLE `words` (
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `word` varchar(255),
  `book_hebrew` varchar(255),
  `chapter_hebrew` varchar(255),
  `verse_hebrew` varchar(255),
  `book_english` varchar(255),
  `chapter_english` varchar(255),
  `verse_english` varchar(255),
  `prayer_name` varchar(255)
);
CREATE TABLE `word_counts` (
  `word` varchar(255),
  `count` integer
);
```

# To Re-create This Data Set

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

Now create the words table in the tanakh_and_sidur_word_frequency.db 
database by running.

```
ruby create_database.rb
```

If you desire to add the contents of the Ashkenazi sidur to the word
count database then run.

```
ruby import_sidur.rb
```

Finally create word_counts table by running.

```
ruby create_database_counts.rb
```

This results in a hebrew word database with every word in the Tanakh and
the Ashkenazi sidur.
