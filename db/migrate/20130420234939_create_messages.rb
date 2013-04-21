class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :test

      t.timestamps
    end
  end
end
