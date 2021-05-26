import * as AjaxUtils from '../js/ajax_utils'

let btnSearch = document.querySelector(".location-search-button");

document.querySelector(".location-search-button").addEventListener("click", function (event) {
  event.preventDefault();
  let keyword = document.querySelector("#waypoint_address").value;
  if (keyword) {
    console.debug(`Doing waypoint search with keywords: ${keyword}`);
    
    // call waypoints/search/:keyword via API
    fetch(AjaxUtils.createRequest("/waypoints/search/" + keyword))
      .then(response => response.json())
      .then(response => displayFetchedData(response));

    // meanwhile, change button to show that request is in progress
    disableSearchButton(btnSearch);
  } else {
    displayError("No keywords given.");
  }
});

// show recieved values in form
function displayFetchedData(data) {
  console.debug("Response received");
  if (data.country) {
    document.querySelector("#waypoint_latitude").value = data.latitude;
    document.querySelector("#waypoint_longitude").value = data.longitude;
    document.querySelector("#waypoint_country").value = data.country;
    document.querySelector("#waypoint_continent").value = data.continent;
    displayError(null);
  } else {
    // show error message
    displayError("No results found.");
  }

  enableSearchButton(document.querySelector(".location-search-button"));
}

function displayError(msg) {
  document.querySelector("#lb-search-error").innerText = msg;
}

// enable search button
function enableSearchButton(button) {
  button.disabled = false;
  button.innerText = "Search";
}

// disable search button
function disableSearchButton(button) {
  button.disabled = true;
  button.innerText = "Searching ...";
}