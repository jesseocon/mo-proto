class AddIndexToIncomingMessages < ActiveRecord::Migration
  def change
    add_index :incoming_messages, :album_id
  end
end
