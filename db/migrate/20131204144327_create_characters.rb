class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.references :series
      t.string :prettycure_name
      t.timestamps
    end
  end
end
