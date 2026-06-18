class Item

  attr_reader :name, :price

  def initialize(name:, price:)
    raise 'price must be positive' if price < 0
    @name = name
    @price = price
  end
  
end