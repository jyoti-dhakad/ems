class Leave < ApplicationRecord
    belongs_to :staff, class_name: 'AdminUser', foreign_key: 'staff_id'

    enum leave_type: {
    Half_day: 'Half day',
    Full_day: 'Full day'
    }
end
