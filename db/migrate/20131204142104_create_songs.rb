class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name, null: false
      t.integer :year
      t.references :series
      t.timestamps
    end
  end
end
