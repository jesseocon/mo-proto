class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :auth_token
      t.string :password_reset_token
      t.datetime :password_reset_at
      t.string :verification_token
      t.boolean :verified
      t.boolean :admin

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :verification_token
  end
end
