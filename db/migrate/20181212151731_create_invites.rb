class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.string :email
      t.references :organization, foreign_key: true
      t.date :expires_at

      t.timestamps
    end
  end
end
