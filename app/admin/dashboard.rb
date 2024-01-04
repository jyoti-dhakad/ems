# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    # Check if the current user is a staff member
    if current_admin_user.staff?
      # Show attendance-related information
      div class: "attendance_container" do
        span class: "attendance_option" do
          link_to "Login", login_staffs_path, method: :post
        end

        span class: "attendance_option" do
          link_to "Logout", logout_staffs_path, method: :delete
        end
      end

      # Display flash messages if present
      if flash[:success]
        div class: "flash_message success" do
          flash[:success]
        end
      elsif flash[:error]
        div class: "flash_message error" do
          flash[:error]
        end
      end
    end

    if current_admin_user.admin_user?
      div class: "blank_slate_container", id: "dashboard_default_message" do
        span class: "blank_slate" do
          span I18n.t("active_admin.dashboard_welcome.welcome")
          small I18n.t("active_admin.dashboard_welcome.call_to_action")
        end
      end
    end
  end
end
