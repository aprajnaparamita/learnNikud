# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_11_041904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sounds", force: :cascade do |t|
    t.integer "speaker_id"
    t.string "character"
    t.boolean "completed"
    t.string "filename"
    t.string "english_name"
    t.string "hebrew_name"
    t.string "letter_english_name"
    t.string "letter_hebrew_name"
    t.string "letter_description"
    t.string "letter_pronunciation"
    t.string "letter_english_letter"
    t.string "letter_numerical_value"
    t.string "nikud_hebrew_name"
    t.string "nikud_code_point"
    t.string "nikud_sounds"
    t.string "nikud_vowel_sound"
    t.string "nikud_description"
    t.string "nikud_english_name"
    t.string "examples"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["completed"], name: "index_sounds_on_completed"
    t.index ["speaker_id"], name: "index_sounds_on_speaker_id"
  end

  create_table "speakers", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_speakers_on_slug"
  end

end
