class LeaveType < ApplicationRecord
    has_many :leaves, class_name: "Leave", foreign_key: "leave_type_id"

    validates :max_allowed, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
