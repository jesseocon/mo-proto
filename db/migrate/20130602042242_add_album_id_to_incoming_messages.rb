class AddAlbumIdToIncomingMessages < ActiveRecord::Migration
  def change
    add_column :incoming_messages, :album_id, :integer
  end
end
