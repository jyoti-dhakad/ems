class Leave < ApplicationRecord
    belongs_to :staff, class_name: 'AdminUser', foreign_key: 'staff_id'
  
    enum leave_type: {
      Earned_leave: 'Earned Leave',
      Casual_leave: 'Casual Leave',
      Loss_of_pay: 'Loss Of Pay',
      Comp_off: 'Comp-Off',
      Sick_leave: 'Sick Leave'
    }

    enum status: { pending: 0, cancelled: 1, approved: 2 }
  
    validates :staff_id, presence: true
    validates :start_date, :end_date, presence: true
    validates :leave_type, :reason, presence: true
    
    validate :end_date_after_start_date
    validate :unique_month_leave_day, on: :create
  
    private
  
    def end_date_after_start_date
      return if end_date.blank? || start_date.blank?
  
      errors.add(:end_date, 'must be greater than or equal to start date') if end_date < start_date
    end

    def unique_month_leave_day
      return unless staff_id.present? && end_date.present?
    
      existing_leave = Leave.find_by(staff_id: staff_id, end_date: end_date)
      errors.add(:end_date, 'You have already applied for leave on this day in this month') if existing_leave.present?
    end
    
  end
