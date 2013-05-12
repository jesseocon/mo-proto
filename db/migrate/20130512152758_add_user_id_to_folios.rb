class AddUserIdToFolios < ActiveRecord::Migration
  def change
    add_column :folios, :user_id, :integer
  end
end
