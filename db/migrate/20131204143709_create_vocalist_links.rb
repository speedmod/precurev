class CreateVocalistLinks < ActiveRecord::Migration
  def change
    create_table :vocalist_links do |t|
      t.references :vocalist, null: false
      t.references :song, null: false
      t.timestamps
    end
  end
end
