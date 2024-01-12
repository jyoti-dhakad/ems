ActiveAdmin.register_page "Holiday Calendar" do
    menu parent: "Holidays"
    content do
        div class: "calendar-container" do
            div id: "calendar"
        end

        script type: "text/javascript" do
            raw <<~JAVASCRIPT
              document.addEventListener('DOMContentLoaded', function() {
                $('#calendar').fullCalendar({
                  events: '/holidays/show_holidays', 
                  header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                  },
                  defaultView: 'month',
                  eventRender: function(event, element) {
                    element.css('background-color', 'green');
                  }

                });
              });
            JAVASCRIPT
          end
    end
end