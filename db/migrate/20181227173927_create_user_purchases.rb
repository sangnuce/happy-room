class CreateUserPurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :user_purchases do |t|
      t.integer :user_id
      t.integer :purchase_id
      t.float :amount

      t.timestamps
    end
  end
end
