# Learn Nikud

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## About

Welcome to Learn Nikud, my name is Yona Jeffus. I am learning Hebrew and
loving it! But in learning I discovered that there is no easy to use
nikud learning app available free. Let us change that! This project is
an attempt to create an objectively better learning experience. Using
original sources we teach using the most commonly used words in a
gradual and progressive way. Click the image below to view the mockup of
the original design before any coding started.

[![Learn Nikud Pronunciation App](https://raw.githubusercontent.com/hexatridecimal/learnNikud/main/graphics/screen1.png)](https://app.moqups.com/uEk2UmZw30/view/page/ae8fe8eb0 "Learn Nikud Pronunciation App Mockup")

We are using the Ionic framework v5 for the core application with the
[Ionic Native SQLite](https://ionicframework.com/docs/native/sqlite) plugin.

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

# License

Learn Nikud
Copyright (C) 2021 Yona Jeffus

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
   variables, exposed ports, useful file locations and parameters.
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
