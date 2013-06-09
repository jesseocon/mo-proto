class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.integer :user_id
      t.integer :incoming_message_id

      t.timestamps
    end
    add_index :stars, :user_id
    add_index :stars, :incoming_message_id
    add_index :stars, [:user_id, :incoming_message_id], unique: true
  end
end
