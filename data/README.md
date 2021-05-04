# Hebrew Aleph-bet with Nikud

I needed a database of common Hebrew words with nikud ordered by count.
This way our nikud education software can use valid examples. Two
different sources were looked at. The first was the Word Frequency
Database for Printed Hebrew hosted by Hebrew University.

http://word-freq.mscc.huji.ac.il/

Generated from text downloaded from 914 editions of the three major
daily online Hebrew newspapers this corpus represents modern Hebrew
usage. You can find the guide to collecting these words here:

https://github.com/hexatridecimal/learnNikud/tree/main/data/modern_hebrew_words_containing_a_letter

The other principal source for reading Hebrew and nikud is the tanakh.
The processing for Mechon Mamre's Complete Hebrew Bible is simple
and is here:

https://github.com/hexatridecimal/learnNikud/tree/main/data/tanakh_hebrew_word_frequency_database

These word summaries are combined using the script generate_database.rb.
This yields alephbet_with_nikud.json.
