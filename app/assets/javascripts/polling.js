$(function () {  
  if ($('#dashboard-events').length > 0 && $('#upcoming-events').length > 0) {  
    setTimeout(updateEvents, 300000);  
  }  
});  
  
function updateEvents() {  
  $.getScript('/welcome/dashboard.js');  
  setTimeout(updateEvents, 300000);  
}