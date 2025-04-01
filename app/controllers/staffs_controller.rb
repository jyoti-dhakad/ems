class StaffsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login
    if current_admin_user.login_time.nil?
      current_admin_user.update(login_time: Time.now)
      flash[:success] = "Check in successful"
    else
      flash[:error] = "You are already checked in."
    end
    redirect_to admin_root_path
  end

  def logout
    if current_admin_user.login_time.present?
      current_admin_user.update(logout_time: Time.now)
      calculate_attendance(current_admin_user)
      flash[:success] = "Check out successful"
    else
      flash[:error] = "You must check in before you can check out."
    end
    redirect_to admin_root_path
  end

  def profile_card
    @user = current_admin_user
  end

  def show_attendence
    start_date = params[:start].to_date
    end_date = params[:end].to_date

    events = current_admin_user.attendences.where(date: start_date..end_date).map do |attendance|
      {
        title: attendance.status,
        start: attendance.date.strftime('%Y-%m-%d'),
      }
    end

    render json: events
  end

  def check_in
    ip_info = `curl http://ipinfo.io/json`.strip
    location_data = JSON.parse(ip_info)
    lat, long = location_data['loc'].split(',')
    latitude = lat
    longitude = long
    city = location_data['city']
    country = location_data['country']
  
    attendance = Attendence.create(
      staff_id: current_admin_user.id,
      date: Date.today,
      status: 'Present',
      latitude: latitude,
      longitude: longitude,
      city: city,
      country: country,
      ip_address: location_data['ip'],
      check_in_time: Time.current
    )
  
    if attendance.persisted?
      flash[:success] = "Check-in successful! Location recorded."
    else
      flash[:error] = "Check-in failed!"
    end
  
    redirect_to admin_dashboard_path
  end
  
  
  
  
  
  
  


  private

  def fetch_location(ip_address)
    results = Geocoder.search(ip_address)
    if geo = results.first
      # Return a hash with location data
      {
        latitude: geo.latitude,
        longitude: geo.longitude,
        city: geo.city,
        country: geo.country
      }
    else
      # In case no location is found, return default values (or handle error as needed)
      {
        latitude: nil,
        longitude: nil,
        city: nil,
        country: nil
      }
    end
  end
  
  
  def calculate_attendance(user)
    # Check if login and logout times are present and on the same day
    if user.login_time.present? && user.logout_time.present? && user.login_time.to_date == user.logout_time.to_date
      # Calculate time difference in hours
      time_difference = (user.logout_time - user.login_time) / 1.hour

      # Check if time difference is greater than or equal to 8 hours
      if time_difference >= 8
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
