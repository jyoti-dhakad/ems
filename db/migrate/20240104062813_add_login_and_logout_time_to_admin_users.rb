class AddLoginAndLogoutTimeToAdminUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :admin_users, :login_time, :datetime
    add_column :admin_users, :logout_time, :datetime
  end
end
