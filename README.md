# Learn Nikud

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## About

```
 גֹּ֣ל אֶל־יְהוָ֣ה מַעֲשֶֹ֑יךָ וְ֜יִכֹּ֗נוּ מַחְשְׁבֹתֶֽיךָ
 Commit your affairs to the Lord, and your plans will be established.
 - Mishlei 16:3
```

B''H

Over 1 year in development! 🎉

Welcome to Learn Nikud, my name is Yona Jeffus. I have been a software
engineer specializing in educational software [for over 20
years](https://www.linkedin.com/in/janet-jeffus-b0709720/). I
was learning Hebrew and realized there is no nikud learning app
available free. With G-d's help we can change that! This project is
an attempt to create the best app anywhere on the market. Using
original sources we teach using the most commonly used words in a
gradual and progressive way. Everywhere we use repetition, mnemonic
devices and entertaining videos to help allow people of all ages
to quickly and easily learn nikud and some basic vocabulary.

I'm not a native Hebrew speaker so this project is my way of
using [the Feynman Tecnique](https://fs.blog/feynman-technique/)
to learn the material myself.

# Development Stages

## Initial Planning

```
  מַחְשְׁב֣וֹת חָ֖רוּץ אַךְ־לְמוֹתָ֑ר וְכָל־אָ֜֗ץ אַךְ־לְמַחְסֽוֹר
  The plans of a diligent man lead only to advantage, whereas every hasty
    one hurries only to want.
  - Mishle 21:5
```

The first thing we do is examine which features are needed, make
app mockups and think about the best way to present the material.
Click the image below to view the mockup of the original design.

[![Learn Nikud Pronunciation App](https://raw.githubusercontent.com/hexatridecimal/learnNikud/main/graphics/screen1.png)](https://app.moqups.com/uEk2UmZw30/view/page/ae8fe8eb0 "Learn Nikud Pronunciation App Mockup")

Since this intial design requirements have been updated and the final
version will be slightly more complex. With vocabulary, practice and
a more complex test system. Internationalization will be considered
during the design process although English is the first target language.

Sephardic or common Israeli pronouciation was decided on since it allows
both for Torah study and modern Hebrew usage. I would like to include a
system similar to some ad supported apps that advertises important
rabbis and programs users may find edifying. These would not be
for-profit but would rather be to spread awareness about them.

## Technological Considerations

Several different languages and frameworks were considered for
development. With the decision to go with Ionic framework v5 for the
core application with the [Ionic Native SQLite](https://ionicframework.com/docs/native/sqlite) plugin
for storing student progress and scores. As well as the [Ionic Native
Video](https://ionicframework.com/docs/native/video-player) player
plugin for playing videos. Lesson plans, practice questions and
tests are stored in JSON format. [DaVinci
Resolve](https://www.blackmagicdesign.com/products/davinciresolve) is
being used to make the videos for each lesson.

In order to teach the most common words I needed a way to objectively
select the best examples for the lessons. Hebrew University's word
frequency database was used along with the Tanakh and Siddur. You
can read more about this process here:

https://github.com/hexatridecimal/learnNikud/tree/main/data

## Writing Lesson Plans (Current Stage)

With the statistical data for word and nikud usage in hand I began
writing the [lesson
plans](https://github.com/hexatridecimal/learnNikud/tree/main/data/lesson_plans).
. These are written in [LibreOffice](https://www.libreoffice.org/)
Writer.

## Review by Native Speakers

```
  הָפֵ֣ר מַ֖חֲשָׁבוֹת בְּאֵ֣ין ס֑וֹד וּבְרֹ֖ב יוֹעֲצִ֣ים תָּקֽוּם
  Plans are foiled for lack of counsel, but they are established through
    many advisers.
  - Mishle 15:22
```

In this stage the lesson plans will be submitted to native speakers to
ensure the material is effecticely teaching a student the correct way.
In order to make the pronunciation recordings quickly and easily
I created the Learn Nikud Pronunciation Recording App available here:

https://github.com/hexatridecimal/learnNikud/tree/main/data/pronunciation_recording_app

See the recording guide:

[![Nikud Pronunciation Sound Collection App](http://img.youtube.com/vi/z1mszMaORAI/0.jpg)](http://www.youtube.com/watch?v=z1mszMaORAI "Nikud Pronunciation Sound Collection App")

This way native speakers can critique the lesson plans, edit them
and provide native recordings of pronunciations.

##  Video Editing and Production

Each lesson for each video will be edited and put together in DaVinci
Resolve and rendered to 1080x1920 mobile video format. Recording files
made by the recording app will be used where necessary.

## App Development

The basic framework of the Ionic App is complete but the next stage will
be to convert the lesson plans to JSON and have the app "play" each
lesson. This will include scoring the practice and tests of each lesson
and unit.

## Beta Testing and Launch

A version will be released to the Apple App Store and Google Play for
iOS and Android respectively. Initial user feedback and iteration will
be agressively pursued to create a polished and final product.

# How Can I Help?

Every level of help is needed! We need native speakers to critique the
content, animators to create the videos, beta testers to try it out, and
app developers to help with code. This is an open source project! You
can start anytime and send in pull requests. Please see the section on
contribution below.

# License

Learn Nikud
Copyright (C) 2022 Janet (Yona) Jeffus

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Contributing

When contributing to this repository, describe your work thoroughly in
your pull request. Contact and collaboration are welcome. Pleae contact
Yona with any questions at: jjeffus@gmail.com

Please note we have a code of conduct, please follow it in all your interactions with the project.

## Pull Request Process

1. Ensure any install or build dependencies are removed before the end of the layer when doing a
   build.
2. Update the README.md with details of changes to the interface, this includes new environment
   variables, useful file locations and parameters.
3. Make your request, it will be reviewed as quickly as possible.

## Code of Conduct

### Our Pledge

In the interest of fostering an open and welcoming environment, we as
contributors and maintainers pledge to making participation in our project and
our community a harassment-free experience for everyone, regardless of age, body
size, disability, ethnicity, gender identity and expression, level of experience,
nationality, personal appearance, race, religion, or sexual identity and
orientation.

### Our Standards

Examples of behavior that contributes to creating a positive environment
include:

* Using welcoming and inclusive language
* Being respectful of differing viewpoints and experiences
* Gracefully accepting constructive criticism
* Focusing on what is best for the community
* Showing empathy towards other community members

Examples of unacceptable behavior by participants include:

* The use of sexualized language or imagery and unwelcome sexual attention or
advances
* Trolling, insulting/derogatory comments, and personal or political attacks
* Public or private harassment
* Publishing others' private information, such as a physical or electronic
  address, without explicit permission
* Other conduct which could reasonably be considered inappropriate in a
  professional setting

### Our Responsibilities

Project maintainers are responsible for clarifying the standards of acceptable
behavior and are expected to take appropriate and fair corrective action in
response to any instances of unacceptable behavior.

Project maintainers have the right and responsibility to remove, edit, or
reject comments, commits, code, wiki edits, issues, and other contributions
that are not aligned to this Code of Conduct, or to ban temporarily or
permanently any contributor for other behaviors that they deem inappropriate,
threatening, offensive, or harmful.

### Scope

This Code of Conduct applies both within project spaces and in public spaces
when an individual is representing the project or its community. Examples of
representing a project or community include using an official project e-mail
address, posting via an official social media account, or acting as an appointed
representative at an online or offline event. Representation of a project may be
further defined and clarified by project maintainers.

### Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be
reported by contacting the project team at jjeffus@gmail.com. All
complaints will be reviewed and investigated and will result in a response that
is deemed necessary and appropriate to the circumstances. The project team is
obligated to maintain confidentiality with regard to the reporter of an incident.
Further details of specific enforcement policies may be posted separately.

Project maintainers who do not follow or enforce the Code of Conduct in good
faith may face temporary or permanent repercussions as determined by other
members of the project's leadership.

### Attribution

This Code of Conduct is adapted from the [Contributor Covenant][homepage], version 1.4,
available at [http://contributor-covenant.org/version/1/4][version]

[homepage]: http://contributor-covenant.org
[version]: http://contributor-covenant.org/version/1/4/
