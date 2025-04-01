class RemoveLeaveTypeFromLeaves < ActiveRecord::Migration[6.1]
  def change
    remove_column :leaves, :leave_type, :string
  end
end
