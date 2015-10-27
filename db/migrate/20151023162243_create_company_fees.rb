class CreateCompanyFees < ActiveRecord::Migration
  def change
    create_table :company_fees do |t|
    	t.float :fee
    	t.integer :company_id
    	t.integer :sector
    end
  end
end
