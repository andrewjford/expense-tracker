class CreateExpensesTable < ActiveRecord::Migration[4.2]
  def change
    create_table :expenses do |t|
      t.datetime :date
      t.decimal :amount
      t.string :vendor
      t.integer :user_id
      t.timestamps
    end
  end
end
