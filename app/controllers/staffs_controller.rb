class StaffsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def login
      # Logic to record login time
      current_admin_user.update(login_time: Time.now)
      flash[:success] = "Login successful"
      redirect_to admin_root_path
    end
  
    def logout
      # Logic to record logout time and calculate attendance
      current_admin_user.update(logout_time: Time.now)
      calculate_attendance(current_admin_user)
      flash[:success] = "Logout successful"
      redirect_to admin_root_path
    end
  
    private
  
    def calculate_attendance(user)
      # Check if login and logout times are present and on the same day
      if user.login_time.present? && user.logout_time.present? && user.login_time.to_date == user.logout_time.to_date
        # Calculate time difference in hours
        time_difference = (user.logout_time - user.login_time) / 1.hour
  
        # Check if time difference is greater than or equal to 8 hours
        if time_difference >= 8
          # Create attendance record
          find_attendence = user.attendences.find_by(date: user.login_time.to_date)
          if find_attendence
            find_attendence.update(status: "Present")
          else 
            Attendence.create(staff: user, status: "Present", date: user.login_time.to_date)
          end
        else
          find_attendence = user.attendences.find_by(date: user.login_time.to_date)
          if find_attendence
            find_attendence.update(status: "Absent")
          else 
            Attendence.create(staff: user, status: "Absent", date: user.login_time.to_date)
          end
        end
      end
    end
  end
  