import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    flatpickr(".flatpickr_start_time", {
      enableTime: true,
      dateFormat: "F j, Y h:i K"
    })

    flatpickr(".flatpickr_end_time", {
      enableTime: true,
      dateFormat: "F j, Y h:i K"
    })
  }

  search(event) {
    // event.preventDefault()
    // Rails.fire(this.formTarget, "submit")
    console.log("Form Submitted")
  }
}