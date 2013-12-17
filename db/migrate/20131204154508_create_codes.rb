class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :number
      t.string :maker
      t.timestamps
    end
  end
end
