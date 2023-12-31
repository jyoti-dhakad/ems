ActiveAdmin.register Leave do

  permit_params :staff_id, :start_date, :end_date, :leave_type, :reason, :status

  controller do
    def scoped_collection
      if current_admin_user.staff?
        Leave.where(staff_id: current_admin_user.id)
      else
        Leave.all
      end
    end
  end

  member_action :approve, method: :put do
    resource.update(status: :approved)
    LeaveApprovalMailer.leave_approval(resource).deliver_now
    redirect_to admin_leaves_path, notice: "Leave approved successfully."
  end
  
  member_action :cancel, method: :put do
    resource.update(status: :cancelled)
    # Add any additional logic or notifications for leave cancellation here
    redirect_to admin_leaves_path, notice: "Leave cancelled successfully."
  end

  scope "All", default: true do |leaves|
    leaves
  end

  scope "Last Month" do |leaves|
    leaves.where("start_date >= ? AND start_date <= ?", 1.month.ago.beginning_of_month, 1.month.ago.end_of_month)
  end

  scope "Current Month" do |leaves|
    leaves.where("start_date >= ? AND start_date <= ?", Date.today.beginning_of_month, Date.today.end_of_month)
  end

  scope "Next Month" do |leaves|
    leaves.where("start_date >= ? AND start_date <= ?", 1.month.from_now.beginning_of_month, 1.month.from_now.end_of_month)
  end

  scope "Today" do |leaves|
    leaves.where("start_date = ?", Date.today)
  end

  index do
    selectable_column
    id_column
    
    if current_admin_user.admin_user?
      column :staff_id do |staff|
        staff_email = AdminUser.find_by(id: staff.staff_id)
        staff_email.email
      end
    end

    column :start_date
    column :end_date
    column :leave_type
    column :reason
    column :status
    
    actions 
  end
  
  action_item :approve, only: :show do
    if current_admin_user.admin_user? && !resource.approved?
      link_to 'Approve', "/admin/leaves/#{params[:id]}/approve", method: :put
    end
  end
  
  action_item :cancel, only: :show do
    if current_admin_user.admin_user? && !resource.cancelled?
      link_to 'Cancel', "/admin/leaves/#{params[:id]}/cancel", method: :put
    end
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
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
      f.input :leave_type, as: :select, collection: Leave.leave_types.values
      f.input :reason
    end
    f.actions
  end

  filter :staff_id,as: :select,collection: proc { AdminUser.all.map { |user| [user.email, user.id] } }, if: proc { current_admin_user&.admin_user? }
  filter :start_date
  filter :end_date
  filter :leave_type, as: :select, collection: Leave.leave_types.values
  filter :reason
  filter :status, as: :select, collection: [['Pending', 0], ['Cancelled',1], ['Approved', 2]]
  
end
