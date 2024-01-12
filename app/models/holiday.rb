class Holiday < ApplicationRecord
    validates :name, :date, presence: true
    validate :future_date

    scope :past, -> { where("date < ?", Date.today).order(date: :desc) }
    scope :upcoming, -> { where("date >= ?", Date.today).order(date: :asc) }

    def status
        return "Past" if date < Date.today
        return "Upcoming"
    end

    private

    def future_date
        errors.add(:date, "must be in the future") if date < Date.today
    end
    
end