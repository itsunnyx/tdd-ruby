require_relative 'discount_rule'
require_relative 'freebie_rule'

class Cart

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def calculateAmount()
    total = @items.sum(&:price)
    # total >= CONDITOIN_PRICE ? total * DISCOUNT_RATE : total
    DiscountRule.new.apply(total)
  end

  def getFreebie()
    # @items.count >= CONDITION_FREEBIE ? FREEBIE : 0
    FreebieRule.new.apply(@items.count)
  end

end