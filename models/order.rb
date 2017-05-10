class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  DISCOUNT = 10
  MIN_AMOUNT = 30
  NEW_EXP_PRICE = 15
  EXP_MIN = 2

  attr_accessor :material, :items,  :total, :exp_deliveries

  def initialize(material)
    self.material = material
    self.items = []
    self.total = 0
    self.exp_deliveries = []
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
    exp_deliveries << delivery if delivery.name == :express
  end

  def total_cost
    change_exp_prices if exp_deliveries.count >= EXP_MIN
    total = items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
    over_thirty?(total)
  end

  def output
    [].tap do |result|
      result << "Order for #{material.identifier}:"

      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator

      items.each_with_index do |(broadcaster, delivery), index|
        result << [
          broadcaster.name.ljust(COLUMNS[:broadcaster]),
          delivery.name.to_s.ljust(COLUMNS[:delivery]),
          ("$#{delivery.price}").ljust(COLUMNS[:price])
        ].join(' | ')
      end

      result << output_separator
      result << "Total: $#{total_cost}"
    end.join("\n")
  end

  private

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end

  def change_exp_prices
    exp_deliveries.map{|delivery| delivery.price = NEW_EXP_PRICE.to_f }
  end

  def over_thirty?(total)
    if total > MIN_AMOUNT.to_f
      total * (1-(DISCOUNT.to_f/100))
    else
      total
    end
  end

end
