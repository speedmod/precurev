class AddSongIdColumnToKanas < ActiveRecord::Migration
  def change
    add_column :kanas, :song_id, :integer, after: :kana
  end
end
