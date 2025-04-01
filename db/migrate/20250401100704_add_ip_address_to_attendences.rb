class AddIpAddressToAttendences < ActiveRecord::Migration[6.1]
  def change
    add_column :attendences, :ip_address, :string
  end
end
