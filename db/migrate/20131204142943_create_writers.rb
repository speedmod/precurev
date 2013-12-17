class CreateWriters < ActiveRecord::Migration
  def change
    create_table :writers do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
