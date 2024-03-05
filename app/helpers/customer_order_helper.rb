module CustomerOrderHelper
  def order_status_badge(order)
    case order.status
    when "done"
      content_tag(:span, "Done", class: "badge bg-success")
    when "in_progress"
      content_tag(:span, "In Progress", class: "badge bg-warning")
    end
  end

  def order_name(order)
    case order.status
    when "done"
      content_tag(:p, order.name, class: "text-decoration-line-through")
    when "in_progress"
      content_tag(:p, order.name)
    end
  end
end
