class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :title
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
