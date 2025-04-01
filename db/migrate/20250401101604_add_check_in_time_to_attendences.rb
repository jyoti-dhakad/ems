class AddCheckInTimeToAttendences < ActiveRecord::Migration[6.1]
  def change
    add_column :attendences, :check_in_time, :datetime
  end
end
