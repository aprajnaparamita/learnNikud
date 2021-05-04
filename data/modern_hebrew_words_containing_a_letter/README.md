# Modern Hebrew Nikud Database

This database is based on THE WORD-FREQUENCY DATABASE FOR PRINTED HEBREW
published by Hebrew University here:
http://word-freq.mscc.huji.ac.il/

From the site: The corpus was assembled throughout the year 2001, and consists of text downloaded from 914 editions of the three major daily online Hebrew newspapers (Haaretz, Maariv, and Yediot Acharonot). After removing abbreviations, single characters, forms with counts that are less than 3 (mostly typos), and splitting hyphenated forms (vast majority were two words), the corpus totals 554,270 types and 619,835,788 tokens. The WORD-FREQUENCY DATABASE supplies the frequency of occurrence of any Hebrew letter cluster (mean occurrence per million).

# Generating this Database

First run the script grab_words_by_frequency.rb. This will grab the top
500 results for a letter in the aleph-bet.

Next run prepare_database.rb to load the data from the pages into the
database.
