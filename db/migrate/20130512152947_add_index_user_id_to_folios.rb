class AddIndexUserIdToFolios < ActiveRecord::Migration
  def change
    add_index :folios, :user_id
  end
end
