class Experience < ApplicationRecord
    belongs_to :staff, class_name: 'AdminUser', foreign_key: 'staff_id'
end