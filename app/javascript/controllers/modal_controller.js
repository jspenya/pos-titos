import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  close(e) {
    e.preventDefault();

    const modal = document.getElementById("checkout_modal");
    modal.innerHTML = "";
  }
}
