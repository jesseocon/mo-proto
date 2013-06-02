class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :album_handle
      t.integer :user_id

      t.timestamps
    end
    add_index :albums, :name
    add_index :albums, :album_handle
    add_index :albums, :user_id
  end
end
