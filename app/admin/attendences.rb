ActiveAdmin.register Attendence do

  permit_params :staff_id, :date, :status
  
  controller do
    def scoped_collection
      if current_admin_user.staff?
        Attendence.where(staff_id: current_admin_user.id)
      else
        Attendence.all
      end
    end

    def calculate_total_attendance_count
      @total_attendance_count =
        if current_admin_user&.admin_user?
          Attendence.ransack(params[:q]).result.count
        elsif current_admin_user&.staff?
          Attendence.where(staff_id: current_admin_user.id).ransack(params[:q]).result.count
        else
          Attendence.count
        end
    end
  
    helper_method :calculate_total_attendance_count
  end
  
  index do
    calculate_total_attendance_count
    div class: 'total-attendance-count' do
      "<strong>Total Attendance Count:</strong> #{calculate_total_attendance_count}".html_safe
    end
    
    selectable_column
    id_column

    if current_admin_user.admin_user?
      column :staff_id do |staff|
        staff_email = AdminUser.find_by(id: staff.staff_id)
        staff_email.email
      end
    end
   
    column :date
    column :status
    
    actions
      
  end

  show do
    attributes_table do
      row :staff_id if current_admin_user.admin_user?
      row :date
      row :status
    end
  end

  form do |f|
     f.inputs 'Attendences Details' do
      f.input :staff_id, as: :select, collection: AdminUser.where(role: :staff).pluck(:email, :id)
      f.input :date
      f.input :status, as: :select, collection: Attendence.statuses.values
     
    end
    f.actions
  end
  
  filter :staff_id,as: :select,collection: proc { AdminUser.all.map { |user| [user.email, user.id] } }, if: proc { current_admin_user&.admin_user? }
  filter :date
  filter :status, as: :select, collection: Attendence.statuses.values
end
