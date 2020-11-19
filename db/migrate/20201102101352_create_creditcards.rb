class CreateCreditcards < ActiveRecord::Migration[6.0]
  def change
    create_table :creditcards do |t|
      t.integer :user_id
      t.string :card_id
      t.string :customer_id

      t.timestamps
    end
  end
end
