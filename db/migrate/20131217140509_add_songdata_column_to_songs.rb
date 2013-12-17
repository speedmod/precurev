class AddSongdataColumnToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :songdata, :text, after: :series_id
  end
end
