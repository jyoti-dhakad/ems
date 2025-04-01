class AddLocationToAttendences < ActiveRecord::Migration[6.1]
  def change
    add_column :attendences, :latitude, :float
    add_column :attendences, :longitude, :float
    add_column :attendences, :city, :string
    add_column :attendences, :country, :string
  end
end
