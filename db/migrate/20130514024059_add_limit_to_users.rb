class AddLimitToUsers < ActiveRecord::Migration
  def change
    add_column :users, :limit, :integer
  end
end
