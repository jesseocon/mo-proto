class RemoveLimitFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :limit
  end
end
