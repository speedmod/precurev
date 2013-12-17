class CreateArrangerLinks < ActiveRecord::Migration
  def change
    create_table :arranger_links do |t|
      t.references :song, null: false
      t.references :arranger, null: false
      t.timestamps
    end
  end
end
