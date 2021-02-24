module ApplicationHelper

  def addTax(price)
    (price * 1.1).round
  end

end
