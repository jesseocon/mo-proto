class AddKeywordToFolios < ActiveRecord::Migration
  def change
    add_column :folios, :keyword, :string
  end
end
