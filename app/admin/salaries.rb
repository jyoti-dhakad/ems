ActiveAdmin.register Salary do

  permit_params :staff_id, :date, :payment_method, :amount, :status

  action_item :send_salary_email, only: :show do
    if current_admin_user.admin_user?
      link_to 'Send Salary Email', send_salary_email_admin_salary_path(salary), method: :put
    end
  end

  member_action :send_salary_email, method: :put do
    @salary = resource
    @user = @salary.staff
  
    # Calculate salary after deduction for leaves
    salary_details = @salary.calculate_deducted_salary
  
    # Send the salary email
    SalaryMailer.send_salary_email(@user, @salary, salary_details[:net_amount]).deliver_now
  
    redirect_to admin_salary_path(@salary), notice: 'Salary email sent!'
  end
    
  controller do
    def create
      @salary = Salary.new(permitted_params[:salary])
      
      # Calculate the deducted salary
      net_amount = @salary.calculate_deducted_salary[:net_amount]
      deducted_amount = @salary.calculate_deducted_salary[:deducted_amount]
      create!
    end
    
    def scoped_collection
      if current_admin_user.staff?
        Salary.where(staff_id: current_admin_user.id)
      else
        Salary.all
      end
    end
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

    column :date
    column :payment_method
    column "Original Amount", :amount
    
    column "Amount Deducted", :calculated_salary do |salary|
      salary.calculate_deducted_salary[:deducted_amount]
    end

    column "Net Amount Paid", :calculated_salary do |salary|
      salary.calculate_deducted_salary[:net_amount]
    end

    column :status
    
    actions 
      
  end

  show do
    attributes_table do
      row :staff_id if current_admin_user.admin_user?
      row :date
      row :payment_method
      row :status
    end
  
    if resource.persisted?
      calculated_salary = resource.calculate_deducted_salary
      original_amount = calculated_salary[:original_amount] || 0.0
      deducted_amount = calculated_salary[:deducted_amount] || 0.0
      net_amount = calculated_salary[:net_amount] || 0.0
      total_loss_of_pay_leaves = calculated_salary[:leaves]
  
      render 'admin/salaries/salary_calculations',
             original_amount: original_amount,
             deducted_amount: deducted_amount,
             net_amount: net_amount,
             total_loss_of_pay_leaves: total_loss_of_pay_leaves
    end
  end
  

  form do |f|
     f.inputs 'Salaries Details' do
      f.input :staff_id, as: :select, collection: AdminUser.where(role: :staff).pluck(:email, :id)
      f.input :date
      f.input :payment_method, as: :select, collection: Salary.payment_methods.values
      f.input :status, as: :select, collection: Salary.statuses.values
      f.input :amount

      f.actions
    end
  end

  filter :staff_id,as: :select,collection: proc { AdminUser.all.map { |user| [user.email, user.id] } }, if: proc { current_admin_user&.admin_user? }
  filter :date
  filter :payment_method, as: :select, collection: Salary.payment_methods.values
  filter :amount
  filter :status, as: :select, collection: Salary.statuses.values
  
end


