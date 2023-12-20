class Leave < ApplicationRecord
    belongs_to :staff, class_name: 'AdminUser', foreign_key: 'staff_id'

    enum leave_type: {
    Half_day: 'Half day',
    Full_day: 'Full day'
    }

    validates :staff_id, presence:true
    validates :start_date, :end_date, presence:true
    validates :leave_type, :reason, presence:true

    
end
