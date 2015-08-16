class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :company_id
      t.integer :company_owner_id
      t.integer :user_owner_id
      t.integer :shares
    end
    add_column :companies, :shares, :integer
  end
end
