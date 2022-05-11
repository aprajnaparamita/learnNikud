# Writing Each Lesson

Each lesson is written in [LibreOffice](https://www.libreoffice.org/)
Writer in ODT format. The lesson contains scripts for each video segment
questions for practice with descriptions of graphics and exmaples to
be recorded. Find the original lesson [here](./Learn Nikud - Lesson Plans.odt)

These lessons are then converted into a special JSON format that is
loaded into the [Ionic App](https://github.com/hexatridecimal/learnNikud/tree/main/src)

# Lesson Creation Tools

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
CREATE TABLE `letter_nikuds` (
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `letter_id` integer,
  `nikud_id` integer,
  `combined` varchar(255),
  `name` varchar(255),
  `count` integer
);
CREATE TABLE `letters` (
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `letter` varchar(255),
  `name` varchar(255),
  `count` integer
);
CREATE TABLE `nikuds` (
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `english_name` varchar(255),
  `hebrew_name` varchar(255),
  `code_point` varchar(255),
  `sounds` varchar(255),
  `vowel_sound` varchar(255),
  `description` varchar(255),
  `count` integer
);
CREATE TABLE `nikuds_words` (
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `word_id` integer,
  `nikud_id` integer
);
```

# Usage

Using the tables above common words with certain nikud can be queried
from the sources and can be picked for a lesson. For example to get all
words with Segol (id 2 in nikuds table) that may have up to one other
nikud you would query like this.

```
sqlite> select a.*, b.* from words a, nikuds_words b where a.id=b.word_id and b.nikud_id=2 and a.nikuds=2 order by a.count desc limit 10;
2|יְהוָה|4578|2|6|3|2|2
70|כָּל|4320|2|4|108|70|2
1601|אֲבָל|2715|2|5|3072|1601|2
86|הָיָה|2623|2|5|132|86|2
63989|מוּסָף|2161|2|6|156784|63989|2
42|אֶחָד|2095|2|5|65|42|2
66189|מֵידָע|1550|2|6|163044|66189|2
65858|אֲתָר|1455|2|5|162092|65858|2
36|לָהֶם|1209|2|5|54|36|2
1737|הָיוּ|954|2|5|3352|1737|2
````

To get words that only contain a single Cholam/Holam either Cholam Haser
(nikuds id 7) or Cholam Malle (nikuds id 9) you would query.

```
sqlite> select a.*, b.* from words a, nikuds_words b where a.id=b.word_id and b.nikud_id in (7,9) and a.nikuds=1 order by a.count desc limit 10;
7|לֹא|12067|1|3|8|7|7
3013|אוֹ|2711|1|3|6052|3013|7
3013|אוֹ|2711|1|3|6053|3013|9
248|יוֹם|1764|1|4|421|248|7
248|יוֹם|1764|1|4|422|248|9
1102|לוֹ|1348|1|3|2071|1102|7
1102|לוֹ|1348|1|3|2072|1102|9
1388|עוֹד|1312|1|4|2645|1388|7
1388|עוֹד|1312|1|4|2646|1388|9
152|זֹאת|1176|1|4|254|152|7
```

# Generating this Database

First run the script prepare_database.rb. This will combine the tanakh,
siddur and modern usage wores into a single table of words.

Next run count_nikuds.rb to load the word counts of given nikuds into
the nikuds table.

Next run create_nikuds_words.rb create the nikuds_words table.

Now run: ruby create_letters.rb to add the letter_nikuds and letters tables.

build_lesson_plans.rb was originally an attempt to programmatically
select question words and answers. This was scrapped in favor of doing
it manually.

TO BE CONTINUED
