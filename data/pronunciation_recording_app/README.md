# Nikud Pronunciation Sound Collection App

This is a simple React app that allows multiple speakers to record all
the sounds for each nikud. A speaker has an ID and we add all
aleph-bet letters with each possible nikud combination from the
alephbet_with_nikud.json created by the data import process described
here:
https://github.com/hexatridecimal/learnNikud/tree/main/data

## Setup and Installation

First do the normal Rails housekeping to bootstrap the app.

```
bundle
bin/rake db:create
bin/rake db:migrate
```

Each speaker will need to have the following command ran for them.
Run the command to import the letters/nikud combinations into
the database.

```
bin/rake letters:import name=Yana --trace
```

You will get the edit URL that can be shared with the speaker.
