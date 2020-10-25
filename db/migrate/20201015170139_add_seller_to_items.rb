class AddSellerToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :buyer_id, :integer, foreign_key:true
    add_column :items, :seller_id, :integer, foreign_key:true, null:false
  end
end
