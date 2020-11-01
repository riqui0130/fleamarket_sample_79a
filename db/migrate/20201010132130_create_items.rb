class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :price, null: false
      t.string :name, null: false
      t.text :detail, null: false
      t.integer :condition_id, null: false
      t.integer :delivery_days_id, null: false
      t.integer :deliverycost_id, null: false
      t.integer :prefecture_id, null: false
      t.string :brand
      t.references :category, null: false
      t.references :seller, foreign_key: {to_table: :users} 
      t.references :buyer, foreign_key: {to_table: :users}
      t.references :auction, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
