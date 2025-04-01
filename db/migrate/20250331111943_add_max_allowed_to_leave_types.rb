class AddMaxAllowedToLeaveTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :leave_types, :max_allowed, :integer
  end
end
