class DropCodeLinks < ActiveRecord::Migration
  def change
    drop_table :code_links
  end
end
