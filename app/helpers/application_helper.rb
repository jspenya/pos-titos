module ApplicationHelper
  def price_to_peso(price)
    number_to_currency(price, unit: "₱", format: "%u %n")
  end
end
