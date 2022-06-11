#!/usr/bin/env ruby

require 'json'
require 'titleize'

#
# lesson_to_json.rb: Convert a lesson to json.
#

if ARGV.length != 2
  puts "Usage: lesson_to_json.rb <lesson name> <filename>"
  puts "       Save the questions to a single text file called lesson_X.txt"
  puts "       The lesson name will be converted to the lesson title and the output"
  puts "       written to lesson_X.json"
  puts "       Example: ruby lesson_to_json.rb lesson_1 lesson_1.txt"
  exit
end

lesson_name = ARGV.shift
full = {
  "title": lesson_name.gsub(/_+/, " ").titleize,
  "slug": lesson_name,
  "video_intro": "#{lesson_name}/#{lesson_name}_intro.mp4",
  "summary": ""
}
questions = []
filename = ARGV.shift
input = File.read(filename)
parts = input.strip.split(/Question \d+:/i)
i = 1
parts.each do |part|
  next if part == nil or part.strip == ""
  item = {
    "title": "Question #{i}",
    "slug": "question_#{i}"
  }
  question, answers = *part.split(/Answers:\s+/)
  if question.strip =~ /^\((Image.*)\).*/
    desc = $1
    question.gsub!(/^\(Image.*\).*/, "")
    item["figure"] = {
      "description": desc,
      "src": "#{lesson_name}/question_#{i}/figure_1.webp",
      "question": question.strip
    }
  end
  if question.strip =~ /How do you pronounce this word\?/
    question.strip.gsub!(/How do you pronounce this word\?/, "")
    word, desc = *question.strip.split(/\r?\n/)
    item["figure"] = {
      "word": word,
      "meaning": desc,
      "question": "How do you pronounce this word?"
    }
  end
  j = 1
  answers.strip.split(/^\d+\.\s+/).each do |answer|
    next if answer == nil or answer.strip == ""
    correct = false
    if answer =~ /\s*\(correct\)\s*/i
      correct = true
      answer.gsub!(/\s*\(correct\)\s*/i, "")
    end
    item["answers"] = [] unless item.has_key? "answers"
    a = {
      "index": j,
      "answer": answer.strip
    }
    if answer.strip =~ /^\w+$/
      a["sound"] = "#{lesson_name}/question_#{i}/answer_#{j}.m4a"
    end
    a["correct"] = true if correct
    item["answers"].push a
    j += 1
  end
  questions.push item
  i += 1
end
full["questions"] = questions
output = filename.gsub(/\.txt/, ".json")
puts "Found #{i} questions..."
puts "Writing #{output}..."
File.open(output, "w") do |f|
  f.write JSON.pretty_generate(full)
end
puts "Complete"
