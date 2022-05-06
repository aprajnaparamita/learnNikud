# Create Lesson Plans

We need to generate lesson plans that reveal the nikud in order of
commonness and using the most common words. An example word for a given
nikud must not contain future nikuds, only already known ones. To
accomplish this we build the lesson plans gradually based on several
tables generated using the scripts in this directory.

```
CREATE TABLE `words` (
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `word` varchar(255),
  `count` integer,
  `nikuds` integer,
  `len` integer
);
CREATE TABLE `nikuds` (
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `english_name` varchar(255),
  `hebrew_name` varchar(255),
  `code_point` varchar(255),
  `sounds` varchar(255),
  `vowel_sound` varchar(255),
  `description` varchar(255),
  `count` integer -- Number of words with this nikud
);
CREATE TABLE `nikuds_words` (
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `word_id` integer,
  `nikud_id` integer
);
```

# Generating this Database

First run the script prepare_database.rb. This will combine the tanakh,
siddur and modern usage wores into a single table of words.

Next run count_nikuds.rb to load the word counts of given nikuds into
the nikuds table.

Next run create_nikuds_words.rb create the nikuds_words table.

TO BE CONTINUED
