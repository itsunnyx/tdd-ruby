class Cart
  def initialize(items = [])
    @items = items
  end

  def add_item(item)
    @items << item
  end

  def subtotal
    @items.sum(&:price)
  end

  def item_count
    @items.count
  end

  attr_reader :items
end