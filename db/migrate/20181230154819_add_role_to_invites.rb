class AddRoleToInvites < ActiveRecord::Migration[5.2]
  def change
    add_reference :invites, :role, foreign_key: true, null: false
  end
end
