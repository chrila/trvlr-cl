import { Controller } from "stimulus"
import * as AjaxUtils from '../js/ajax_utils'

export default class extends Controller {
  static targets = [ "from", "to", "distance" ]

  calculateDistance() {
    console.debug(`Calculating distance between waypoints [${this.fromTarget.value}] and [${this.toTarget.value}]`)

    // call waypoints/distance/:from/:to via API
    fetch(AjaxUtils.createRequest(`/waypoints/distance/${this.fromTarget.value}/${this.toTarget.value}`))
      .then((response) => response.json())
      .then((response) => this.displayFetchedData(response))
  }

  // show recieved values in form
  displayFetchedData(data) {
    console.debug(`Distance = ${data.distance}`)
    this.distanceTarget.value = data.distance.toFixed(2)
  }
}
