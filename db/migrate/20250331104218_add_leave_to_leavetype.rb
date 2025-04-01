class AddLeaveToLeavetype < ActiveRecord::Migration[6.1]
  def change
    add_column :leaves, :leave_type_id, :integer
  end
end
