class CreateTransactionsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :transactions do |t|
      t.datetime :date
      t.string :category
      t.decimal :amount
      t.string :vendor
      t.integer :user_id
      t.timestamps
    end
  end
end
