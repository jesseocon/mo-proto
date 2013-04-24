class AddHashTagToFolios < ActiveRecord::Migration
  def change
    add_column :folios, :hashtag, :string
  end
end
