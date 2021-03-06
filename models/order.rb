# knows just the information about the order: how to add materials to the order, how to count its total cost, its price,
# and print it
require './models/discount.rb'

class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :material, :items,  :total, :deliveries, :discount

  def initialize(material, discount = false)
    self.material = material
    self.items = []
    self.deliveries = []
    self.discount = discount
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
    deliveries << delivery.name
  end

  def total_price
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def discount_price
    discount.update_total(total_price, deliveries)
  end

  def total_cost
    discount ? discount_price : total_price
  end

  def add_discount(discount)
    self.discount ? raise("#{self.discount.error_msg}") : self.discount = discount
  end

  def remove_discount
   self.discount = false
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

end
