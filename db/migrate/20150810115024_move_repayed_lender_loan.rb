class MoveRepayedLenderLoan < ActiveRecord::Migration
  def change
    add_column :loans, :total_repayed, :float
  end
end
