module StockVersionsHelper
  def whodunnit_user(user_id)
    User.find_by(id: user_id)
  end

  def event_badge(event_name)
    case event_name
    when "create"
      content_tag(:span, event_name.upcase, class: "badge bg-danger")
    when "update"
      content_tag(:span, event_name.upcase, class: "badge bg-warning")
    end
  end
end
