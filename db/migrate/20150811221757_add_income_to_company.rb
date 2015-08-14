class AddIncomeToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :income, :float
    remove_column :companies, :country, :string
  end
end
