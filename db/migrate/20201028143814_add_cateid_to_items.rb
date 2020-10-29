class AddCateidToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :category_id, :integer, foreign_key:true, null:false
  end
end
