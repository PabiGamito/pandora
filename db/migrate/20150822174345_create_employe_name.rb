class CreateEmployeName < ActiveRecord::Migration
  def change
    create_table :employe_names do |t|
      t.string :name
      t.boolean :first_name
      t.string :origin
    end
  end
end
