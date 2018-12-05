class AddRoleFieldToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_reference :employees, :role, foreign_key: true, null: true
  end
end
