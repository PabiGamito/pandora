class CreateEmployeeTraining < ActiveRecord::Migration
  def change
    create_table :employee_trainings do |t|
    	t.integer :training_type
    	t.integer :company_id
    	t.datetime :date
    end
  end
end
