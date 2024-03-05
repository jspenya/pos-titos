import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="order-items"
export default class extends Controller {
  connect() {
    this.element.addEventListener('shown.bs.modal', (event) => {
      const url = event.target.dataset.url;
      const modalName = event.target.dataset.name;

      console.log(modalName)
      fetch(url, { headers: { 'Accept': 'application/json' } })
        .then((response) => response.json())
        .then((order_items) => {
          const template = Handlebars.compile(document.getElementById("hb-order-item").innerHTML);
          document.getElementById(`${modalName}_modal_body`).innerHTML = template({ order_items: order_items });

          const paymentOrderTotal = document.getElementById("payment_order_total")
          if (paymentOrderTotal != null) {
            paymentOrderTotal.value = order_items.reduce((sum, item) => sum + parseFloat(item.subtotal), 0);
          }
        });
    });
  }
}
