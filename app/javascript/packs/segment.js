import * as AjaxUtils from '../js/ajax_utils'

document.addEventListener("turbolinks:load", function() {
  document.querySelectorAll(".waypoint-selection-element").forEach(el => el.addEventListener("change", function (event) {
    event.preventDefault();
    let waypoint_from_id = document.querySelector("#segment_waypoint_from_id").value;
    let waypoint_to_id = document.querySelector("#segment_waypoint_to_id").value;

    console.debug(`Calculating distance between waypoints [${waypoint_from_id}] and [${waypoint_to_id}]`);
    
    // call waypoints/distance/:from/:to via API
    fetch(AjaxUtils.createRequest(`/waypoints/distance/${waypoint_from_id}/${waypoint_to_id}`))
    .then(response => response.json())
    .then(response => displayFetchedData(response));
  }));
});

// show recieved values in form
function displayFetchedData(data) {
  console.debug(`Distance = ${data.distance}`);
  document.querySelector("#segment_distance").value = data.distance.toFixed(2);
}