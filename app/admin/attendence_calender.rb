ActiveAdmin.register_page "Attendance Calendar" do
    menu parent: "Attendances"
    content do
        div class: "calendar-container" do
            div id: "calendar"
        end

        script type: "text/javascript" do
            raw <<~JAVASCRIPT
              document.addEventListener('DOMContentLoaded', function() {
                $('#calendar').fullCalendar({
                  events: '/staffs/show_attendence', 
                  header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                  },
                  defaultView: 'month',
                  eventRender: function(event, element) {
                    console.log(event);
                    if (event.title === 'Present') {
                        element.css('background-color', 'green');
                      } else if (event.title === 'Absent') {
                        element.css('background-color', 'red');
                      } else {
                        // Add more conditions as needed
                      }

                    // Customize the rendering of each event if needed
                  }

                });
              });
            JAVASCRIPT
          end
    end
  end
  