class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :album_id
      t.string :user_email

      t.timestamps
    end
    add_index :invitations, [:album_id, :user_email], unique: true
    
  end
end
