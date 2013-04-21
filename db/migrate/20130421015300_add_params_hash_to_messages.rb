class AddParamsHashToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :params_hash, :text
  end
end
