class AddMaxLoan < ActiveRecord::Migration
  def change
    add_column :loans, :max, :boolean
  end
end
