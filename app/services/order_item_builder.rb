class OrderItemBuilder
  def initialize(grouped_order_items)
    @grouped_order_items = grouped_order_items
  end

  def as_json
    @grouped_order_items.each_with_object([]) do |(product_id, items), arr|
      product = Product.find(product_id)

      arr << {
        product_name: product.name,
        product_price: product.price,
        count: items.count,
        subtotal: items.count * product.price
      }
    end.as_json
  end
end
