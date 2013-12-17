class CreateComposers < ActiveRecord::Migration
  def change
    create_table :composers do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
