ActiveAdmin.register LeaveType do
  permit_params :name, :max_allowed

  index do
    selectable_column
    id_column
    column :name
    column :max_allowed
    actions
  end
end
