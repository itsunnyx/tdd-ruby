class Checkout
  def initialize(cart, discount_rule:, freebie_rule:)
    @cart = cart
    @discount_rule = discount_rule
    @freebie_rule = freebie_rule
  end

  def total_amount
    @discount_rule.apply(@cart.subtotal)
  end

  def freebies
    @freebie_rule.apply(@cart.item_count)
  end
end