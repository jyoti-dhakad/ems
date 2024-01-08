# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    # Welcome message for logged-in user
    if current_admin_user.staff?
      div class: "welcome-message" do
        h2 "Welcome, #{current_admin_user.email}!"
        h4 "Your dashboard is ready for you."
      end
    end

    # Check if the current user is a staff member
    if current_admin_user.staff?

      div class: "dashboard-container" do
        div class: "notice-board" do
          # Fetch the latest notice
          notice = NoticeBoard.last

          # Display the notice board
          h2 "Notice"
          h3 notice.subject
          span notice.content
        end

        div class: "check-in-container" do
          render partial: 'admin/check_in_descriptions'
          div class: "check_in_card" do
            link_to "Check In", login_staffs_path, method: :post
          end
        end

        div class: "check-out-container" do
          render partial: 'admin/check_out_descriptions'
          div class: "check_out_card" do
            link_to "Check Out", logout_staffs_path, method: :delete
          end
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
