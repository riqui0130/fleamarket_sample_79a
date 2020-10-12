class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :detail, null: false
      t.integer :price, null: false
      t.integer :condition_id, null: false
      t.integer :delivery_days_id, null: false
      t.integer :deliverycost_id, null: false
      t.integer :prefecture_id, null: false
      t.string :brand
      t.references :category, null: false
      t.timestamps
    end
  end
end
