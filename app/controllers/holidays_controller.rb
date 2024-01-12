class HolidaysController < ApplicationController
    skip_before_action :verify_authenticity_token

    def show_holidays
        start_date = params[:start].to_date
        end_date = params[:end].to_date
      
        events = Holiday.where(date: start_date..end_date).map do |holiday|
          {
            title: holiday.name,
            start: holiday.date.strftime('%Y-%m-%d'),
          }
        end
      
        render json: events
    end
end