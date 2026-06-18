class DiscountRule 

  CONDITOIN_PRICE = 1000
  DISCOUNT_RATE = 0.9

  def apply(total)
    total >= CONDITOIN_PRICE ? total * DISCOUNT_RATE : total
  end

end