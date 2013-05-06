class AddPackageIdToFolios < ActiveRecord::Migration
  def change
    add_column :folios, :package_id, :integer
  end 
end
