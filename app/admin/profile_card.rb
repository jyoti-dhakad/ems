ActiveAdmin.register_page "Profile Card" do
    menu label: "Profile Card", priority: 999, if: proc { false }
  
    content do
      div class: "profile-card-container" do
        div class: "profile-card" do
        #   div class: "profile-card-image" do
            if current_admin_user.profile_image.attached?
              img(src: url_for(current_admin_user.profile_image), alt: "Profile Image", class: "profilee-image")
            else
              span class: "no-image" do
                "No Profile Image"
              end
            end
        #   end
  
          div class: "profile-details" do
            h2 class: "user-name" do
              current_admin_user.full_name
            end

            div class: "user-info" do
                span "Role: #{current_admin_user.role}"
            end

            div class: "user-info" do
                span "Gender: #{current_admin_user.gender}"
              end

            div class: "user-info" do
                span "Address: #{current_admin_user.address if current_admin_user.address}"
            end
            
            if current_admin_user.staff?
              div class: "user-info" do
                span "Department: #{current_admin_user.department.department_name if current_admin_user.department}"
              end
            end

            div class: "user-info" do
                span "Date of Birth: #{current_admin_user.date_of_birth.strftime('%d %b, %Y') if current_admin_user.date_of_birth}"
            end
  
            div class: "user-info" do
              span "Contact Number: #{current_admin_user.contact_number if current_admin_user.contact_number}"
            end

            div class: "view-full-profile" do
                link_to "View Full Profile", admin_profiles_path
            end
  
          end
        end
      end
    end
  end
  