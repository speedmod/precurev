class CreateCodeLinks < ActiveRecord::Migration
  def change
    create_table :code_links do |t|
      t.references :code, null: false
      t.references :song, null: false
      t.timestamps
    end
  end
end
