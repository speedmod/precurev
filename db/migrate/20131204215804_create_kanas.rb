class CreateKanas < ActiveRecord::Migration
  def change
    create_table :kanas do |t|
      t.string :kana
      t.timestamps
    end
  end
end
