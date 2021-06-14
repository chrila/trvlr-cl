import { Controller } from "stimulus"
import * as AjaxUtils from '../js/ajax_utils'

export default class extends Controller {
  static targets = [ "button", "address", "error", "continent", "country", "longitude", "latitude" ]

  search() {
    let keyword = this.addressTarget.value
    if (keyword) {
      console.debug(`Doing waypoint search with keywords: ${keyword}`)

      // call waypoints/search/:keyword via API
      fetch(AjaxUtils.createRequest("/waypoints/search/" + keyword))
        .then(response => response.json())
        .then(response => this.displayFetchedData(response))

      // meanwhile, change button to show that request is in progress
      this.disableSearchButton()
    } else {
      this.displayError("No keywords given.")
    }
  }

  // show recieved values in form
  displayFetchedData(data) {
    console.debug("Response received")
    if (data.country) {
      this.latitudeTarget.value = data.latitude
      this.longitudeTarget.value = data.longitude
      this.countryTarget.value = data.country
      this.continentTarget.value = data.continent
      // replace search keyword with address of found place
      this.addressTarget.value = data.address
      this.displayError(null)
    } else {
      // show error message
      this.displayError("No results found.")
    }

    this.enableSearchButton()
  }

  displayError(msg) {
    this.errorTarget.classList.toggle("invalid-feedback", msg != null)
    this.addressTarget.classList.toggle("is-invalid", msg != null)
    this.addressTarget.classList.toggle("is-valid", msg == null)
    this.errorTarget.innerText = msg
  }

  // enable search button
  enableSearchButton() {
    this.buttonTarget.disabled = false
    this.buttonTarget.innerText = "Search"
  }

  // disable search button
  disableSearchButton() {
    this.buttonTarget.disabled = true
    this.buttonTarget.innerText = "Searching ..."
  }
}
