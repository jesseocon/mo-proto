class CreateFolios < ActiveRecord::Migration
  def change
    create_table :folios do |t|
      t.string :name

      t.timestamps
    end
  end
end
