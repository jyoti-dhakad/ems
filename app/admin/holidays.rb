ActiveAdmin.register Holiday, as: "Holiday List"  do
  menu parent: "Holidays"
  
  permit_params :name, :date

  scope "All", default: true do |holiday|
    holiday
  end

  scope :past
  scope :upcoming
  
  index do
    selectable_column
    column :name
    column :date
    column :status do |holiday|
      holiday.status
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :date
      row :status do |holiday|
        holiday.status
      end
    end
  end

  form do |f|
    f.inputs 'Holiday Details' do
     f.input :name
     f.input :date, as: :datepicker
   end
   f.actions
  end

  filter :name
  filter :date
  
end
