class CreateSummaryDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :summary_details do |t|
      t.integer :user_id
      t.integer :summary_id
      t.float :amount

      t.timestamps
    end
  end
end
