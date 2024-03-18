module StocksHelper
  def stock_badge(stock)
    if stock.quantity > 0 && !(stock.quantity <= 5)
      content_tag(:span, "In Stock", class: "badge bg-success")
    elsif stock.quantity <= 5 && stock.quantity > 0
      content_tag(:span, "Near Out of Stock", class: "badge bg-danger")
    else
      content_tag(:span, "Out of Stock", class: "badge bg-light text-dark")
    end
  end
end
