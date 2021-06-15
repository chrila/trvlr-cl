import { Controller } from "stimulus"
import { FetchRequest } from "@rails/request.js"

export default class extends Controller {
  static targets = [ "from", "to", "distance" ]

  async calculateDistance() {
    console.debug(`Calculating distance between waypoints [${this.fromTarget.value}] and [${this.toTarget.value}]`)

    // call waypoints/distance/:from/:to via API
    const request = new FetchRequest("get", `/waypoints/distance/${this.fromTarget.value}/${this.toTarget.value}`)
    const response = await request.perform()
    if (response.ok) {
      this.displayFetchedData(await response.json)
    }
  }

  // show recieved values in form
  displayFetchedData(data) {
    console.debug(`Distance = ${data.distance}`)
    this.distanceTarget.value = data.distance.toFixed(2)
  }
}
