class AddAbbrColumnToSeries < ActiveRecord::Migration
  def change
    add_column :series, :abbreviation, :string, after: :name
  end
end
