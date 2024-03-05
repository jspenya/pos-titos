// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"

Handlebars.registerHelper('formatCurrency', function (value) {
  return `₱ ${parseFloat(value).toFixed(2)}`;
});

Handlebars.registerHelper('itemsTotal', function (value) {
  const total = value.reduce((sum, item) => sum + parseFloat(item.subtotal), 0);
  return `₱ ${parseFloat(total).toFixed(2)}`
});
