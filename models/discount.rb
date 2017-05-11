# should know everything about discount, when they apply, and how to apply them on order

class Discount

  attr_reader :discount_amount, :min_spend, :deliv_type, :price_decrease, :delvery_min

  def initialize(settings = {})
    @discount_percent = settings[:discount_amount] || 10
    @min_spend = settings[:min_spend] || 30
    @deliv_type = settings[:deliv_type] || :express
    @price_change = settings[:price_change] || 5
    @delvery_min = settings[:delvery_min] || 2
  end


end
