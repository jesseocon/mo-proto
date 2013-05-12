class AddPackageIdToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :package_id, :integer
  end
end
