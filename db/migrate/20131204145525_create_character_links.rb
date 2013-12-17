class CreateCharacterLinks < ActiveRecord::Migration
  def change
    create_table :character_links do |t|
      t.references :character, null: false
      t.references :song, null: false
      t.timestamps
    end
  end
end
