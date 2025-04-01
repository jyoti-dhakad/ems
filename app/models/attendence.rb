class Attendence < ApplicationRecord
    belongs_to :staff, class_name: 'AdminUser', foreign_key: 'staff_id'

    enum status: {
    present: 'Present',
    absent: 'Absent',
    half_day: 'Half_day'
    }

    validates :staff_id, :status, :date, presence:true
    

    geocoded_by :ip_address, latitude: :latitude, longitude: :longitude
  after_validation :geocode, if: ->(obj) { obj.ip_address.present? && obj.latitude.blank? }
  def fetch_location
    results = Geocoder.search(ip_address)
    if geo = results.first
      self.latitude = geo.latitude
      self.longitude = geo.longitude
      self.city = geo.city
      self.country = geo.country
    end
  end

    
end
