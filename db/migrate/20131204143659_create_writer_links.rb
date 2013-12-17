class CreateWriterLinks < ActiveRecord::Migration
  def change
    create_table :writer_links do |t|
      t.references :writer, null: false
      t.references :song, null: false
      t.timestamps
    end
  end
end
