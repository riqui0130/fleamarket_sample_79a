class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|
      t.references :user, index: true, foreign_key: true
      t.string :family_name, null: false
      t.string :first_name,  null: false
      t.string :post_code,   null: false
      t.string :prefecture_id,  null: false
      t.string :city,        null: false
      t.string :town,        null: false
      t.string :block
      t.string :phone_number
      t.timestamps
    end
  end
end
