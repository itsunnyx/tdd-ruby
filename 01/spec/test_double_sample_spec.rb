# frozen_string_literal: true

# Sample: test double for a FAILING database scenario (TDD red phase).
#
# Scenario: the database has no active discount rule.
# We stub the repository to return nil — no real database needed.
#
# Run alone to see the failure:
#   bundle exec rspec spec/test_double_sample_spec.rb
#
# Expected behavior (not implemented yet):
#   CheckoutService should raise MissingDiscountRuleError
# Actual behavior today:
#   NoMethodError — nil.apply(...)

require_relative '../lib/cart'
require_relative '../lib/checkout_service'
require_relative '../lib/discount_rule_repository'
require_relative '../lib/freebie_rule'
require_relative '../lib/freebie_rule_repository'
require_relative '../lib/item'

class MissingDiscountRuleError < StandardError; end

describe 'Test double sample: failing scenario' do
  it 'raises when database has no active discount rule', :failing_sample do
    discount_repo = instance_double(DiscountRuleRepository)
    freebie_repo = instance_double(FreebieRuleRepository)

    # Stub: pretend the database query returned nothing
    allow(discount_repo).to receive(:find_active).and_return(nil)
    allow(freebie_repo).to receive(:find_active).and_return(FreebieRule.new(3, 1))

    service = CheckoutService.new(
      discount_rule_repository: discount_repo,
      freebie_rule_repository: freebie_repo
    )

    cart = Cart.new
    cart.add_item(Item.new('Item', 1000))

    expect { service.for(cart).total_amount }.to raise_error(MissingDiscountRuleError)
  end
end
