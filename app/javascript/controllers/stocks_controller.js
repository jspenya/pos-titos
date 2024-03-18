import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stocks"
export default class extends Controller {
  static targets = ["form"]
  connect() {
  }

  submit(e) {
    // debugger
    e.preventDefault
    // console.log('Submitted!')
  }
}
