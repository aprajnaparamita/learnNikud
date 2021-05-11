require 'json'
require 'securerandom'

# "english_name": "aleph qamats",
# "hebrew_name": "קָמֶץ",
# "english_equivalent": "always spoken at the beginning of words with vocal anlaut",
# "pronunciation": "/ʔalɛf/",
# "english_letter": "∅",
# "numerical_value": "1",
# "nikud": "Qamats",
# "code_point": "05B8",
# "sounds": 1,
# "vowel_sound": "u",
# "description": "Looks like a 'T' and can be found under the letter, makes a short 'u' sound (as in sun)",
# "combined": "אָ",
# "examples": [
#    "תִפְאָרָה",
#    "הָאָרֶץ"
# ]
#

namespace :letters do
  task :import => :environment do
    unless ENV.has_key? "name"
      puts "Error: Please provide a speaker name."
      puts "Usage: rake letters:import name=Yana"
      exit
    end
    nikuds = JSON.parse(File.read(Rails.root.join("..", "alephbet_with_nikud.json")))
    speaker = Speaker.create do |s|
      s.name = ENV['name']
      s.slug = SecureRandom.hex(10)
    end
    nikuds.each do |nikud|
      s = Sound.new
      s.speaker_id = speaker.id
      nikud.each_key do |key|
        next if key == 'combined'
        next if key == 'examples'
        s.send("#{key}=".to_s, nikud[key])
      end
      s.character = nikud['combined']
      s.examples  = nikud['examples'].join(" ")
      s.filename  = "sounds/#{nikud['english_name'].gsub(/\s+/, '_')}.mp3"
      s.save
      p s
    end
    puts "SUCCESS! Created a Speaker with the name #{speaker.name}"
    puts "URL: /letters/##{speaker.slug}"
  end
end
