class UpdateLoanAgain < ActiveRecord::Migration
  def change
    add_column :loans, :repay_time, :integer
    add_column :loans, :rate, :float
  end
end
