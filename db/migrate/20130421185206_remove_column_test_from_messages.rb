class RemoveColumnTestFromMessages < ActiveRecord::Migration
  def up
    remove_column :messages, :test
    remove_column :messages, :params_hash
  end

  def down
    add_column :messages, :test
    add_column :messages, :params_hash
  end
end
