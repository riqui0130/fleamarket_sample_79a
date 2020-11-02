class Creditcard < ApplicationRecord
  def change
    create_table :cards do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.string :card_id, null: false
      t.string  :customer_id, null: false
    end
  end
end
