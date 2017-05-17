# should know everything about discount, when they apply, and how to apply them on order

# require relative './models/order.rb'

class Discount

  attr_reader :discount_percent, :min_spend, :deliv_type, :price_decrease, :delivery_min, :percentage, :error_msg

  def initialize(settings = {})
    @discount_percent = settings[:discount_percent] || 10
    @min_spend = settings[:min_spend] || 30
    @deliv_type = settings[:deliv_type] || :express
    @price_decrease= settings[:price_decrease] || 5
    @delivery_min = settings[:delivery_min] || 2
    @error_msg = settings[:error_msg] || "This order already has a discount"
    @percentage = (100.to_f - @discount_percent) / 100
  end

  def update_total(total, deliveries)
    if deliveries.count(deliv_type) >= delivery_min
      apply_percent(change_price(total, deliveries))
    else
      apply_percent(total)
    end
  end


  def change_price(total, deliveries)
    total - (deliveries.count(deliv_type)*price_decrease)
  end

  def apply_percent(total)
    total > min_spend ? total * percentage : total
  end

end
