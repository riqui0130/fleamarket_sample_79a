class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.integer :item_id, foreign_key: true, null: false
      t.string :image_url, null: false
      t.timestamps
    end
  end
end