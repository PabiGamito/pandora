class CreateCompany < ActiveRecord::Migration
  def up
    create_table :company do |t|
      t.integer :user_id
      t.string :name
      t.string :moto
      t.string :country
      t.integer :public
      t.integer :employes
      t.float :balance
      t.float :sales_turnover
      t.float :expenses
      t.float :market_capita
      t.timestamp
    end
    
  end
  
  def down
    drop_table :company
  end 
end
