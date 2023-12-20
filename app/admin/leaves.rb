ActiveAdmin.register Leave do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :staff_id, :start_date, :end_date, :leave_type, :reason, :status
  #
  controller do
    def scoped_collection
      if current_admin_user.staff?
        Leave.where(staff_id: current_admin_user.id)
      else
        Leave.all
      end
    end
  end
  # member_action :approve, method: :put do
  #   resource.update(status: true)
  #   redirect_to admin_leaves_path, notice: "Leave approved successfully."
  # end


  index do
    selectable_column
    id_column
    column :staff_id if current_admin_user.admin_user?
    column :start_date
    column :end_date
    column :leave_type
    column :reason
    column :status
  
    
    # actions defaults: true do |leave|
    #   link_to 'Approve', approve_admin_leave_path(leave), method: :put if !leave.status
    # end
    actions
  end
  show do
    attributes_table do
      row :staff_id if current_admin_user.admin_user?
      row :start_date
      row :end_date
      row :leave_type
      row :reason
      row :status
  
      
    end
  end

  form do |f|
     f.inputs 'Leaves Details' do
      f.input :staff_id, as: :hidden, input_html: { value: current_admin_user.id }
      f.input :start_date
      f.input :end_date
      f.input :leave_type, as: :select, collection: Leave.leave_types.values
      f.input :reason
      f.input :status
      

    end
    f.actions
  end
  
end
