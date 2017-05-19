class CreateCategoryTable < ActiveRecord::Migration[4.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :expense_id
    end
  end
end
