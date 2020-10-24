class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :ancestry, foreign_key: true, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
