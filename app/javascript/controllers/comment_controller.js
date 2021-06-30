import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form", "button" ]

  showForm(event) {
    event.preventDefault()
    this.formTarget.classList.remove("d-none")
    this.buttonTarget.classList.add("d-none")
  }

  hideForm() {
    this.formTarget.classList.add("d-none")
    this.buttonTarget.classList.remove("d-none")
  }
}
