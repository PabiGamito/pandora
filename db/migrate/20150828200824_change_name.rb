class ChangeName < ActiveRecord::Migration
  def change
  	rename_table(:buy_request, :buy_requests)
  end
end
