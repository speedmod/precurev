class CreateKanaLinks < ActiveRecord::Migration
  def change
    create_table :kana_links do |t|
      t.references :kana, null: false
      t.references :song, null: false
      t.timestamps
    end
  end
end
