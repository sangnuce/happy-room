class CreateSummaries < ActiveRecord::Migration[5.1]
  def change
    create_table :summaries do |t|
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
