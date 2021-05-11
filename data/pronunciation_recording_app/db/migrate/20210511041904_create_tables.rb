class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :sounds do |t|
      t.integer :speaker_id
      t.string :character
      t.boolean :completed
      t.string :filename
      t.string :english_name
      t.string :hebrew_name
      t.string :letter_english_name # "tav",
      t.string :letter_hebrew_name  #  "תָו",
      t.string :letter_description  # "t as in tool or th as in thought",
      t.string :letter_pronunciation # "/tav/",
      t.string :letter_english_letter # "th",
      t.string :letter_numerical_value # 400,
      t.string :nikud_hebrew_name  # "קֻבּוּץ",
      t.string :nikud_code_point # "05BB",
      t.string :nikud_sounds # 1,
      t.string :nikud_vowel_sound # "oo",
      t.string :nikud_description #  "Makes a shorter 'oo' sound like in 'book' and appears like three dots, arrange>
      t.string :nikud_english_name #  "kubutz",
      t.string :examples
      t.text :notes
      t.timestamps
    end
    add_index :sounds, :completed
    add_index :sounds, :speaker_id
    create_table :speakers do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end
    add_index :speakers, :slug
  end
end
