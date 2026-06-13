# frozen_string_literal: true

require_relative 'checkout'
require_relative 'discount_rule_repository'
require_relative 'freebie_rule_repository'

class CheckoutService
  def initialize(
    discount_rule_repository: DiscountRuleRepository.new,
    freebie_rule_repository: FreebieRuleRepository.new
  )
    @discount_rule_repository = discount_rule_repository
    @freebie_rule_repository = freebie_rule_repository
  end

  def for(cart)
    Checkout.new(
      cart,
      discount_rule: @discount_rule_repository.find_active,
      freebie_rule: @freebie_rule_repository.find_active
    )
  end
end
