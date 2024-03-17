// Entry point for the build script in your package.json
import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import "chartkick/chart.js"

window.Rails = Rails

Handlebars.registerHelper('formatCurrency', function (value) {
  return `₱ ${parseFloat(value).toFixed(2)}`;
});

Handlebars.registerHelper('itemsTotal', function (value) {
  const total = value.reduce((sum, item) => sum + parseFloat(item.subtotal), 0);
  return `₱ ${parseFloat(total).toFixed(2)}`
});

Rails.start()
