class AddDetailsToAdminUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :admin_users, :full_name, :string
    add_column :admin_users, :contact_number, :string
    add_column :admin_users, :address, :string
    add_column :admin_users, :date_of_birth, :date
    add_column :admin_users, :gender, :string
  end
end
