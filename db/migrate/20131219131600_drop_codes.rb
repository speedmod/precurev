class DropCodes < ActiveRecord::Migration
  def change
    drop_table :codes
  end
end
