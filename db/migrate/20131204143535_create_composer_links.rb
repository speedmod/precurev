class CreateComposerLinks < ActiveRecord::Migration
  def change
    create_table :composer_links do |t|
      t.references :composer, null: false
      t.references :song, null: false
      t.timestamps
    end
  end
end
