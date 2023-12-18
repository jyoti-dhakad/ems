class Department < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "department_name", "id", "updated_at"]
    end

    enum department_name: {
    Sales: 'Sales',
    Marketing: 'Marketing',
    Finance: 'Finance',
    Engineering: 'Engineering',
    HR: 'Human Resources',
    IT: 'Information Technology'

  }
    
end
