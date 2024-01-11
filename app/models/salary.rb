class Salary < ApplicationRecord
    belongs_to :staff, class_name: 'AdminUser', foreign_key: 'staff_id'
  
    enum status: {
      Pending: 'Pending',
      Paid: 'Paid'
    }
  
    enum payment_method: {
      Cash: 'Cash',
      Online: 'Online'
    }
  
    validates :staff_id, presence: true
    validates :date, :payment_method, presence: true
    validates :amount, :status, presence: true
  
    validate :unique_month_year_combination, on: :create
  
    # Method to calculate salary after deduction for leaves
    def calculate_deducted_salary

        return { deducted_amount: 0, net_amount: 0 } unless staff.present? && date.present? && amount.present?

        leaves_in_month = staff.leaves.where(
            "strftime('%m', start_date) = ? AND strftime('%Y', start_date) = ? AND status = ? AND leave_type = ?",
            date.month.to_s.rjust(2, '0'), date.year.to_s, Leave.statuses[:approved], Leave.leave_types[:Loss_of_pay]
        )
    
        total_days_in_month = Time.days_in_month(date.month, date.year)
        sal_per_day = amount / total_days_in_month
        total_leave_days = leaves_in_month.sum { |leave| (leave.end_date - leave.start_date).to_i + 1 }
    
        # Calculated net amount after leaves deduction
        net_amount = [amount - sal_per_day * total_leave_days, 0].max.to_i
    
        # Amount deducted from the original amount
        deducted_amount = (amount - net_amount).to_i
    
        {
            original_amount: "₹#{amount.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}",
            net_amount: "₹#{net_amount.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}",
            deducted_amount: "₹#{deducted_amount.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}",
            leaves: total_leave_days
        }
    end
  
    private
  
    def unique_month_year_combination
        if date.present?
          existing_salary = Salary.find_by(staff_id: staff_id, date: date.beginning_of_month..date.end_of_month)
          errors.add(:date, 'already has a salary entry for this staff member') if existing_salary.present?
        end
    end
      
  end