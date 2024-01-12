//= require arctic_admin/base
//= require index_as_calendar/application
$(document).ready(function() {
  // Get the link with id "current_user"
  var currentUserLink = $('#current_user a');

  // Check if the link exists
  if (currentUserLink.length > 0) {
    currentUserLink.attr('href', '/admin/profile_card'); 
  }
});
