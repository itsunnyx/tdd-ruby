# frozen_string_literal: true

class DiscountRule
  def initialize(threshold, discount)
    @threshold = threshold
    @discount = discount
  end

  def apply(total)
    total >= @threshold ? total * @discount : total
  end
end
