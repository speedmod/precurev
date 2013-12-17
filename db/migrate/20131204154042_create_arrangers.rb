class CreateArrangers < ActiveRecord::Migration
  def change
    create_table :arrangers do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
