class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :photo_qty

      t.timestamps
    end
  end
end
