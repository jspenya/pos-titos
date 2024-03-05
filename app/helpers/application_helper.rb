module ApplicationHelper
  def price_to_peso(price)
    number_to_currency(price, unit: "₱", format: "%u %n")
  end

  def shortify(word, max_length = 12, extension = "...")
    if word.length > max_length
      "#{word[0...max_length]}#{extension}"
    else
      word
    end
  end
end
