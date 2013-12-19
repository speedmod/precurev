class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.references :song, null: false
      t.string :maker
      t.string :machine
      t.boolean :movie, default: false
      t.string :code, null: false
      t.string :memo
    end
  end
end
