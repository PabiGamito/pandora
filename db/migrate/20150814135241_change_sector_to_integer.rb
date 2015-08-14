class ChangeSectorToInteger < ActiveRecord::Migration
  def change
    remove_column :companies, :sector, :string
    add_column :companies, :sector, :integer
  end
end
