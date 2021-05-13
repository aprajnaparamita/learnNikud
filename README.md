# Learn Nikud

Welcome to Learn Nikud, my name is Yana Jeffus. I am learning Hebrew and
loving it! But in learning I discovered that there is no easy to use
nikud learning app available free. Let us change that! This project is
an attempt to create an objectively better learning experience. Using
original sources we teach using the most commonly used words in a
gradual and progressive way. Here is a mockup of the original design
before any coding started.

[![Learn Nikud Pronunciation App](https://raw.githubusercontent.com/hexatridecimal/learnNikud/main/graphics/screen1.png | width=300)](https://app.moqups.com/uEk2UmZw30/view/page/ae8fe8eb0 "Learn Nikud Pronunciation App Mockup")

The first task of this project was to find all the letter and nikud
combinations and examples from their usage. This stage was completed by
the code found in the data directory.

https://github.com/hexatridecimal/learnNikud/tree/main/data

The second stage was to provide recordings of a native Hebrew speaker
saying the Hebrew nikud and words. This is completed by the Learn Nikud
Pronunciation Recording App available here:

https://github.com/hexatridecimal/learnNikud/tree/main/data/pronunciation_recording_app

See the recording guide:
[![Nikud Pronunciation Sound Collection App](http://img.youtube.com/vi/z1mszMaORAI/0.jpg)](http://www.youtube.com/watch?v=z1mszMaORAI "Nikud Pronunciation Sound Collection App")

The third stage (in progress) is to solve for a lesson plan that will
gradually reveal nikud in order of commomness. So as each nikud is
revealed the examples will only contain nikud already known. This way
the software can query for examples the student already knows. We will
do this two nikud per-unit, with only one nikud in the final seventh
lesson/unit.

The fourth stage is writing the practice mode. The lessons will go in
order of commonness. The nikud sounds for both nikud will be presented
at the beginning of the lesson. Then 30 examples will be picked, 15 for
each nikud. The test mode will be in effect since a star rating will be
given based on the success percentage in the lesson. 70%+ will be 1
star, 80%+ is two star, 90%+ is 3 stars. When a practice for a unit has
3 stars the test mode unlocks for that unit.

The fifth and final stage is writing the test mode. This will be very
nearly the same code as the practice code. The difference is that the
letter sounds are not presented at the beginning of a unit. And each
question will be the letter/nikud with english letter/nikud buttons on
each answer.
