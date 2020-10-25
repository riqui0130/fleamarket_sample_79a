class CreatePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures do |t|
      t.integer :item_id, null: false, foreign_key: true
      t.string :picture_url, null: false
      t.timestamps
    end
  end
end
