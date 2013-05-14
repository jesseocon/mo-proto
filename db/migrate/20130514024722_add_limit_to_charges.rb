class AddLimitToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :limit, :integer
  end
end
