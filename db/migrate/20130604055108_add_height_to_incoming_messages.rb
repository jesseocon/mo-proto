class AddHeightToIncomingMessages < ActiveRecord::Migration
  def change
    add_column :incoming_messages, :width, :integer
    add_column :incoming_messages, :height, :integer
  end
end
