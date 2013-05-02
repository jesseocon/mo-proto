class RemoveColumnFNameFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :f_name
    remove_column :users, :l_name
  end

  def down
    add_column :users, :f_name
    add_column :users, :l_name
  end
end
