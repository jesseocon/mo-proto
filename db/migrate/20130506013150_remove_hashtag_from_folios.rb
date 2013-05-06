class RemoveHashtagFromFolios < ActiveRecord::Migration
  def change
    remove_column :folios, :hashtag
  end
end
