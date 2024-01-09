ActiveAdmin.register AdminUser, as: "Profile" do
    menu priority: 2
    permit_params(
      :email, :profile_image,
      educations_attributes: [:id, :institution_name, :level, :qualification, :start_year, :completed_year, :specialization, :_destroy],
      experiences_attributes: [:id, :company, :position, :start_date, :end_date, :_destroy],
      documents_attributes: [:id, :document_type, :_destroy, files: []]
    )
  
    actions :all, :except => [:new, :destroy]

    controller do
        def index
          redirect_to admin_profile_path(current_admin_user)
        end
    end
    
    show do
        attributes_table do
          if current_admin_user.staff?
            row :profile_image do |image|
              if image.profile_image.attached?
                div class: 'circular-profile-image' do
                  image_tag(image.profile_image, class: 'profile-image')
                end
              else
                content_tag(:span, 'No Image')
              end
            end
          end
          
          row :email
          row :role 
          row :department_id do |obj|
              department = Department.find_by(id: obj.department_id)
              department.department_name if department
          end
          row :created_at
          row :updated_at
        end
        if current_admin_user.staff?
            panel 'Educations' do
                table_for current_admin_user.educations do
                column :institution_name
                column :level
                column :qualification
                column :start_year
                column :completed_year
                column :specialization
                end
            end
            hr
            panel 'Experiences' do
                table_for current_admin_user.experiences do
                column :company
                column :position
                column :start_date
                column :end_date
                end
            end
            hr
            panel 'Documents' do
              table_for current_admin_user.documents do
                column :document_type
                column :files do |document|
                  if document.files.attached?
                    ul do
                      document.files.each do |file|
                        li do
                          link_to(file.filename, rails_blob_path(file, disposition: 'attachment'))
                        end
                      end
                    end
                  else
                    content_tag(:span, 'No file')
                  end
                end
              end
          end
        end
    end
  
    filter :email
    filter :created_at
  
    form do |f|
      f.inputs 'Staff Profile Details' do
        f.input :email
  
        if current_admin_user.staff?
            f.input :profile_image, as: :file
            hr
            f.has_many :educations, heading: 'Educations', allow_destroy: true, new_record: 'Add Education' do |edu|
            edu.input :institution_name
            edu.input :level
            edu.input :qualification
            edu.input :start_year
            edu.input :completed_year
            edu.input :specialization
            end
            br
            hr
            f.has_many :experiences, heading: 'Experiences', allow_destroy: true, new_record: 'Add Experience' do |exp|
            exp.input :company
            exp.input :position
            exp.input :start_date
            exp.input :end_date
            end
            br
            hr
            f.has_many :documents, heading: 'Documents', allow_destroy: true, new_record: 'Add Document' do |doc|
              doc.input :document_type, as: :select
              doc.input :files, as: :file, input_html: { multiple: true }, hint: (
                if doc.object.files.attached?
                  doc.object.files.map do |file|
                    link_to(file.filename, rails_blob_path(file, disposition: 'attachment')) + tag.br
                  end.join.html_safe
                else
                  content_tag(:span, 'No Files Attached') + + tag.br +
                  content_tag(:span, 'Allowed file formats: PDF, JPEG, or PNG')
                end
              )
            end
            
        end
      end
  
      f.actions
    end
  end
  