# frozen_string_literal: true

require_relative '../lib/cart'
require_relative '../lib/checkout'
require_relative '../lib/discount_rule'
require_relative '../lib/freebie_rule'
require_relative '../lib/item'

TOTAL_AMOUNT_CASES = [
  { name: 'Given no item, total amount should be 0', items: [], expected: 0 },
  { name: 'Given 1 item, total amount should be the price of the item', items: [10], expected: 10 },
  {
    name: 'Given 2 items, total amount should be the sum of the prices of the items',
    items: [10, 20],
    expected: 30
  },
  {
    name: 'Given 1 item and total amount is 1000, total amount should be the price of the item minus the discount',
    items: [1000],
    expected: 900
  },
  {
    name: 'Given 2 items and total amount more than 1000, ' \
          'total amount should be the price of the items minus the discount',
    items: [1000, 1000],
    expected: 1800
  }
].freeze

FREEBIES_CASES = [
  { name: 'Given empty cart, get 0 freebies', items: [], expected: 0 },
  { name: 'Given 3 items, get 1 freebie item', items: [1000, 1000, 1000], expected: 1 }
].freeze

describe Checkout do
  let(:discount_rule) { DiscountRule.new(1000, 0.9) }
  let(:freebie_rule) { FreebieRule.new(3, 1) }

  describe '#total_amount' do
    TOTAL_AMOUNT_CASES.each do |test_case|
      it test_case[:name] do
        checkout = build_checkout(test_case[:items])
        expect(checkout.total_amount).to eq(test_case[:expected])
      end
    end
  end

  describe '#freebies' do
    FREEBIES_CASES.each do |test_case|
      it test_case[:name] do
        checkout = build_checkout(test_case[:items])
        expect(checkout.freebies).to eq(test_case[:expected])
      end
    end
  end

  def build_checkout(item_prices)
    cart = Cart.new
    item_prices.each { |price| cart.add_item(Item.new('Item', price)) }
    Checkout.new(cart, discount_rule: discount_rule, freebie_rule: freebie_rule)
  end
end
