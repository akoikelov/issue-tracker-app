class AddLatitudeLongitudeFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :lat, :float, null: true
    add_column :users, :lng, :float, null: true
  end
end
