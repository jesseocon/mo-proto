class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :img_url
      t.string :img_data
      t.string :pic_content_type
      t.string :pic_file_name 
      t.integer :pic_file_size
      t.datetime :pic_updated_at

      t.timestamps
    end
  end
end

