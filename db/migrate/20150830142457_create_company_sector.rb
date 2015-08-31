class CreateCompanySector < ActiveRecord::Migration
  def change
    create_table :company_sectors do |t|
    	t.integer :company_id
    	t.integer :owner_company_id
    end
    add_column :companies, :main, :boolean
  end
end
