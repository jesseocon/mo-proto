class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :amount
      t.integer :folio_id
      t.integer :user_id

      t.timestamps
    end
    add_index :charges, :folio_id
    add_index :charges, :user_id
  end
end
