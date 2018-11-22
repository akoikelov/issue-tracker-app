class AddUniqueIndexInOrganization < ActiveRecord::Migration[5.2]
  def change
    remove_index :organizations, :user_id
    add_index :organizations, :user_id, unique: true
  end
end
