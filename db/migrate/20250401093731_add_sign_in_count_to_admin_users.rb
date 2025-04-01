class AddSignInCountToAdminUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :admin_users, :sign_in_count, :integer, default: 0, null: false
  end
end
