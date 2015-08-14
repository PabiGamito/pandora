class CreateProfitloss < ActiveRecord::Migration
  def change
    create_table :Transactions do |t|
      t.integer :amount
      t.string :description
      t.string :type
      t.string :from
      t.integer :company_id
      t.boolean :income
      t.timestamps
    end
  end
end
