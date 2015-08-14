class UpdateUser2 < ActiveRecord::Migration
  def change
    remove_column :companies, :public
    add_column :companies, :market, :boolean
    add_column :companies, :sector, :string
  end
end
