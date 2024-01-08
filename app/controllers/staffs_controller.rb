class StaffsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def login
      # Logic to record login time
      current_admin_user.update(login_time: Time.now)
      flash[:success] = "Check in successful"
      redirect_to admin_root_path
    end
  
    def logout
      # Logic to record logout time and calculate attendance
      current_admin_user.update(logout_time: Time.now)
      calculate_attendance(current_admin_user)
      flash[:success] = "Check out successful"
      redirect_to admin_root_path
    end

    def show_attendence
      start_date = params[:start].to_date
      end_date = params[:end].to_date
    
      # Fetch attendance records for staff members between start_date and end_date
      events = current_admin_user.attendences.where(date: start_date..end_date).map do |attendance|
        {
          title: attendance.status, # Display staff name as the event title
          start: attendance.date.strftime('%Y-%m-%d'),
          # className: attendance.status.downcase # Add a CSS class based on attendance status (present, absent, etc.)
        }
      end
    
      render json: events
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
        elsif time_difference >= 4 
          find_attendence = user.attendences.find_by(date: user.login_time.to_date)
          if find_attendence
            find_attendence.update(status: "Half_day")
          else 
            Attendence.create(staff: user, status: "Half_day", date: user.login_time.to_date)
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
  