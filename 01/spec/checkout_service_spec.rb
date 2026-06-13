# frozen_string_literal: true

require_relative '../lib/cart'
require_relative '../lib/checkout_service'
require_relative '../lib/discount_rule'
require_relative '../lib/discount_rule_repository'
require_relative '../lib/freebie_rule'
require_relative '../lib/freebie_rule_repository'
require_relative '../lib/item'

describe CheckoutService do
  let(:discount_rule_repository) { instance_double(DiscountRuleRepository) }
  let(:freebie_rule_repository) { instance_double(FreebieRuleRepository) }
  let(:discount_rule) { DiscountRule.new(1000, 0.9) }
  let(:freebie_rule) { FreebieRule.new(3, 1) }
  let(:service) do
    CheckoutService.new(
      discount_rule_repository: discount_rule_repository,
      freebie_rule_repository: freebie_rule_repository
    )
  end

  before do
    allow(discount_rule_repository).to receive(:find_active).and_return(discount_rule)
    allow(freebie_rule_repository).to receive(:find_active).and_return(freebie_rule)
  end

  it 'loads active rules from repositories' do
    cart = Cart.new
    cart.add_item(Item.new('Item', 1000))

    service.for(cart).total_amount

    expect(discount_rule_repository).to have_received(:find_active)
    expect(freebie_rule_repository).to have_received(:find_active)
  end

  it 'applies whatever discount rule the repository returns' do
    custom_rule = DiscountRule.new(500, 0.8)
    allow(discount_rule_repository).to receive(:find_active).and_return(custom_rule)

    cart = Cart.new
    cart.add_item(Item.new('Item', 500))

    expect(service.for(cart).total_amount).to eq(400)
  end

  it 'applies whatever freebie rule the repository returns' do
    custom_rule = FreebieRule.new(2, 2)
    allow(freebie_rule_repository).to receive(:find_active).and_return(custom_rule)

    cart = Cart.new
    cart.add_item(Item.new('Item', 10))
    cart.add_item(Item.new('Item', 20))

    expect(service.for(cart).freebies).to eq(2)
  end
end
