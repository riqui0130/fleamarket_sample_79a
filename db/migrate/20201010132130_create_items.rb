class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.string :item_name, null: false, add_index: true
      t.text :description, null: false
      t.integer :price, null: false
      t.string :name, null: false
      t.text :detail, null: false
      t.integer :status_id, null: false
      t.integer :shippingday_id, null: false
      t.integer :postage_id, null: false
      t.integer :prefecture_id, null: false
      t.string :brand
      t.references :category, null: false
      t.timestamps
    end
  end
end
