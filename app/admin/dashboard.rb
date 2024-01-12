# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # Welcome message for logged-in user
    if current_admin_user.staff?
      div class: "welcome-message" do
        h2 "Welcome, #{current_admin_user.full_name}!"
        h4 "Your dashboard is ready for you."
      end
    end

    # Check if the current user is a staff member
    if current_admin_user.staff?

      div class: "dashboard-container" do
        div class: "left-section" do
          div class: "notice-board" do
            # Fetch the latest notice
            notice = NoticeBoard.last

            # Display the notice board
            h2 "Notice"
            h3 notice.subject
            span notice.content
          end
        end

        div class: "center-section" do
          div class: "holidays-section" do
            h2 "Holidays"
        
            # View Full Calendar link
            div class: "view-full-calendar" do
              a href: "/admin/holiday_calendar" do
                "View Full Calendar"
              end
            end
        
            div class: "holidays-cards-container" do
              div class: "upcoming-past-container" do
                # Upcoming holidays
                div class: "upcoming-holidays-container" do
                  h3 "Upcoming Holidays"
                  ul class: "holidays-cards upcoming-holidays" do
                    Holiday.upcoming.limit(4).each do |holiday|
                      li class: "holiday-card" do
                        h4 holiday.name
                        span holiday.date.strftime('%e %B, %Y')
                      end
                    end
                  end
                end
        
                # Past holidays
                div class: "past-holidays-container" do
                  h3 "Past Holidays"
                  ul class: "holidays-cards past-holidays" do
                    Holiday.past.limit(4).each do |holiday|
                      li class: "holiday-card" do
                        h4 holiday.name
                        span holiday.date.strftime('%e %B, %Y')
                      end
                    end
                  end
                end
              end
            end
          end
        end
                        
        div class: "right-section" do
          div class: "check-in-out-container" do
            render partial: 'admin/check_in_descriptions'
            div class: "check_in_card" do
              link_to "Check In", login_staffs_path, method: :post
            end

            render partial: 'admin/check_out_descriptions'
            div class: "check_out_card" do
              link_to "Check Out", logout_staffs_path, method: :delete
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
        end
      end

      # # Display flash messages if present
      # if flash[:success]
      #   div class: "flash_message success" do
      #     flash[:success]
      #   end
      # elsif flash[:error]
      #   div class: "flash_message error" do
      #     flash[:error]
      #   end
      # end
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
