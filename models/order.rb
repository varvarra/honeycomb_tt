class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  DISCOUNT = 10
  MIN_AMOUNT = 30

  attr_accessor :material, :items,  :total

  def initialize(material)
    self.material = material
    self.items = []
    self.total = 0
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
  end

  def total_cost
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

  def over_thirty?(total)
    if total > MIN_AMOUNT.to_f
      total * (1-(DISCOUNT.to_f/100))
    else
      total
    end
  end
end
