#character = ''
# @sound.code_point.split(/\s+/).each do |c|
#  character += [c.hex].pack("U")
#end

total = Sound.where(:speaker_id => @sound.speaker_id).count
json.sound do
  json.id @sound.id
  json.character  @sound.character
  json.completed @sound.completed
  json.filename @sound.filename
  json.english_name @sound.english_name
  json.hebrew_name @sound.hebrew_name
  json.letter_english_name @sound.letter_english_name
  json.letter_hebrew_name @sound.letter_hebrew_name
  json.letter_description @sound.letter_description
  json.letter_pronunciation @sound.letter_pronunciation
  json.letter_english_letter @sound.letter_english_letter
  json.letter_numerical_value @sound.letter_numerical_value
  json.nikud_english_name @sound.nikud_english_name
  json.nikud_hebrew_name @sound.nikud_hebrew_name
  json.nikud_code_point @sound.nikud_code_point
  json.nikud_sounds @sound.nikud_sounds
  json.nikud_vowel_sound @sound.nikud_vowel_sound
  json.nikud_description @sound.nikud_description
  json.examples @sound.examples
  json.speaker_id @sound.speaker_id
  json.speaker_name @sound.speaker.name
  json.total total
  json.current (total - @sounds.count)+1
end
