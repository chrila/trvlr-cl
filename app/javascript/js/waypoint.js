import * as AjaxUtils from '../js/ajax_utils'

document.addEventListener("turbolinks:load", function() {
  document.querySelector(".location-search-button").addEventListener("click", function (event) {
    event.preventDefault();
    let keyword = document.querySelector("#waypoint_address").value;

    if (keyword) {
      console.log("Doing waypoint search with keywords: " + keyword);
    
      // call waypoints/search/:keyword via API
      fetch(AjaxUtils.createRequest("/waypoints/search/" + keyword)).then(v => {
        v.text().then(txt => {
          eval(txt);
        })
      });
    }
  });
});