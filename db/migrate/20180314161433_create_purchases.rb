class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.integer :user_id
      t.date :date
      t.float :amount
      t.string :note

      t.timestamps
    end
  end
end
