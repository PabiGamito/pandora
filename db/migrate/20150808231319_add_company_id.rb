class AddCompanyId < ActiveRecord::Migration
  def change
    add_column :lenders, :company_id, :integer
  end
end
