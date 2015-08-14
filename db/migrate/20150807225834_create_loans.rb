class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :lender_id
      t.integer :receiver_id
      t.boolean :amount
      t.boolean :pending
      t.timestamp
    end
  end
end
