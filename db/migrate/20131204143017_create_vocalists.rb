class CreateVocalists < ActiveRecord::Migration
  def change
    create_table :vocalists do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
